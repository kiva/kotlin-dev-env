#!/bin/bash

service="kotlin-demo"
ui="nuxt-sandbox"
graphql="schema-stitching-demo"

echo "Cloning demo app repos in parent directory.."

cd ..

if [ ! -d "${service}" ]; then
    git clone git@github.com:kiva/kotlin-demo.git
fi

if [ ! -d "${ui}" ]; then
    git clone git@github.com:kiva/nuxt-sandbox.git
fi

if [ ! -d "${graphql}" ]; then
    git clone git@github.com:kiva/schema-stitching-demo.git
fi

echo "All demo app repos cloned."