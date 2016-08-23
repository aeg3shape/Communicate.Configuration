docker-compose -f docker-compose.yml -f docker-compose.production.yml up -d
docker-compose -f docker-compose.yml -f docker-compose.production.yml scale es-master=5 es-data=4 es-client=4 logstash=4 kibana=4
docker-compose -f docker-compose.yml -f docker-compose.production.yml ps