#!/usr/bin/env bash
set -euo pipefail

# get the latest ImageId version of the given AMI

aws ec2 describe-images --no-cli-pager --profile ec2-admin --region us-west-2 --filters "Name=name,Values=al2023-ami-minimal-*-arm64" > all.json
jq -r '.Images | sort_by(.CreationDate) | .[] | select(.Name|test("al2023-ami-minimal-.*-arm64")) | [.Name,.CreationDate,.ImageId] | @tsv' all.json| tail -1 | awk '{print $NF}'
