# Uising the Trino Gateway

```
platys init --enable-services TRINO,TRINO_CLI,TRINO_GATEWAY,POSTGRESQL, -s trivadis/platys-modern-data-platform -w develop -f
```

create the following resource groups for Trino

`./custom-conf/trino/resource-groups/resource-groups.json`

```
{
  "rootGroups": [
    {
      "name": "global",
      "softMemoryLimit": "1GB",
      "maxQueued": 100,
      "hardConcurrencyLimit": 2,
      "schedulingPolicy": "fair",
      "subGroups": [
        {
          "name": "adhoc",
          "hardConcurrencyLimit": 1,
          "maxQueued": 10,
          "softMemoryLimit": "512MB",
          "schedulingPolicy": "query_priority"
        }
      ]
    }
  ],
  "selectors": [
    {
      "user": "trino",
      "queryType": "SELECT",
      "group": "global.adhoc"
    }
  ]
}
```

When Trino Gateway is running, you can add the two Trino instances to the trino gateway:

```bash
curl -X POST http://$PUBLIC_IP:28270/entity?entityType=GATEWAY_BACKEND \
  -d "{
        \"name\": \"trino-1\",
        \"proxyTo\": \"http://$PUBLIC_IP:28082\",
        \"active\": true,
        \"routingGroup\": \"adhoc\"
      }" \
  -H "Content-Type: application/json"

curl -X POST http://$PUBLIC_IP:28270/entity?entityType=GATEWAY_BACKEND \
  -d "{
        \"name\": \"trino-2\",
        \"proxyTo\": \"http://$PUBLIC_IP:28083\",
        \"active\": true,
        \"routingGroup\": \"etl\"
      }" \
  -H "Content-Type: application/json"
```

Execute a SQL statement in background

```bash
docker exec trino-cli trino --server http://trino-gateway:8080 \
                                     --user trino --execute "SELECT count(*) FROM tpch.sf1000.customer" &
```



## Using StochasticRoutingManager

```bash
      #
      # ===== Trino ========
      #
      TRINO_enable: true
      TRINO_clusters: 2
            
      TRINO_with_tpch_catalog: true      
      
      #
      # ===== Trino Gateway ========
      #
      TRINO_GATEWAY_enable: true
      TRINO_GATEWAY_volume_map_config_file: false        
      TRINO_GATEWAY_rules_engine_enabled: false
      TRINO_GATEWAY_modules_enabled: ''

```

## Using QueryCountBasedRouter

```yaml
      #
      # ===== Trino ========
      #
      TRINO_enable: true
      TRINO_clusters: 2
            
      TRINO_with_tpch_catalog: true      
      
      #
      # ===== Trino Gateway ========
      #
      TRINO_GATEWAY_enable: true
      TRINO_GATEWAY_volume_map_config_file: false        
      TRINO_GATEWAY_rules_engine_enabled: false
      # strategy for performing health checks: one of 'NOOP', 'INFO_API', 'UI_API', 'JDBC', 'JMX', 'METRICS'
      TRINO_GATEWAY_monitor_type: 'METRICS'     
      TRINO_GATEWAY_modules_enabled: 'query-based-count-router'
```

## Using Internal Rule Service

```yaml
      #
      # ===== Trino ========
      #
      TRINO_enable: true
      TRINO_clusters: 2
            
      TRINO_with_tpch_catalog: true      
      
      #
      # ===== Trino Gateway ========
      #
      TRINO_GATEWAY_enable: true
      TRINO_GATEWAY_volume_map_config_file: false        
      TRINO_GATEWAY_rules_engine_enabled: true
      TRINO_GATEWAY_rules_type: INTERNAL
      TRINO_GATEWAY_rules_file: 'routing_rules.yml'
      TRINO_GATEWAY_analyze_request_enabled: true
```

with the following rules config in `./scripts/trino-gateway/rules/routing-rules.yml`

```yaml
---
name: "etl"
description: "if query is a batch transformation, route to etl group"
condition: 'request.getHeader("X-Trino-Source") == "batch"'
actions:
  - 'result.put("routingGroup", "etl")'
---
name: "adhoc-query"
description: "if query is an ad-hoc query with 'fast-lane' tag"
condition: 'request.getHeader("X-Trino-Source") == "dashboard" && request.getHeader("X-Trino-Client-Tags") contains "fast-lane"'
actions:
  - 'result.put("routingGroup", "adhoc")'
```

Let's execute a batch query

`./data-transfer/batch.sql`

```
SELECT r.*, node_id FROM system.runtime.nodes, 
(SELECT
  l_orderkey,
  sum(l_extendedprice * (1 - l_discount)) AS revenue,
  o_orderdate,
  o_shippriority
FROM
  tpch.sf10.customer,
  tpch.sf10.orders,
  tpch.sf10.lineitem
WHERE
  c_mktsegment = 'BUILDING'
  AND c_custkey = o_custkey
  AND l_orderkey = o_orderkey
  AND o_orderdate < DATE '1995-03-15'
  AND l_shipdate > DATE '1995-03-15'
GROUP BY
  l_orderkey,
  o_orderdate,
  o_shippriority
ORDER BY
  revenue DESC,
  o_orderdate,
  l_orderkey
LIMIT 10) r;
```

```bash
docker exec -i trino-cli trino --server http://trino-gateway:8080  --user trino --source="batch" --file /data-transfer/batch.sql
```

in the log for the trino-gateway you will see that it has been routed to `trino-2`

