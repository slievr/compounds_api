FROM elixir:1.11.3 as base

WORKDIR /app
COPY . /app

RUN mix local.hex --force \ 
    && mix local.rebar --force \
    && mix deps.get \
    && mix compile

EXPOSE 4000

CMD ["./run.sh"]


FROM base as test
ENV MIX_ENV test

RUN env

CMD ["./test.sh"]

FROM base as seed
ENV MIX_ENV prod

CMD ["./seed.sh"]

FROM base as prod
ENV MIX_ENV prod

CMD ["./run.sh"]