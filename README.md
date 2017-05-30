# nfs4-alpine
Docker image with NFS v4, based on Alpine.

This container will use the volume mounted at `/nfs-share` as the directory that will be shared over NFS.
Export settings can be set with the `EXPORT_SETTINGS` environment variable.

## Run it

The `--privileged` parameter is needed in order to allow container update `/proc/fs/nfs/exports` file and run `nfsd`.

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
sudo mount -v -t nfs -o vers=4 127.0.0.1:/ /mnt/nfs
```