```bash
2025-06-19T07:32:30.367Z	INFO	pool-4-thread-1	io.trino.gateway.ha.clustermonitor.ActiveClusterMonitor	Getting stats for all active clusters
2025-06-19T07:32:31.096Z	INFO	pool-4-thread-1	io.trino.gateway.ha.router.RoutingManager	backend trino-1 isHealthy HEALTHY
2025-06-19T07:34:07.004Z	INFO	http-worker-64	io.trino.gateway.ha.handler.RoutingTargetHandler	Rerouting [http://192.168.147.3:8080/v1/statement]--> [http://10.158.124.12:28083/v1/statement]
```bash


```bash
docker exec -ti trino-cli trino --server http://trino-gateway:8080  --user trino --execute "select node_id, c.nof from system.runtime.nodes, (SELECT count(*) nof FROM tpch.sf100.customer) as c" --client-info "fast-lane" --client-tags="fast-lane" --source="dashboard"
```

in the log for the trino-gateway you will see that it has been routed to `trino-1`

```bash
2025-06-19T07:35:30.369Z	INFO	pool-4-thread-1	io.trino.gateway.ha.clustermonitor.ActiveClusterMonitor	Getting stats for all active clusters
2025-06-19T07:35:30.652Z	INFO	pool-4-thread-1	io.trino.gateway.ha.router.RoutingManager	backend trino-1 isHealthy HEALTHY
2025-06-19T07:35:30.653Z	INFO	pool-4-thread-1	io.trino.gateway.ha.router.RoutingManager	backend trino-2 isHealthy HEALTHY
2025-06-19T07:36:11.491Z	INFO	http-worker-64	io.trino.gateway.ha.handler.RoutingTargetHandler	Rerouting [http://192.168.147.3:8080/v1/statement]--> [http://10.158.124.12:28082/v1/statement]
```

## Using External Rule Service

```yaml
      #
      # ===== Trino ========
      #
      TRINO_enable: true
      TRINO_clusters: 2
            
      TRINO_with_tpch_catalog: true      
      
      #
      # ===== Trino Gateway ========
      #
      TRINO_GATEWAY_enable: true
      TRINO_GATEWAY_volume_map_config_file: false        
      TRINO_GATEWAY_rules_engine_enabled: true
      TRINO_GATEWAY_rules_type: EXTERNAL
      TRINO_GATEWAY_url_path: 'http://trino-gateway-external-routing-service:9000/debug-routing-info'
      TRINO_GATEWAY_analyze_request_enabled: true
```

Add the following [example service rule service](https://github.com/willmostly/routing-app-example) to the docker compose override file.

`docker-compose.override.yml`

```yaml
services:

  trino-gateway-external-routing-service:
    image: willmo/routing-service:0.2
    container_name: trino-gateway-external-routing-service
    hostname: trino-gateway-external-routing-service
    labels:
      com.platys.name: trino-gateway-external-routing-service
      com.platys.description: Trino Gateway External Routing Service
    ports:
      - "28530:9000"
    environment:
      - PYTHONUNBUFFERED=1
    command: ["gunicorn", "-w", "1", "--bind", "0.0.0.0:9000", "getrouting:app"]
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:9000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

```bash
docker logs -f trino-gateway-external-routing-service
```

```bash
docker exec -ti trino-cli trino --server http://trino-gateway:8080  --user trino --execute "select node_id, c.nof from system.runtime.nodes, (SELECT count(*) nof FROM tpch.sf100.customer) as c" --client-info "etl" --client-tags="etl"
```

```bash
guido.schmutz@AMAXDKFVW0HYY ~/w/platys-demo3> docker logs -f trino-gateway-external-routing-service
[2025-06-18 18:44:02 +0000] [1] [INFO] Starting gunicorn 23.0.0
[2025-06-18 18:44:02 +0000] [1] [INFO] Listening at: http://0.0.0.0:9000 (1)
[2025-06-18 18:44:02 +0000] [1] [INFO] Using worker: sync
[2025-06-18 18:44:03 +0000] [7] [INFO] Booting worker with pid: 7
Headers: Content-Type: text/plain; charset=UTF-8
Host: trino-gateway:8080
User-Agent: StatementClientV1/443
X-Trino-Client-Capabilities: PATH,PARAMETRIC_DATETIME,SESSION_AUTHORIZATION
X-Trino-Client-Info: etl
X-Trino-Client-Tags: etl
X-Trino-Language: en-US
X-Trino-Original-User: trino
X-Trino-Source: trino-cli
X-Trino-Time-Zone: GMT
X-Trino-Transaction-Id: NONE
X-Trino-User: trino
Content-Length: 636


Deserialized data: RoutingGroupExternalBody(trinoQueryProperties=TrinoQueryProperties(isQueryParsingSuccessful=True, body='SELECT count(*) FROM tpch.sf1000.customer', queryType='Query', resourceGroupQueryType='SELECT', tables=['tpch.sf1000.customer'], defaultCatalog=None, defaultSchema=None, catalogs={'tpch'}, schemas={'sf1000'}, catalogSchemas={'tpch.sf1000'}, isNewQuerySubmission=True, errorMessage=None), trinoRequestUser=TrinoRequestUser(user='trino', userInfo=None), contentType='application/json', remoteUser=None, method='POST', requestURI='/v1/statement', queryString=None, session=None, remoteAddr='192.168.147.3', remoteHost='192.168.147.3', parameters={})

RoutingGroupExternalResponse(routingGroup='benchmarking', errors=[])
```