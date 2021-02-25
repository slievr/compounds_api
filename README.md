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

The app can be brought up using docker compose `docker-compose up --build` by default it stands up on local port 4000, this can be configured in the `docker-compose.yml` file.

## Tests

The tests can be run through their own docker-compose file `docker-compose-test.yml`

```
docker-compose -f docker-compose-test.yml up --exit-code-from compounds
```

## api

A full list of api routes can be obtained by navigating to `/` on the web service. While running the container with `MIX_ENV=test`.

As by default the container is running in prod mode the routes have been added below

### routes
#### compounds

- GET /api/compounds
- GET /api/compounds/[id]
- POST /api/compounds
- PATCH /api/compounds/[id]
- PUT /api/compounds/[id]
- DELETE /api/compounds/[id] 

DELETES will fail if trying to delete compounds with assay_results

Example POST
```
curl --location --request POST 'localhost:4000/api/compounds' \
--header 'Content-Type: application/json' \
--data-raw '{
    "compound" :{
        "smiles": "CCOC1=CC(=O)N(C)C=C1c2cc(NC(=O)CCCC(=O)Nc3ccccc3)ccc2Oc4ccc(F)cc4F",
        "molecular_weight": 561.57587,
        "ALogP": 3.945,
        "molecular_formula": "C31H29F2N3O5",
        "num_rings": 4,
        "image": "images/2099305.png"
    }
}'
```

#### assay_results

- GET /api/assay_results
- GET /api/assay_results/[id]
- POST /api/assay_results
- PATCH /api/assay_results/[id]
- PUT /api/assay_results/[id]
- DELETE /api/assay_results/[id]

Example POST
```
curl --location --request POST 'localhost:4000/api/assay_results' \
--header 'Content-Type: application/json' \
--data-raw '{
    "assay_result": {
        "operator": "=",
        "result": "IC50",
        "result_id": 553,
        "target": "Bromodomain-containing protein 4",
        "unit": "nM",
        "value": 500.0
    }
}'
```

#### bulk
PUT /api/bulk/compounds
## Seeding the database

There are two methods of seeding the database, the first and easiest is the bulk endpoint `/api/bulk/compounds` It accepts a json body that conforms to the schema located at `priv/json_schema/compounds_schema.json`

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

docker run \
--env DB_USER=postgres \
--env DB_PASS=postgres \
--env DB_NAME=postgres \
--env DB_HOST=localhost \
--network=host
--rm -it compounds

Run the second command inside the directory that the compound files are in as it will be mounted to the container, and set the `SEED_FILE` env var to it's file name e.g. `compounds.json`

### Example

<details>
  <summary>Example curl</summary>
