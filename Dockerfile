FROM alpine:latest
COPY build.sh /
RUN time sh /build.sh true
