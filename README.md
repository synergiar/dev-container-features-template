> ⚠️ NOTE: This functionality is in PREVIEW. Please note it is subject to (heavy) modification!  

# Development container `features` Template

To create your own remote [**dev container features**](https://code.visualstudio.com/docs/remote/containers#_dev-container-features-preview), use this repo as a template.  This repo contains one "feature" called `zsh` 

These feature can then be declared in your `devcontainer.json` file for use in the Remote-Containers extension or GitHub Codespaces.

# Features In This Repo (Directory)

### zsh

This will include in your terminal oh my zsh with a default theme and some extra plugins. Plugins and theme will be parameterizable in next versions

## Release Flow

Push a tag (eg `v0.0.1`) to your repo, which will trigger the [deploy-features action](https://github.com/microsoft/publish-dev-container-features-action) in this repo's [`deploy-features.yml` workflow file](https://github.com/microsoft/dev-container-features-template/blob/main/.github/workflows/deploy-features.yml).

Assets will be compressed and added as a release artifact with the name `features.tgz`. 

## Include these features in your project's devcontainer 

To include your feature in a project's devcontainer, provide the following `features` like so.

```jsonc
"image": "mcr.microsoft.com/vscode/devcontainers/base",
features: {
    "<OWNER>/<REPO>/helloworld": {
        "greeting": "Hello!"
    },
    "<OWNER>/<REPO>/color": {
        "color": "green" 
    }
}
```

- Where OWNER is the repo owner (for this template, `microsoft`).
- Where REPO is the repo name (for this template, `dev-container-features-template`)

Providing no version implies the latest release's artifacts.  To supply a tag as a version, use the following notation.

```jsonc
features: {
    "synergiar/remote-container-zsh/zsh@v0.0.1": {}
}
```

## Adding your own features

> This functionality is in Preview (and subject to change!) Please give it a try, and provide [feedback](https://github.com/microsoft/vscode-remote-release) along the way.

To add your own features to this template, follow these steps:

1. Customize the [`features.json`](https://github.com/microsoft/dev-container-features-template/blob/main/features.json), adding in another `feature` object to the array. For an idea of what attributes can be provided in this preview, check out the [features definition on vscode-dev-containers](https://github.com/microsoft/vscode-dev-containers/blob/main/script-library/container-features/src/features.json).  _Further documentation will be forthcoming as this functionality moves out of preview!_

2. The [`install.sh`](https://github.com/microsoft/dev-container-features-template/blob/main/install.sh) script is the entrypoint that the Remote-Containers extension, the devcontainer-cli, and Codespaces will use to install your features.

If a feature is declared in your `devcontainer.json`,  the `_BUILD_ARG_<FEATURE_NAME>` will be set to `true`.  If you supply any options, those are exposed as `_BUILD_ARG_<FEATURE_NAME>_<OPTION_NAME>`.

Always source [`./features.env`](https://github.com/microsoft/dev-container-features-template/blob/main/install.sh#L9-L11) at the top of your install.sh script, that's the file the tooling will write all the environment variables to, and is useful for the author (you!) to use in your install script(s).

