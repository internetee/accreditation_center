FROM internetee/ruby:3.0-buster

RUN mkdir -p /opt/webapps/app/tmp/pids
WORKDIR /opt/webapps/app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle update --bundler && bundle update && bundle install

EXPOSE 3000