#
#  Author: Guido Schmutz
#  Date: 2020-07-27
#
#  https://github.com/trivadispf/docker-presto-cli
#
FROM alpine:latest

COPY airport-data /data/airport-data
COPY flight-data /data/flight-data
COPY graphdb-news /data/graphdb-news
COPY wordcount /data/wordcount
COPY adventureworks /data/adventureworks
COPY imdb-movies /data/imdb-movies
COPY movie-lens-small /data/movie-lens-small
COPY platys-cookbooks /data/platys-cookbooks
COPY nyc-film-permits /data/nyc-film-permits
COPY orion-star /data/orion-star
COPY duckdb /data/duckdb
COPY dvdrental /data/dvdrental
COPY ecommerce /data/ecommerce

# copy the run script and make it executable
COPY run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh

CMD run.sh
