#!/bin/bash
set -e

# Start Apache in the background
apachectl start

# Start the Rails server
bundle exec rails s -p 3000 -b '0.0.0.0'
