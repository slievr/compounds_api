FROM bitwalker/alpine-elixir-phoenix:latest as base

WORKDIR /app
COPY . /app

ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

FROM base as release

ARG MIX_ENV=prod

RUN mix release compounds

RUN mix ecto.create

CMD ["bin/compounds", "start"]
