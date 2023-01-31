# GithubAction for Arkitect

This repository is created for run PHPArkitect into Github Actions

## Usage
You can use it as a Github Action like this:

```yaml
# .github/workflows/test.yml 

on:
  push:
    branches:
      - master
  pull_request:

name: Test

jobs:
  phpstan:
    name: PHPArkitect

    runs-on: ubuntu-latest

    steps:
    - name: "Checkout"
      uses: actions/checkout@v2

    - name: PHPArkitect
      uses: docker://phparkitect/arkitect-github-actions
      with:
        args: check
```

_to use a specific php version:_
```diff
      uses: docker://phparkitect/arkitect-github-actions
+     env:
+       PHP_VERSION: 8.0
      with:
        args: check
```

## Building and pushing the docker image

```
docker login
docker build -t phparkitect/arkitect-github-actions:latest .
docker push phparkitect/arkitect-github-actions:latest
```
