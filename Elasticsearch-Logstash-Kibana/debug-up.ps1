docker-compose -f docker-compose.yml -f docker-compose.debug.yml up -d
docker-compose scale es-master=5 es-data=4
docker-compose ps