#!/bin/bash

helm repo add openebs https://openebs.github.io/charts
helm repo update
helm pull openebs/openebs  --untar
rm -R charts/openebs
mv openebs charts/
