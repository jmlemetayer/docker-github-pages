#!/bin/sh -e

cat > Gemfile << EOF
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
EOF

bundle update

exec "$@"
