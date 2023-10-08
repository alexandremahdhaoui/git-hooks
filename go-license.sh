#!/bin/bash

# Check LICENSE exists
ROOT_PATH="$(git rev-parse --show-toplevel)"
LICENSE_PATH="${ROOT_PATH}/LICENSE"
if [ ! -f "${LICENSE_PATH}" ]; then echo "Please provide a License"; exit 1;fi

# go-license config path
CONFIG_PATH=".tmp.go-license.config"

# Create go-license config
SHORT_LICENSE_PATH="${ROOT_PATH}/hack/boilerplate.go.txt"
if [ -f "${SHORT_LICENSE_PATH}" ]; then 
  echo "header: |" | tee "${CONFIG_PATH}" &>/dev/null
  awk '{print "  "$0}' "${SHORT_LICENSE_PATH}" | tee -a "${CONFIG_PATH}" &>/dev/null
else
  cat <<EOF | tee "${CONFIG_PATH}" &>/dev/null
header: |
  /*
$(awk '{print "  "$0}' "${LICENSE_PATH}")
  */ 
EOF
fi

# Install go-license
if ! go-license --help &>/dev/null; then
  go install github.com/palantir/go-license@latest
  PATH="$PATH:$(go env GOPATH)/bin"
  export PATH
fi

# Run go-license
# shellcheck disable=SC2044
for x in $(find "${ROOT_PATH}" -name "*.go"); do
  go-license --config "${CONFIG_PATH}" "$(git ls-files --full-name "${x}")"
done

rm "${CONFIG_PATH}"

git add -A
