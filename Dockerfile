FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /gethub
WORKDIR /gethub
COPY Gemfile /gethub/Gemfile
COPY Gemfile.lock /gethub/Gemfile.lock
RUN bundle install
COPY . /gethub

# Add a script to be executed every time the container starts.
COPY run.sh /usr/bin/
RUN chmod +x /usr/bin/run.sh
ENTRYPOINT ["run.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
