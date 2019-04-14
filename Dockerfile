FROM phusion/baseimage
LABEL maintainer="pioncore <info@pioncoin.org>"

ARG USER_ID
ARG GROUP_ID

ENV HOME /pion

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} pion
RUN useradd -u ${USER_ID} -g pion -s /bin/bash -m -d /pion pion

RUN chown pion:pion -R /pion

ADD https://github.com/pioncoin/pion/releases/download/v0.12.3.3/pioncore-0.12.3-x86_64-linux-gnu.tar.gz /tmp/
RUN tar -xvf /tmp/pioncore-*.tar.gz -C /tmp/
RUN cp /tmp/pioncore*/bin/*  /usr/local/bin
RUN rm -rf /tmp/pioncore*

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER pion

VOLUME ["/pion"]

EXPOSE 9953 9954 19953 19954

WORKDIR /pion

CMD ["pion_oneshot"]
