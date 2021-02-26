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

## Insert data on database

First, copy strapi.sql to docker container:

```shell
docker cp strapi.sql d5e1010362ab:/strapi.sql 
```

Connect on docker container:

```shell
docker exec -it d5e1010362ab bash
```

Run:

```shell
psql -h 127.0.0.1 -U strapi -d strapi -W < strapi.sql
```

## Generate dump from database

Connect on docker container:

```shell
docker exec -it d5e1010362ab bash
```

Generate dump file from database:

```shell
pg_dump -c --if-exists --exclude-table=strapi_administrator -h 127.0.0.1 -U strapi -d strapi -W > strapi_dump.sql
```

## Getting data with GraphQL playground

Open GraphQL playground: `http://localhost:1337/graphql`

```query
{
  author(id:5) {
  created_at
  updated_at
  name
  role
  description
  published_at
  }
}
```

Or

```query
{
  authors{
    id
    name
  }
}
```
