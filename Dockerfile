FROM bitwalker/alpine-elixir-phoenix:latest as base

WORKDIR /app
COPY . /app

ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile


FROM base as migrate

RUN mix ecto.create

CMD ["mix", "ecto.migrate"]

FROM base as release

CMD ["mix", "phx.server"]


