FROM ruby:2.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /event_app02
WORKDIR /event_app02
COPY Gemfile //Gemfile
COPY Gemfile.lock /event_app02/Gemfile.lock
RUN bundle install
COPY . /event_app02

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3002

CMD ["rails", "server", "-b", "0.0.0.0"]
