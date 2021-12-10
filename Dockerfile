FROM ruby:2.6.5

WORKDIR /usr/src/app

COPY . /usr/src/app/

RUN gem install bundler:2.2.11

RUN bundle install

EXPOSE 3000

CMD [ "rails", "server", "-b", "0.0.0.0" ]