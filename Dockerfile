FROM bitwalker/alpine-elixir-phoenix:latest as base


ARG SECRET_KEY_BASE

ENV PORT 4000
EXPOSE ${PORT}

WORKDIR /app
COPY . /app

ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

FROM base as test
ENV MIX_ENV test

RUN env

CMD ["./test.sh"]

FROM base as seed
ENV MIX_ENV prod

CMD ["./seed.sh"]

FROM base as release
ENV MIX_ENV prod

CMD ["./run.sh"]