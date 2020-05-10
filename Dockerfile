FROM ruby:2.5.3-alpine

# bring "make" command
RUN apk add build-base

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

ADD . .

CMD ["ruby", "./bin/backery_start.rb"]
