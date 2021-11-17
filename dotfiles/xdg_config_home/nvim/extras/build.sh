#!/bin/bash

# Build solargraph container
docker build -t solargraph:latest `dirname $0`/solargraph
