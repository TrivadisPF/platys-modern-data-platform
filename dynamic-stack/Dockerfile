FROM python:3.8.0-alpine3.10
RUN pip install docker-compose-templer && mkdir /opt/analytics-generator && chmod 777 -R /opt/analytics-generator
COPY ./generator-config /opt/analytics-generator
COPY ./static-data /opt/static-data

# we asume that the output volume is mapped to /opt/analytics-generator/stacks
CMD ["sh", "-c", "cp -r /opt/static-data/* /opt/analytics-generator/stacks && docker-compose-templer -v -f /opt/analytics-generator/stack-config.yml"  ]
