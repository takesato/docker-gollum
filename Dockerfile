FROM ruby:2.5-alpine

RUN apk --no-cache update \
 && apk --update add build-base \
 && apk add icu-dev cmake libidn-dev git openssl-dev nodejs \
 && rm -rf /var/cache/apk/*

WORKDIR /root/app
ENV GOLLUM_HOME /root/wiki

RUN gem install rugged
COPY app/Gemfile /root/app/Gemfile
RUN bundle install
COPY app/ /root/app/

RUN mkdir -p ${GOLLUM_HOME} \
 && cd ${GOLLUM_HOME} \
 && git init

ENTRYPOINT [ "/root/app/entrypoint.sh" ]
CMD [ "rackup", "-o", "0.0.0.0"]