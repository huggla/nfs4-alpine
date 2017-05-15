# nfs4-alpine
Docker image with NFS4, based on Alpine.

This container will use the volume mounted at /nfs-share as the directory that will be shared over NFS. Export settings can be set with the EXPORT_SETTINGS environment variable.

Add the SYS_ADMIN capability or run in privileged mode.
