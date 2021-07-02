# Feedstock Creation Action

The purpose of `feedstock-creation-action` is to take the `meta.yaml` from a successful PR into [`staged-recipes`](https://github.com/pangeo-forge/staged-recipes) and create a Feedstock repository for the administration of pangeo-forge Recipes within the Feedstock

This Action creates a Feedstock repository named `<id>-feedstock` where `<id>` is the top level `id` entry in `meta.yaml`. This value **must** be unique, if a repository already exists, the Action will terminate.

# Inputs

## `path_to_meta_yaml`

**Required** - The path to the meta.yaml file for the Recipes, relative to the root of the repository

# ENV

## `GITHUB_TOKEN`

**Required** - A GitHub Personal Access Token to use for authentication with GitHub to create repositories

# Example Usage

```yaml
name: CI
on: [push]

jobs:
  create-feedstock:
    runs-on: ubuntu-20.04
    steps:
      - uses: actions/checkout@v2

      - name: Create Feedstock repository
        uses: pangeo-forge/feedstock-creation-action@v1
        with:
          path_to_meta_yaml: "a/path/to/meta.yaml"
        env:
          GITHUB_TOKEN: ${{ secrets.A_GITHUB_TOKEN }}
```

# Development

To develop on this Action, you will need the following installed:

* [Docker](https://docs.docker.com/get-docker/)

## `.env`

A `.env` file is expected at the root of the repository with the following contents:

```bash
GITHUB_TOKEN=<a-github-personal-access-token>
```

## Testing

To test the Action, an example directory `example-feedstock/` has been provided that mimics a structure you might get in a PR for `staged-recipes`.

To create a feedstock repository with this test data, run:

```bash
$ make feedstock
```

This will create a Feedstock repository called `a-test-bunch-of-recipes-feedstock` - **Make sure you delete this once you're done!**

If you want to make multiple Feedstocks, just change the top level `id` entry in `example-feedstock/meta.yaml`.
