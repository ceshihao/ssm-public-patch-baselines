#!/bin/bash

directory="./patch-baselines"
mkdir -p $directory
aws ssm describe-patch-baselines > describe-patch-baselins.json
baselineIds=`cat describe-patch-baselins.json | jq -r '.BaselineIdentities[].BaselineId'`

for baselineId in $baselineIds
do
    patchBaseline=`aws ssm get-patch-baseline --baseline-id $baselineId`
    name=`echo $patchBaseline | jq -r '.Name'`
    aws ssm get-patch-baseline --baseline-id $baselineId > $directory/$name.json
done
