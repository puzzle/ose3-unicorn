FROM centos/ruby-23-centos7

USER root
WORKDIR /usr/src/app
RUN yum -y update && \
    yum install -y epel-release && \
    yum install -y nginx mysql-devel && \
    curl -sL https://rpm.nodesource.com/setup_7.x | bash - && \
    yum install -y nodejs && \
    scl enable rh-ruby23 "gem install foreman" && \
    mkdir -p /usr/src/config

# Install the latest postgresql lib for pg gem
# RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
#     apt-get update && \
#     DEBIAN_FRONTEND=noninteractive \
#     apt-get install -y --force-yes libpq-dev

COPY nginx.conf /etc/nginx/nginx.conf
COPY unicorn.rb /usr/src/config/unicorn.rb
COPY Procfile /usr/src/config/Procfile

USER 1001
ENV RAILS_ENV development
CMD foreman start -f /usr/src/config/Procfile -d /usr/src/app
