FROM internetee/ruby:2.7-buster

RUN mkdir -p /opt/webapps/app/tmp/pids
WORKDIR /opt/webapps/app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle update --bundler && bundle config set without 'development test' && bundle install

EXPOSE 3000
