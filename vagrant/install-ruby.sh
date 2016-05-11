#!/bin/bash

source $HOME/.rvm/scripts/rvm

rvm use --default --install $1
echo "gem: --no-rdoc --no-ri" > ~/.gemrc

shift

if (( $# ))
    then
    rvm use $1@global
    gem install $@
fi

rvm cleanup all
