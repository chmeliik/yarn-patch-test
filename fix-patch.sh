#!/bin/bash
set -o errexit -o nounset -o pipefail

project_dir=${1:-'/tmp/yarn-patch-test'}
cd "$project_dir"

sed -i 's/is-positive@[^"]*/is-positive/' package.json
yarn install
yarn yarn-patch-test
