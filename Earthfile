all:
   BUILD +check-format
   BUILD +lint
   BUILD +test

setup-base:
   FROM hexpm/elixir:1.11.2-erlang-23.1.1-alpine-3.12.0
   RUN apk add --no-progress --update build-base
   WORKDIR /src
   SAVE IMAGE --cache-hint

deps:
   FROM +setup-base
   COPY mix.exs .
   COPY mix.lock .
   COPY .formatter.exs .
   RUN mix local.rebar --force
   RUN mix local.hex --force
   RUN mix deps.get
   SAVE IMAGE --cache-hint

build:
   FROM +deps
   COPY --dir lib ./
   RUN mix compile
   RUN MIX_ENV=test mix deps.compile
   SAVE IMAGE --cache-hint

test:
   FROM +build
   COPY --dir test ./
   RUN --no-cache mix test

lint:
   FROM +build
   RUN --no-cache mix credo --strict

check-format:
   FROM +build
   RUN --no-cache mix format --check-formatted

typecheck:
   FROM +build
   COPY --dir priv ./
   RUN --no-cache mix dialyzer
   SAVE IMAGE --cache-hint
