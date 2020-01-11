FROM python:3.8.0-alpine3.10
RUN pip install docker-compose-templer && mkdir /opt/analytics-generator && chmod 777 -R /opt/analytics-generator
COPY ./generator-config /opt/analytics-generator
COPY ./static-data /opt/static-data

COPY generate.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/generate.sh


# we asume that the output volume is mapped to /opt/analytics-generator/stacks
CMD generate.sh
