#!/bin/bash

echo "name: $(jq '.[].Spec.Name' $1)"
echo "Secrets: $(jq '.[].Spec.TaskTemplate.ContainerSpec.Secrets | length' $1)"
echo "Networks: $(jq '.[].Spec.TaskTemplate.Networks | length' $1)"
