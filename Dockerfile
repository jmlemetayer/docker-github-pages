FROM	ubuntu:20.04

RUN	set -x \
	&& DEBIAN_FRONTEND=noninteractive \
	&& apt update \
	&& apt install --no-install-recommends --assume-yes \
		build-essential \
		bundler \
		git \
		locales \
		ruby-dev \
		zlib1g-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 en_US.UTF-8 \
	&& echo "source 'https://rubygems.org'" > /tmp/Gemfile \
	&& echo "gem 'github-pages', group: :jekyll_plugins" >> /tmp/Gemfile \
	&& bundle install --gemfile=/tmp/Gemfile \
	&& rm /tmp/Gemfile* \
	&& sed -i '/"theme"/d' /var/lib/gems/*/gems/github-pages-*/lib/github-pages/configuration.rb

ENV	LANG en_US.utf8

VOLUME	["/var/lib/github-pages"]
WORKDIR	/var/lib/github-pages

COPY	docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT	["docker-entrypoint.sh"]

EXPOSE	4000

CMD	["bundle", "exec", "jekyll", "serve", \
		"--incremental", "--host=0.0.0.0", "--port=4000", "--trace"]
