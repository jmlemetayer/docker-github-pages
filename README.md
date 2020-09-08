[![dockeri.co][dockeri.co]][hub.docker]

# Quick Start

Run the GitHub Pages server docker image. First move to the directory where the
GitHub Pages sources are located:

    docker run --rm --tty --publish 4000:4000 \
        --volume ${PWD}:/var/lib/github-pages \
        jmlemetayer/github-pages

# GitHub Metadata

The [GitHub Metadata plugin][github-metadata] (i.e. `site.github`) works as is
if the directory is also a *git repository* and there is a valid *git remote*
named `origin`.

## Authentication

For some fields, like `cname`, you need to authenticate yourself. Begin by
generating a new personal access token on GitHub.com:

 * Open https://github.com/settings/tokens/new
 * Select the scope *public_repo*, and add a description.
 * Confirm and save the settings. Copy the token you see on the page.

Now you can use the `JEKYLL_GITHUB_TOKEN` environment variable:

    docker run --rm --tty --publish 4000:4000 \
        --volume ${PWD}:/var/lib/github-pages \
        --env JEKYLL_GITHUB_TOKEN=123mytoken321 \
        jmlemetayer/github-pages

## Overrides

You can override the `site.repository` by using the `PAGES_REPO_NWO`
environment variable:

    docker run --rm --tty --publish 4000:4000 \
        --volume ${PWD}:/var/lib/github-pages \
        --env PAGES_REPO_NWO=username/repo-name \
        jmlemetayer/github-pages

[hub.docker]: https://hub.docker.com/r/jmlemetayer/github-pages
[dockeri.co]: https://dockeri.co/image/jmlemetayer/github-pages
[github-metadata]: https://github.com/jekyll/github-metadata
