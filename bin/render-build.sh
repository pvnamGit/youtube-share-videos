#!/usr/bin/env bash
# exit on error
set -o errexit
# install JavaScript dependencies
yarn install

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

./bin/webpack
