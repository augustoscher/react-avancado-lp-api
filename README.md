# react-avancado-lp-api

Strapi backend for react avançado lp project

## Running

With logs:

```bash
make run-logs
```

without logs:

```bash
make run
```

## Running sql on database

First, copy strapi.sql to container:

```shell
docker cp strapi.sql d5e1010362ab:/strapi.sql 
```

Enter in docker container:

```shell
docker exec -it d5e1010362ab bash
```

Run:

```shell
psql -h 127.0.0.1 -U strapi -d strapi -W < strapi.sql
```
