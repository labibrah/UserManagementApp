#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

bin/rails db:environment:set RAILS_ENV=production 
rake DISABLE_DATABASE_ENVIRONMENT_CHECK=1 db:migrate:reset
RAILS_ENV=test rake db:migrate
