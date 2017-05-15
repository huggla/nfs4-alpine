FROM alpine

COPY ./bin/start-nfs /start-nfs

RUN set -xe \
  && apk add --no-cache --no-progress nfs-utils \
  && mkdir -p /var/lib/nfs/v4recovery \
  && adduser -h /nfs-share -D -u 1000 nfsuser \
  && chown :nfsuser /start-nfs /var/lib/nfs /var/run \
  && chmod u=rwx,g=rx,o= /start-nfs \
  && chmod ug=rw,o= /etc/exports \
  && chmod ug=rwx,o= /var/lib/nfs /var/run
  #&& chmod 6750 /usr/sbin/exportfs /sbin/rpcbind /usr/sbin/rpc.nfsd /usr/sbin/rpc.mountd \

ENV EXPORT_SETTINGS rw,fsid=0,sync,no_subtree_check,no_auth_nlm,insecure,no_root_squash,crossmnt,no_acl
EXPOSE 111/tcp 111/udp 2049/tcp 2049/udp
VOLUME /nfs-share
WORKDIR /nfs-share

CMD ["/start-nfs"]
