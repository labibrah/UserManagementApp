#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
RAILS_ENV=production rake db:migrate:reset
RAILS_ENV=test rake db:migrate
