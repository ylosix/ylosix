#!/bin/bash

# Sets needed environment variables
source ~/.bashrc

if [ -z "$RAILS_ENV" ]; then # only checks if VAR is set, regardless of its value
    echo "export RAILS_ENV=development" >> ~/.bashrc
fi

if [ -z "$DATABASE_URL" ]; then # only checks if VAR is set, regardless of its value
    echo "export DATABASE_URL=postgres://postgres:postgres@127.0.0.1:5432/ecommerce" >> ~/.bashrc
fi
