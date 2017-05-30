# nfs4-alpine
Docker image with NFS4, based on Alpine.

This container will use the volume mounted at /nfs-share as the directory that will be shared over NFS. Export settings can be set with the EXPORT_SETTINGS environment variable.

Add the SYS_ADMIN capability or run in privileged mode. Capabilities SETGID and SETUID is maybe also needed, the rest can be droped.

Depending on which operating system Docker is run on, installed security modules (e.g. selinux, appArmor) might prevent NFS from starting. To overcome this you can run the container in privileged mode or add extra parameters to the run command. On Ubuntu add --security-opt apparmor:unconfined. 
