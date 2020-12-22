# Dockerfile
# chrono@2020-12

# curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
# sudo service docker start
# sudo usermod -aG docker ${USER}

# docker image build -t chronolaw/openresty .

# docker login
# docker image push chronolaw/openresty
# docker image pull chronolaw/openresty


ARG RESTY_IMAGE="openresty/openresty:alpine"

FROM ${RESTY_IMAGE}

#ARG HOSTS="/etc/hosts"

#LABEL version="2020-08"
#LABEL resty_version="1.17.8.2"

ARG RESTY_LUALIB="/usr/local/openresty/lualib/resty"
ARG RESTY_HTTP_VERSION="0.14"

RUN cd /tmp \
    && wget https://github.com/ledgetech/lua-resty-http/archive/v${RESTY_HTTP_VERSION}.tar.gz \
    && tar xfz v${RESTY_HTTP_VERSION}.tar.gz \
    && cp lua-resty-http-${RESTY_HTTP_VERSION}/lib/resty/*.lua ${RESTY_LUALIB} \
    && rm -rf /tmp/*


# http service
EXPOSE 80

CMD ["/bin/sh"]
