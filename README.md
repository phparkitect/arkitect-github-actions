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
  phparkitect:
    name: PHPArkitect

    runs-on: ubuntu-latest

    steps:
    - name: "Checkout"
      uses: actions/checkout@v2

    - name: PHPArkitect
      uses: phparkitect/arkitect-github-actions@main
      with:
        args: check
```

### Configuration Options

#### Specify PHPArkitect version
You can specify which version of PHPArkitect to use:

```yaml
    - name: PHPArkitect
      uses: phparkitect/arkitect-github-actions@main
      with:
        phparkitect-version: '0.7.0'  # specific version
        args: check
```

Or use version constraints:
```yaml
        phparkitect-version: '^0.7'   # latest 0.7.x
        phparkitect-version: '*'      # latest stable (default)
```

#### Specify PHP version
To use a specific PHP version for platform requirements check:

```yaml
    - name: PHPArkitect
      uses: phparkitect/arkitect-github-actions@main
      env:
        PHP_VERSION: 8.0
      with:
        args: check
```

## Development

### How it works
The GitHub Action now builds the Docker image locally for each workflow run. This allows users to specify which version of PHPArkitect they want to use without requiring a new release of this action for every PHPArkitect update.

### Building the docker image locally
If you want to build and test the image locally:

```bash
docker build -t phparkitect/arkitect-github-actions:latest .
docker run --rm phparkitect/arkitect-github-actions:latest --version
```

### Release Strategy
Releases of this GitHub Action are only needed when:
- The action configuration changes (action.yml)
- The entrypoint script changes (entrypoint.sh)
- The Dockerfile structure changes
- New features are added to the action itself

**No release is needed** for PHPArkitect version updates, as users can specify their desired version via the `phparkitect-version` input.
