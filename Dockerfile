FROM alpine:latest

COPY Dockerfile.sh /

RUN /Dockerfile.sh