```
curl --location --request PUT 'localhost:4000/api/bulk/compounds' \
--header 'Content-Type: application/json' \
--data-raw '[
    {
        "compound_id": 2099305,
        "smiles": "CCOC1=CC(=O)N(C)C=C1c2cc(NC(=O)CCCC(=O)Nc3ccccc3)ccc2Oc4ccc(F)cc4F",
        "molecular_weight": 561.57587,
        "ALogP": 3.945,
        "molecular_formula": "C31H29F2N3O5",
        "num_rings": 4,
        "image": "images/2099305.png",
        "assay_results": [
            {
                "result_id": 17790202,
                "target": "Bromodomain-containing protein 4",
                "result": "Ki",
                "operator": "=",
                "value": 284,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 2125660,
        "smiles": "CCOC1=CC(=O)N(C)C=C1c2cc(NC(=O)Cc3noc4ccccc34)ccc2Oc5ccc(F)cc5F",
        "molecular_weight": 531.50683,
        "ALogP": 4.27,
        "molecular_formula": "C29H23F2N3O5",
        "num_rings": 5,
        "image": "images/2125660.png",
        "assay_results": [
            {
                "result_id": 17790198,
                "target": "Bromodomain-containing protein 4",
                "result": "Ki",
                "operator": "=",
                "value": 137,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 2176417,
        "smiles": "CCOC1=CC(=O)N(C)C=C1c2cc(NC(=O)Cc3cccc4ccccc34)ccc2Oc5ccc(F)cc5F",
        "molecular_weight": 540.55665,
        "ALogP": 5.096,
        "molecular_formula": "C32H26F2N2O4",
        "num_rings": 5,
        "image": "images/2176417.png",
        "assay_results": [
            {
                "result_id": 17790193,
                "target": "Bromodomain-containing protein 4",
                "result": "Ki",
                "operator": "=",
                "value": 140,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 2098840,
        "smiles": "CCOC1=CC(=O)N(C)C=C1c2cc(NC(=O)Nc3cccc(OC)c3)ccc2Oc4ccc(F)cc4F",
        "molecular_weight": 521.51201,
        "ALogP": 4.045,
        "molecular_formula": "C28H25F2N3O5",
        "num_rings": 4,
        "image": "images/2098840.png",
        "assay_results": [
            {
                "result_id": 17790184,
                "target": "Bromodomain-containing protein 4",
                "result": "Ki",
                "operator": "=",
                "value": 1030,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 2137553,
        "smiles": "CCOC1=CC(=O)N(C)C=C1c2cc(NC(=O)Nc3ccc(OC(F)(F)F)cc3)ccc2Oc4ccc(F)cc4F",
        "molecular_weight": 575.4834,
        "ALogP": 6.181,
        "molecular_formula": "C28H22F5N3O5",
        "num_rings": 4,
        "image": "images/2137553.png",
        "assay_results": [
            {
                "result_id": 17790180,
                "target": "Bromodomain-containing protein 4",
                "result": "Ki",
                "operator": ">",
                "value": 2380,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 2107746,
        "smiles": "CCOC1=CC(=O)N(C)C=C1c2cc(NCc3ncccc3C)ccc2Oc4ccc(F)cc4F",
        "molecular_weight": 477.50251,
        "ALogP": 4.311,
        "molecular_formula": "C27H25F2N3O3",
        "num_rings": 4,
        "image": "images/2107746.png",
        "assay_results": [
            {
                "result_id": 17790174,
                "target": "Bromodomain-containing protein 4",
                "result": "Ki",
                "operator": "=",
                "value": 320,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 2167381,
        "smiles": "CCOC1=CC(=O)N(C)C=C1c2cc(NC(=O)Cn3ccc(n3)c4ccccc4F)ccc2Oc5ccc(F)cc5F",
        "molecular_weight": 574.54981,
        "ALogP": 4.807,
        "molecular_formula": "C31H25F3N4O4",
        "num_rings": 5,
        "image": "images/2167381.png",
        "assay_results": [
            {
                "result_id": 17790170,
                "target": "Bromodomain-containing protein 4",
                "result": "Ki",
                "operator": ">",
                "value": 2380,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 2152891,
        "smiles": "CCOC1=CC(=O)N(C)C=C1c2cc(NC(=O)Cc3ccc4OCCCc4c3)ccc2Oc5ccc(F)cc5F",
        "molecular_weight": 546.56123,
        "ALogP": 4.702,
        "molecular_formula": "C31H28F2N2O5",
        "num_rings": 5,
        "image": "images/2152891.png",
        "assay_results": [
            {
                "result_id": 17790164,
                "target": "Bromodomain-containing protein 4",
                "result": "Ki",
                "operator": "=",
                "value": 271,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 1440191,
        "smiles": "COc1ccccc1S(=O)(=O)Nc2ccc3NC(=O)N(C)Cc3c2",
        "molecular_weight": 347.38888,
        "ALogP": 1.376,
        "molecular_formula": "C16H17N3O4S",
        "num_rings": 3,
        "image": "images/1440191.png",
        "assay_results": [
            {
                "result_id": 13477950,
                "target": "Bromodomain-containing protein 4",
                "result": "Kd",
                "operator": "=",
                "value": 136,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 1585157,
        "smiles": "COc1cc2c3NC(=O)N([C@H](C)c4ccccn4)c3cnc2cc1c5c(C)onc5C",
        "molecular_weight": 415.44454,
        "ALogP": 2.601,
        "molecular_formula": "C23H21N5O3",
        "num_rings": 5,
        "image": "images/1585157.png",
        "assay_results": [
            {
                "result_id": 13477951,
                "target": "Bromodomain-containing protein 4",
                "result": "Kd",
                "operator": "=",
                "value": 100,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 1524804,
        "smiles": "Cc1onc(C)c1c2cc(O)cc(c2)[C@H](O)c3ccccc3",
        "molecular_weight": 295.33248,
        "ALogP": 2.996,
        "molecular_formula": "C18H17NO3",
        "num_rings": 3,
        "image": "images/1524804.png",
        "assay_results": [
            {
                "result_id": 12679312,
                "target": "Bromodomain-containing protein 4",
                "result": "Kd",
                "operator": "=",
                "value": 360,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 1524811,
        "smiles": "Cc1onc(C)c1c2cc(O)cc(c2)[C@@H](O)c3ccccc3",
        "molecular_weight": 295.33248,
        "ALogP": 2.996,
        "molecular_formula": "C18H17NO3",
        "num_rings": 3,
        "image": "images/1524811.png",
        "assay_results": [
            {
                "result_id": 12679259,
                "target": "Bromodomain-containing protein 4",
                "result": "Kd",
                "operator": "=",
                "value": 390,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 1442535,
        "smiles": "Cc1onc(C)c1c2ccc(C)c(c2)S(=O)(=O)N3CCNCC3",
        "molecular_weight": 335.42124,
        "ALogP": 1.255,
        "molecular_formula": "C16H21N3O3S",
        "num_rings": 3,
        "image": "images/1442535.png",
        "assay_results": [
            {
                "result_id": 12161642,
                "target": "Bromodomain-containing protein 4",
                "result": "IC50",
                "operator": "=",
                "value": 12000,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 1442562,
        "smiles": "COc1ccc(NS(=O)(=O)c2cc(ccc2C)c3c(C)onc3C)cc1",
        "molecular_weight": 372.4381,
        "ALogP": 3.188,
        "molecular_formula": "C19H20N2O4S",
        "num_rings": 3,
        "image": "images/1442562.png",
        "assay_results": [
            {
                "result_id": 12161657,
                "target": "Bromodomain-containing protein 4",
                "result": "IC50",
                "operator": "=",
                "value": 5600,
                "unit": "nM"
            }
        ]
    },
    {
        "compound_id": 1442549,
        "smiles": "Cc1onc(C)c1c2ccc(C)c(c2)S(=O)(=O)NC3CCCC3",
        "molecular_weight": 334.43318,
        "ALogP": 3.029,
        "molecular_formula": "C17H22N2O3S",
        "num_rings": 3,
        "image": "images/1442549.png",
        "assay_results": [
            {
                "result_id": 12161670,
                "target": "Bromodomain-containing protein 4",
                "result": "IC50",
                "operator": "=",
                "value": 500,
                "unit": "nM"
            }
        ]
    }
]'
```
</details>

## assumptions

I have forgone creating an images endpoint, as I would have used a CDN such as s3 or gcloud storage.
