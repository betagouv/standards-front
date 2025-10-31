FROM ruby:3.4.7-slim

EXPOSE 3000

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y build-essential libpq-dev libyaml-dev

# do the bundle install in another directory with the strict essential
# (Gemfile and Gemfile.lock) to allow further steps to be cached
WORKDIR /bundle
COPY .ruby-version Gemfile Gemfile.lock ./
RUN bundle install

# Move to the main folder
WORKDIR /app

COPY . .

ENTRYPOINT ["./bin/docker-entrypoint"]

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
