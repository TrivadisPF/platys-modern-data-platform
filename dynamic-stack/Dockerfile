FROM python:3.8.0-alpine3.10

# install docker-compose-templer
RUN pip install docker-compose-templer && mkdir /opt/mdps-generator && chmod 777 -R /opt/mdps-generator

# copy generator config into the image (templates & config.yml)
COPY ./generator-config /opt/mdps-generator

# copy static data needed for the stack to run into the image
COPY ./static-data /opt/static-data

# copy the generator script and make it executable
COPY generate.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/generate.sh

# we asume that the output volume is mapped to /opt/analytics-generator/stacks
CMD generate.sh
