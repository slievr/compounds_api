#!/usr/bin/env sh

mix ecto.setup \
&& mix Compounds.SeedFromFile --file ./seed/${SEED_FILE}
