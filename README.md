# Compounds

## Getting started

### Dependancies

elixir: 1.11.3
erlang: 23.\*

alternatively docker can be used
in which case [docker](https://docs.docker.com/get-docker/), and [docker-compose](https://docs.docker.com/compose/install/) will need to be installed.

### Running the app

#### bare metal

There is a reliance on a running postgres instance in order to run.

You can bring up a local postgres easily by running `docker-compose up postgres`

you can then bring up the phoenix up by running the following.

```
mix deps.get
mix ecto.create
mix ecto.migrate

iex -S phx.server
```

#### Docker

The app can be brought up using docker compose `docker-compose up` by default it stands up on local port 6000, this can be configured in the `docker-compose.yml` file.

## Tests

The tests can be run through their own docker-compose file `docker-compose-test.yml`

```
docker-compose -f docker-compose-test.yml up --exit-code-from compounds
```

## api

A full list of api routes can be obtained by navigating to `/` on the web service.

## Seeding the database

There are two methods of seeding the database, the first and easiest is the bulk endpoint `/api/bulk/compounds' It accepts a json body that conforms to the schema located at `priv/json_schema/compounds_schema.json`

The second method of seeding the database is through a mix task this takes the form of 
```
mix Compounds.SeedFromFile --file {path to file}
```

alternatively it can be run through docker using 
```
docker build . --target seed --tag compound_seeder
docker run \
--env DB_USER=postgres \
--env DB_PASS=postgres \
--env DB_NAME=postgres \
--env DB_HOST=localhost \
--env SEED_FILE=compounds.json \
--network=host
--mount type=bind,source="$(pwd)",target=/app/seed \
--rm -it compound_seeder
```

Run the second command inside the directory that the compound files are in as it will be mounted to the container, and set the `SEED_FILE` env var to it's file name e.g. `compounds.json`

## assumptions

I have forgone creating an images endpoint, as I would have used a CDN such as s3 or gcloud storage. 