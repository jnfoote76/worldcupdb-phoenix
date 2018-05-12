# ./Dockerfile

# Extend from the official Elixir image
FROM elixir:latest

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get update && \
  apt-get install -y postgresql-client nodejs npm

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix deps.get
RUN cd assets && npm install && cd ..

# Compile the project
RUN mix do compile

CMD ["/app/entrypoint.sh"]