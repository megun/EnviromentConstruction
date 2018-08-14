FROM fluent/fluentd

COPY ./etc/fluent.conf /fluentd/etc/fluent.conf
COPY ./etc/jsonkey.json /fluentd/etc/jsonkey.json


RUN apk add --no-cache build-base ruby-dev \
  && fluent-gem install fluent-plugin-bigquery \
  && fluent-gem install bigdecimal
