# nfs4-alpine
Docker image with NFS v4, based on Alpine.

## Environment Variables

You could provide the following 3 environment variables to configure the nfs exports:

- NFS_EXPORT_DIR
- NFS_EXPORT_DOMAIN
- NFS_EXPORT_OPTIONS

When container start, the environment variables are parsed and put in `/etc/exports` file:

`NFS_EXPORT_DIR NFS_EXPORT_DOMAIN(NFS_EXPORT_OPTIONS)`

Default value is:

`/nfs-share *(rw,fsid=0,sync,no_subtree_check,no_auth_nlm,insecure,no_root_squash,crossmnt,no_acl)`

**This default configure is no security implemented, so use it only in a secure environment.**

## Run it

The `--privileged` parameter is needed in order to allow `exportfs` and `nfsd` run in container.

```
docker run --privileged -d --name=nfs \
  -p 111:111/tcp -p 111:111/udp \
  -p 2049:2049/tcp -p 2049:2049/udp \
  -v /tmp:/nfs-share flin/nfs4-alpine
```

Or simple use host network,

```
docker run --privileged -d --name=nfs \
  --network=host \
  -v /tmp:/nfs-share flin/nfs4-alpine
```

## Mount it

First check you have `mount.nfs` installed.

```
ls /sbin/mount.nfs
```

If this file doesn't exist, consider to install `nfs-common` package:

```
sudo apt-get install nfs-common
```

And change below `127.0.0.1` and `/mnt/nfs` to the nfs-server IP and mount destination.

```
sudo mount -v -t nfs -o vers=4,port=2049 127.0.0.1:/ /mnt/nfs
```
