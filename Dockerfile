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


# Default CMD leveraging entrypoint.sh script from Fluent Organization
CMD ["/fluent-bit/bin/fluent-bit","-c","/fluent-bit/etc/fluent-bit.conf"]
