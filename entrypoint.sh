#! /bin/sh

FLUENTD_DATA_DIR=${FLUENTD_DATA_DIR:-/home/fluent}

mkdir -p $FLUENTD_DATA_DIR

chown -R fluent:fluent $FLUENTD_DATA_DIR

exec dosu fluent fluentd \
  -c ${FLUENTD_DATA_DIR}/fluent.conf \
  -p ${FLUENTD_DATA_DIR}/plugins \
  $FLUENTD_OPT
