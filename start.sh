#!/bin/bash
rm -rf /static/*
cp -R /poputchiki/public/* /static
cp /poputchiki/index.html /static
node start.js


