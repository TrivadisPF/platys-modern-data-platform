#
#  Author: Guido Schmutz
#  Date: 2020-07-27
#
#  https://github.com/trivadispf/docker-presto-cli
#
FROM alpine:latest

COPY airports-data /data/airports-data
COPY flight-data /data/flight-data
COPY graphdb-news /data/graphdb-news
COPY wordcount /data/wordcount
COPY adventureworks /data/adventureworks
COPY imdb-movies /data/imdb-movies
COPY platys-cookbooks /data/platys-cookbooks

# copy the generator script and make it executable
COPY run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh

CMD run.sh
