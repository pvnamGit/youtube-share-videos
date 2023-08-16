#!/usr/bin/env bash
# exit on error
set -o errexit
# Set NODE_ENV to development temporarily to install devDependencies
export NODE_ENV=development

# install JavaScript dependencies
yarn install --production=false

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

./bin/webpack

# Optional: Set NODE_ENV back to production if required
export NODE_ENV=production
