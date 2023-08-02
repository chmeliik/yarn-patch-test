#!/bin/bash
set -o errexit -o nounset -o pipefail

project_dir=${1:-'/tmp/yarn-patch-test'}
mkdir "$project_dir"
cd "$project_dir"

yarn set version berry
yarn init -2

yarn add is-positive@github:kevva/is-positive
patchdir=$(yarn patch is-positive --json | jq -r .path)
sed 's/> 0/< 0/' -i "$patchdir/index.js"
yarn patch-commit -s "$patchdir"

cat << EOF > index.js
let isNegative = require('is-positive')
console.log("patching worked:", isNegative(-1))
EOF

package_json=$(cat package.json)
jq <<< "$package_json" '.bin = "index.js"' > package.json

yarn install
yarn yarn-patch-test
