#!/bin/sh -e

trap "rm -rf _site/ .sass-cache/ .jekyll-metadata Gemfile*" EXIT

cat > Gemfile << EOF
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
EOF

bundle update

exec "$@" &
trap "kill $!" TERM
wait
