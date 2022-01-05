# Postgres Explain Visualizer V2
## Dependencies
- Traefik

## Add Host
```
echo 127.0.0.1  pev2.local >> /etc/hosts
```

## Start
```
# If the network does not exist
docker network create --driver bridge network-dev || true

# Start
docker-compose up -d
```