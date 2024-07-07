### Hexlet tests and linter status:
[![Actions Status](https://github.com/owlscatcher/rails-project-66/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/owlscatcher/rails-project-66/actions)

# Repository quality

The Github Quality project is a service where developers can run code checks on their repositories 
and get a report on the state of the codebase, current bugs.

Project published on render: https://bb.owlpaw.com/

## Local installation

```bash
git clone git@github.com:owlscatcher/rails-project-66.git && \
  cd ./rails-project-66 && \
  make setup
```

## Starting project

```bash
make start-dev
```

## Refreshing database

```bash
make cleanup
```

## Starting tests and linting code

```bash
make check
```

Or start them separately:

```bash
make lint
```

```bash
make test
```

