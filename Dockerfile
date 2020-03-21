FROM alpine:3.11

ENV MOUNT_POINT=/var/s3
VOLUME /var/s3

ARG S3FS_VERSION=v1.86

RUN apk --update add fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev git bash;
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git; \
 cd s3fs-fuse; \
 git checkout tags/${S3FS_VERSION}; \
 ./autogen.sh; \
 ./configure --prefix=/usr; \
 make; \
 make install; \
 make clean; \
 apk del git automake autoconf; \
 rm -rf /var/cache/apk/*;

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]