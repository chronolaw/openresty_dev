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

ARG ROOT_LUALIB="/usr/local/openresty/lualib/"
ARG RESTY_LUALIB="/usr/local/openresty/lualib/resty/"

ARG RESTY_HTTP_VERSION="0.14"
ARG RESTY_ETCD_VERSION="1.4.3"
ARG LUA_TYPEOF_VERSION="0.1"

RUN cd /tmp \
    && wget https://github.com/ledgetech/lua-resty-http/archive/v${RESTY_HTTP_VERSION}.tar.gz \
    && tar xfz v${RESTY_HTTP_VERSION}.tar.gz \
    && cp lua-resty-http-${RESTY_HTTP_VERSION}/lib/resty/*.lua ${RESTY_LUALIB} \
    && wget https://github.com/iresty/lua-typeof/archive/v${LUA_TYPEOF_VERSION}.tar.gz \
    && tar xfz v${LUA_TYPEOF_VERSION}.tar.gz \
    && cp lua-typeof-${LUA_TYPEOF_VERSION}/lib/*.lua ${ROOT_LUALIB} \
    && wget https://github.com/api7/lua-resty-etcd/archive/v${RESTY_ETCD_VERSION}.tar.gz \
    && tar xfz v${RESTY_ETCD_VERSION}.tar.gz \
    && cp -r lua-resty-etcd-${RESTY_ETCD_VERSION}/lib/resty/* ${RESTY_LUALIB} \
    && rm -rf /tmp/*


# http service
#EXPOSE 80

#CMD ["/bin/sh"]
