FROM ruby:2.7-alpine

WORKDIR /app

RUN apk add --no-cache \
	build-base \
	git

COPY . .

RUN bundle install

CMD ["bundle", "exec", "foreman", "start"]
