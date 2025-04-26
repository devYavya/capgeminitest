FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app
ENV RAILS_ENV=production
ENV RACK_ENV=production
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.2.31 && bundle _2.2.31_ install --without development test

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
