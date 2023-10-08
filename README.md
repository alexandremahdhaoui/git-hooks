# git-hooks

Useful git hooks

## Usage

```shell
cat <<EOF | tee ./.git/hooks/pre-commit
#!/bin/bash

URL="https://raw.githubusercontent.com/alexandremahdhaoui/git-hooks"
VERSION="v0.0.5"

SCRIPTS="go-license"

for script in \${SCRIPTS}; do
  curl -sfL "\${URL}/\${VERSION}/\${script}.sh" | sh -xse -
done
EOF
```
