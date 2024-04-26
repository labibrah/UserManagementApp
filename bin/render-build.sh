#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
rake db:migrate
RAILS_ENV=test rake db:migrate
