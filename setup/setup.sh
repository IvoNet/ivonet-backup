#!/usr/bin/env bash

echo "Setup backup environment..."

## Create needed folders if they do not already exist
if [ -d "./bin" ]; then
  echo "Making the scripts executable..."
  chmod +x ./bin/*.sh
else
  mkdir -p ./bin
  echo "Created bin folder"
fi

if [ ! -d "./config" ]; then
  mkdir -p ./config
  echo "Created config folder"
fi

if [ ! -d "./logs" ]; then
  mkdir -p ./logs
  echo "Created logs folder"
fi

