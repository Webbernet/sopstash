# syntax = docker/dockerfile:1
# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# https://gist.github.com/trastle/5722089
# An issue building with MacOS Sonoma proxy. This disables it.
RUN touch /etc/apt/apt.conf.d/99fixbadproxy
RUN echo "Acquire::http::Pipeline-Depth 0;Acquire::http::No-Cache true;Acquire::BrokenProxy true;" >> /etc/apt/apt.conf.d/99fixbadproxy


# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="development" \
    BUNDLE_WITHOUT=""


# Install packages needed to build gems and node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential curl git libpq-dev libvips node-gyp pkg-config python-is-python3

# Install JavaScript dependencies
ARG NODE_VERSION=18.16.0
ARG YARN_VERSION=1.22.18
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install 

# Install node modules
COPY package.json yarn.lock ./
RUN yarn install 

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000

CMD ["./bin/rails", "server"]
