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

## Handling data with GraphQL playground

Open GraphQL playground: `http://localhost:1337/graphql`

### Queries

- With fragments:

```query
fragment imageData on UploadFile {
  alternativeText
  url
}

fragment logo on LandingPage {
  logo{
    ...imageData
  }
}

fragment header on LandingPage{
  header{
    title
    description
    button{
      label
      url
    }
    image{
      ...imageData
    }
  }
}

query GET_LANDING_PAGE {
  landingPage {
    createdAt: created_at
    ...logo
    ...header
  }
}
```

- With dynamic param

```query
query GET_AUTHOR($id: ID!) {
  author(id: $id) {
  created_at
  updated_at
  name
  role
  description
  published_at
  }
}
```

and declare query variable:

```query
{
  "id": 5
}
```

- Other example

```query
query GET_LPS {
  landingPage {
    logo{
      alternativeText
      url
    }
    header{
    	title
      description
    }
  }
  
  authors{
    id
    name
    description
  }  
}
```

### Mutations

- Named mutation

```mutation
mutation UPDATE_AUTHOR {
  updateAuthor(
    input: { where: { id: 4 },
    data: { name: "Xunda" } }
  ) {
    author {
      id
      name
      role
    }
  }
}
```

- Parametrized mutation

```mutation
mutation UPDATE_AUTHOR($id: ID!, $data: editAuthorInput) {
  updateAuthor(input: { where: { id: $id }, data: $data }) {
    author {
      id
      name
      role
    }
  }
}
```

and in Query Variables:

```mutation
{
  "id": 7,
  "data": {
    "name": "xunda2"
  }  
}
```

- Create Mutation

```mutation
mutation CREATE_AUTHOR {
  createAuthor(
    input: {
      data: {
        name: "New Instructor"
        role: "Instructor"
        description: "blha blah"
      }
    }
  ) {
    author {
      id
      name
      role
      description
    }
  }
}
```