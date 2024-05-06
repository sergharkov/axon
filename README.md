# App in container  

## 1) Install:
- docker v 26.1.1 +
- docker compose v v2.27.0 +
- user in docker group

## 2) Preparing parameters for services
- preparing  .env.local
```
# app
MODE=dev
HOST=0.0.0.0
PORT=3001
TOKEN_NAME=eth
TOKEN_DENOM=uknow

# osmosis
OSMOSIS_BASE_URL=https://api-osmosis.imperator.co

# okp4
OKP4_BASE_URL=https://api.drunemeton.okp4.network

# db
DATABASE_URL="postgresql://postgres:password@timescaledb:5432/test?schema=public"

# redis
REDIS_HOST=some-redis
REDIS_PORT=6379
```
- recheck file(hope in nearest PR will fix it) package.json
https://github.com/sergharkov/axon/blob/main/package.json
### needed present start yarn script
```
"dev": "npx dotenvx run --env-file=.env.local -- npx prisma migrate deploy && npm run prisma:generate && dotenvx run --env-file=.env.local -- nest start --watch --debug",
```


## 3) Run docker services by commands:
```
cd /axon/
APPTAG=$(date +%d.%m.%y_%H.%M)  docker-compose --file docker/docker-compose.yaml config > docker/docker-compose.run.yaml
docker compose -f docker/docker-compose.run.yaml up -d && docker ps
docker logs docker_axon-app_1
docker logs docker_axon-app_1
docker exec -it docker_axon-app_1 sh 
```

### 4) Add rules to firewall for app port 3001
or you can temporary disable firewall
```
sudo systemctl stop ufw.service
```
and don't forgot about  SELinux

### 5) Get result
- go to url
```
curl $(curl icanhazip.com):3001
```
got something like:
```
{
  "message": "Cannot GET /",
  "error": "Not Found",
  "statusCode": 404
}
```
