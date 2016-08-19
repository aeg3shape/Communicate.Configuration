docker-compose -f docker-compose.yml -f docker-compose.staging.yml up -d
docker-compose scale es-master=5 es-data=4 es-client=3 logstash=3 kibana=3
docker-compose ps