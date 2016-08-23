docker-compose -f docker-compose.yml -f docker-compose.production.yml up -d
docker-compose -f docker-compose.yml -f docker-compose.production.yml scale es-master=5 es-data=4 es-client=3 logstash=3 kibana=3
docker-compose -f docker-compose.yml -f docker-compose.production.yml ps