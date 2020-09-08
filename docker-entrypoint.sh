#!/bin/sh -e

# Update the gems
cat << EOF > Gemfile
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
EOF

bundle update

# Clean generated files on exit
clean() {
	rm -rf _site/
	rm -rf .sass-cache/
	rm -f .jekyll-metadata
	rm -f Gemfile*
}

trap "clean" EXIT

# Execute the command in background to be able to call the clean function
exec "$@" &
trap "kill $!" TERM
wait
