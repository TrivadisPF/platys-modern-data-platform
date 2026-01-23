---
technologies:       kafka
version:				1.19.0
validated-at:			21.01.2026
---

# Using Shadowtraffic for simulating production traffic on Kafka

This recipe will show how to use the [Shadowtraffic](https://shadowtraffic.io/) for simulating messages on Kafka. 

## Initialise data platform

First [initialise a platys-supported data platform](../documentation/getting-started) with the needed services enabled and generate the platform:

```bash
platys init --enable-services KAFKA,AKHQ,SHADOW_TRAFFIC -s trivadis/platys-modern-data-platform -w 1.19.0
```

Now generate the platform 

```bash
platys gen
```

before starting the platform, create a shadowtraffic recipe by creating a `kafka.json` file inside the `./scrips/shadowtraffic` folder. You can find various examples in this [GitHub project](https://github.com/ShadowTraffic/shadowtraffic-examples/tree/master):

Here the definition taken from [`customers-orders.json`](https://github.com/ShadowTraffic/shadowtraffic-examples/blob/master/customers-orders.json):

```json
{
    "generators": [
        {
            "topic": "customers",
            "value": {
                "customerId": { "_gen": "uuid" },
                "name": {
                    "_gen": "string", "expr": "#{Name.fullName}"
                },
                "birthday": {
                    "_gen": "string", "expr": "#{Date.birthday '18','80'}"
                },
                "directSubscription": {
                    "_gen": "boolean"
                },
                "membershipLevel": {
                    "_gen": "oneOf", "choices": ["free", "pro", "elite"]
                },
                "shippingAddress": {
                    "_gen": "string", "expr": "#{Address.fullAddress}"
                },
                "activationDate": {
                    "_gen": "formatDateTime",
                    "ms": {
                        "_gen": "uniformDistribution",
                        "bounds": [ 1710176905, { "_gen": "now" } ]
                    }
                }
            }
        },
        {
            "topic": "orders",
            "value": {
                "orderId": { "_gen": "uuid" },
                "customerId": {
                    "_gen": "lookup",
                    "topic": "customers",
                    "path": ["value", "customerId"]
                },
                "orderNumber": {
                    "_gen": "sequentialInteger"
                },
                "product": { "_gen": "string", "expr": "#{Commerce.productName}" },
                "backordered": {
                    "_gen": "weightedOneOf",
                    "choices": [
                        { "weight": 19, "value": false },
                        { "weight": 1,  "value": true }
                    ]
                },
                "cost": {
                    "_gen": "normalDistribution",
                    "mean": 100,
                    "sd": 20
                },
                "description": { "_gen": "string", "expr": "#{Lorem.paragraph}" },
                "create_ts": { "_gen": "now" },
                "creditCardNumber": { "_gen": "string", "expr": "#{Business.creditCardNumber}" },
                "discountPercent": {
                    "_gen": "uniformDistribution",
                    "bounds": [0, 10],
                    "decimals": 0
                }
            }
        }
    ],
    "connections": {
        "dev-kafka": {
            "kind": "kafka",
            "producerConfigs": {
                "bootstrap.servers": "kafka-1:19092",
                "key.serializer": "io.shadowtraffic.kafka.serdes.JsonSerializer",
                "value.serializer": "io.shadowtraffic.kafka.serdes.JsonSerializer"
            }
        }
    }
}
```

Start the platform

```bash
docker-compose up -d
```

Navigate to <http://dataplatform:28107> to see the traffic on Kafka.

