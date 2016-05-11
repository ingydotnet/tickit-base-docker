FROM alpine:latest

# Use for development:
COPY build.sh /
RUN time sh /build.sh false

# Use for final run (after pushing to GitHub):
# RUN apk --update add openssl && \
#     wget https://raw.githubusercontent.com/ingydotnet/tickit-base-docker/master/build.sh && \
#     time sh /build.sh true
