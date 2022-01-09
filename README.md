# GithubAction for Arkitect

This repository is created for run PHPArkitect into Github Action

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
      uses: docker://phparkitect/phparkitect
      with:
        args: check
```

_to use a specific php version:_
```diff
      uses: docker://phparkitect/phparkitect
+     env:
+       PHP_VERSION: 8.0
      with:
        args: check
```
