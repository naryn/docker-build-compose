#!/usr/bin/env bash
set -e
#1
mkdir -p /docker/services/etc/apache/
mkdir -p /docker/services/etc/nginx/
mkdir -p /docker/services/etc/mysql/
mkdir -p /docker/services/etc/php/
mkdir -p /docker/services/etc/redis/
mkdir -p /docker/services/etc/memcached/
mkdir -p /docker/services/etc/elasticsearch/

mkdir -p /docker/services/log/apache/
mkdir -p /docker/services/log/nginx/
mkdir -p /docker/services/log/mysql/
mkdir -p /docker/services/log/redis/
mkdir -p /docker/services/log/memcached/
mkdir -p /docker/services/log/elasticsearch/

mkdir -p /docker/services/data/mysql/
mkdir -p /docker/services/data/elasticsearch/

mkdir -p /docker/services/project/php/

docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker stop
docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker rm
docker images|grep none|awk '{print $3 }'|xargs docker rmi

docker pull redis:alpine
docker pull memcached:alpine
docker pull debian:jessie


DIR="$( cd "$( dirname "$0"  )" && pwd  )"

cd $DIR/elasticsearch/5.0
docker build -t services/elasticsearch:5.0 .

cd $DIR/redis
docker build -t services/redis:3.2.5 .

cd $DIR/memcached
docker build -t services/memcached:1.4 .

cd $DIR/nginx
docker build -t services/nginx:1.0 .

cd $DIR/mysql
docker build -t services/mysql:8.0 .


cd $DIR/apache_php/5.6
docker build -t services/apache-php:5.6 .