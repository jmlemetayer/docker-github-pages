FROM	debian:9

RUN	set -x \
	&& apt-get update \
	&& apt-get install -y \
		build-essential \
		git \
		ruby-bundler \
		ruby-dev \
		ruby-execjs \
		zlib1g-dev \
	&& echo "source 'https://rubygems.org'" > /tmp/Gemfile \
	&& echo "gem 'github-pages', group: :jekyll_plugins" >> /tmp/Gemfile \
	&& bundle install --gemfile=/tmp/Gemfile \
	&& rm /tmp/Gemfile*

VOLUME	["/var/lib/github-pages"]
WORKDIR	/var/lib/github-pages

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE	4000

CMD	["bundle", "exec", \
	"jekyll", "serve", "--host=0.0.0.0", "--port=4000", "--trace"]
