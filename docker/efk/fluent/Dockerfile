FROM fluent/fluentd

COPY ./etc/fluent.conf /fluentd/etc/fluent.conf
RUN fluent-gem install fluent-plugin-elasticsearch
