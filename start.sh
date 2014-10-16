#!/bin/bash
rm -rf /static/*
cp -R /poputchiki/public/* /static
cp /poputchiki/index.html /static
cp /poputchiki/404.html /static
node start.js


