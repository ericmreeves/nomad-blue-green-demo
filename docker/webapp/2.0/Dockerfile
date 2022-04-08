FROM python:3-alpine

LABEL maintainer "eric@alluvium.com"

COPY start.sh /
RUN mkdir /www

EXPOSE 8080

WORKDIR /www

ENTRYPOINT ["/start.sh"]
