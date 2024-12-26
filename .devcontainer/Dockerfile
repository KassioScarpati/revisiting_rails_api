FROM ruby:3.2

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    postgresql-client

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 4

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
