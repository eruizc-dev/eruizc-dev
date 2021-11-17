FROM ruby:alpine

RUN apk add --no-cache build-base
RUN gem install solargraph
RUN gem install solargraph-rails --pre

CMD [ "solargraph", "stdio" ]
