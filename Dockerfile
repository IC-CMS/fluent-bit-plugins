###################################################################
# Title:	Fluent-bit-Plugins
# Purpose:  	Create a Docker image with necessary plugins already installed for fluent-bit
# Created: 	4/27/2018
# Maintainer:	IC-CMS
# 
# Fluent-bit is based on Google's fluent-bit, managed by Fluent.

FROM fluent/fluent-bit:0.12.13
MAINTAINER IC-CMS https://github.com/IC-CMS
LABEL Description="Fluent-bit docker image with plugins" \
      Vendor="IC-CMS" \
      Version="1.0" \
      RUN="docker run -d --restart always --log-driver none -p 127.0.0.1:24224:24224 -v ./fluent-bit/fluent-bit.conf:/fluent-bit/etc/fluent-bit.conf --name fluent-bit sredna/fluent-bit-plugins:latest"

# Install Gems
# already installed in base:  
# json -v 2.1.0
# oj -v 3.3.10
# fluentd -v 1.2.0.pre1

RUN  buildDeps=" \
      make gcc g++ libc-dev \
      ruby-dev \
      wget bzip2 gnupg dirmngr curl libcurl4-openssl-dev build-essential \
    " && \
	apt-get update && \
	apt-get upgrade -y && \
        apt-get install -y --no-install-recommends $buildDeps && \
 	echo 'gem: --no-rdoc --no-ri' >> /etc/gemrc && \
	fluent-gem install amqp && \
	fluent-gem install cloudwatch && \
	fluent-gem install cloudwatchlogger && \
	fluent-gem install fluent-plugin-elasticsearch && \
	fluent-gem install influxdb && \
	fluent-gem install kafka && \
	fluent-gem install mongo && \
	fluent-gem install parser && \
	fluent-gem install rewrite && \
	fluent-gem install s3 && \
	fluent-gem install slack && \
	fluent-gem install forward && \
	fluent-gem install fluent-plugin-secure-forward && \
	fluent-gem install fluent-plugin-notifier && \
	apt-get purge -y --auto-remove -o \
		APT::AutoRemove::RecommendsImportant=false \
		$buildDeps && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/* var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

# Default CMD leveraging entrypoint.sh script from Fluent Organization
CMD ["/fluent-bit/bin/fluent-bit","-c","/fluent-bit/etc/fluent-bit.conf"]
