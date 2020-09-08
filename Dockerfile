FROM	ubuntu:20.04

RUN	set -x \
	# Install the needed packages:
	&& DEBIAN_FRONTEND=noninteractive \
	&& apt update \
	&& apt install --no-install-recommends --assume-yes \
		# Needed to run jekyll
		bundler \
		# Needed to build native extensions
		build-essential \
		ruby-dev \
		zlib1g-dev \
		# Needed by the github-metadata gem
		git \
		# The locales needs to be set to avoid building issue
		locales \
	&& rm -rf /var/lib/apt/lists/* \
	# Configure the locales as UTF-8
	&& localedef -i en_US -c -f UTF-8 en_US.UTF-8 \
	# The gems are pre installed at build time to speed up the docker run
	&& echo "source 'https://rubygems.org'" > /tmp/Gemfile \
	&& echo "gem 'github-pages', group: :jekyll_plugins" >> /tmp/Gemfile \
	&& bundle install --gemfile=/tmp/Gemfile \
	&& rm /tmp/Gemfile* \
	# The github-pages gem is using a default theme which generates an unwanted css file
	&& sed -i '/"theme"/d' /var/lib/gems/*/gems/github-pages-*/lib/github-pages/configuration.rb

ENV	LANG en_US.utf8

VOLUME	["/var/lib/github-pages"]
WORKDIR	/var/lib/github-pages

COPY	docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT	["docker-entrypoint.sh"]

EXPOSE	4000

CMD	["bundle", "exec", "jekyll", "serve", \
		"--incremental", "--host=0.0.0.0", "--port=4000", "--trace"]
