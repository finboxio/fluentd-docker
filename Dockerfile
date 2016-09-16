FROM alpine:3.4

ENV FLUENTD_OPT= \
    FLUENTD_CONF=fluent.conf \
    FLUENTD_DATA_DIR=/home/fluent \
    FLUENTD_VERSION=0.14.4

RUN apk --no-cache add \
        build-base \
        ca-certificates \
        ruby \
        ruby-irb \
        ruby-dev \
        curl && \
    apk --no-cache add acl --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ && \
    curl -L -o /usr/sbin/dosu https://raw.githubusercontent.com/mvertes/dosu/0.1.0/dosu && \
    chmod +x /usr/sbin/dosu && \
    echo 'gem: --no-document' >> /etc/gemrc && \
    gem install json && \
    gem install fluentd -v $FLUENTD_VERSION && \
    apk del build-base ruby-dev && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /usr/lib/ruby/gems/*/cache/*.gem

RUN adduser -D -g '' -u 1000 -h /home/fluent fluent
RUN chown -R fluent:fluent /home/fluent

WORKDIR /home/fluent

# Tell ruby to install packages as user
RUN echo "gem: --user-install --no-document" >> /home/fluent/.gemrc
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH
ENV GEM_PATH /home/fluent/.gem/ruby/2.3.0:$GEM_PATH

ADD fluent.conf /home/fluent/fluent.conf
ADD entrypoint.sh /entrypoint.sh

EXPOSE 24224 5140

CMD /entrypoint.sh
