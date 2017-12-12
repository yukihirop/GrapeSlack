FROM ruby:2.4.1

ENV APP_ROOT /grape_slack

WORKDIR $APP_ROOT

RUN apt-get update\
		&& apt-get install -y nodejs qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install -j4

COPY . $APP_ROOT

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "server", "-p", "3000", "-b", "0.0.0.0", "--pid", "/tmp/server.pid"]