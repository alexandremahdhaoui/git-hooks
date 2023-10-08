# git-hooks

Useful git hooks

## Usage

```shell
PATH="./.git/hooks/pre-commit"

cat <<EOF | tee "${PATH}"
#!/bin/bash

URL="https://raw.githubusercontent.com/alexandremahdhaoui/git-hooks"
VERSION="v0.0.5"

SCRIPTS="go-license"

for script in \${SCRIPTS}; do
  curl -sfL "\${URL}/\${VERSION}/\${script}.sh" | sh -xse -
done
EOF

chmod 755 "${PATH}"
```
