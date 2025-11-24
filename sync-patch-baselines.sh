#!/bin/bash

directory="./patch-baselines"
mkdir -p $directory
aws ssm describe-patch-baselines --filters Key=OWNER,Values=AWS > describe-patch-baselines.json
baselineIds=`cat describe-patch-baselines.json | jq -r '.BaselineIdentities[].BaselineId'`

for baselineId in $baselineIds
do
    patchBaseline=`aws ssm get-patch-baseline --baseline-id $baselineId`
    name=`echo $patchBaseline | jq -r '.Name'`
    aws ssm get-patch-baseline --baseline-id $baselineId > $directory/$name.json
done
