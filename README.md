# GitHub Action for PHPArkitect

This GitHub Action allows you to run [PHPArkitect](https://github.com/phparkitect/phparkitect) in your CI/CD pipeline to enforce architectural rules in your PHP projects.

## Usage

### Basic Usage

```yaml
# .github/workflows/architecture.yml

name: Architecture Tests

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  phparkitect:
    name: PHPArkitect
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run PHPArkitect
        uses: phparkitect/arkitect-github-actions@main
        with:
          args: check
```

### Advanced Configuration

#### Using a specific PHP version for analysis

```yaml
      - name: Run PHPArkitect
        uses: phparkitect/arkitect-github-actions@main
        env:
          PHP_VERSION: 8.0
        with:
          args: check
```

#### Installing dev dependencies

```yaml
      - name: Run PHPArkitect
        uses: phparkitect/arkitect-github-actions@main
        env:
          REQUIRE_DEV: true
        with:
          args: check
```

#### Ignoring platform requirements

```yaml
      - name: Run PHPArkitect
        uses: phparkitect/arkitect-github-actions@main
        env:
          CHECK_PLATFORM_REQUIREMENTS: false
        with:
          args: check
```

## Configuration Options

### Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `args` | Arguments to pass to PHPArkitect (e.g., `check`, `list`) | No | `check` |

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PHP_VERSION` | Target PHP version for analysis (e.g., `7.4`, `8.0`, `8.2`) | - |
| `REQUIRE_DEV` | Install dev dependencies (`true` or `false`) | `false` |
| `CHECK_PLATFORM_REQUIREMENTS` | Check platform requirements (`true` or `false`) | `true` |

## Example: Complete Workflow

```yaml
name: Architecture Tests

on:
  push:
    branches:
      - main
      - develop
  pull_request:

jobs:
  phparkitect:
    name: PHPArkitect
    runs-on: ubuntu-latest

    strategy:
      matrix:
        php-version: ['8.0', '8.1', '8.2']

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run PHPArkitect for PHP ${{ matrix.php-version }}
        uses: phparkitect/arkitect-github-actions@main
        env:
          PHP_VERSION: ${{ matrix.php-version }}
        with:
          args: check
```

## Development

### Building and pushing the Docker image

The Docker image is automatically built and published when a new PHPArkitect version is released.

For manual builds:

```bash
docker login
docker build -t phparkitect/arkitect-github-actions:latest .
docker push phparkitect/arkitect-github-actions:latest
```

### Testing locally

```bash
# Run the action locally
docker build -t phparkitect-action .
docker run -v $(pwd):/github/workspace phparkitect-action check
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT
