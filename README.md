# Harden Nginx Based On CIS Benchmark

Based on the CIS benchmark, I have prepared a fully hardened Nginx web server.
You can download the deb file and install it on ubuntu. I have included a docker file for those who want a docker image. All the configurations are included in this repo. You can copy and paste them into your configuration, but installing using a deb file does all the work, including permissions.

*Notes*
* Nginx version: 1.20.2
* I have assumed SSL certificates will be offloaded on Firewall UTMs.
* If you need to install the certificate on the Nginx web server, you should follow CIS Benchmark SSL Section.

## Table of Contents

* [Install](#install)
  * [Debian_file](#debian_file)
  * [Docker](#docker)
  * [Script](#script)
  
## Install

### Debian_file

You can install the deb file using the below command:

```
dpkg -i nginx_1.20.2-1_all.deb
```
Or if you need to build your deb file, clone the repository and edit "postinst" or "preinst" file according to your needs, and then run the following command:

```
dpkg --build nginx_1.20.2-1_all
```

** All the configs are located inside the nginx_1.20.2-1_all folder.


### Docker

Check the Dockerfile. I have used nginx-alpine as my base image. Replace all the configurations with custom configs. You should harden the docker container also for the best security. 

```
docker build -t harden-nginx .
```


### Script

You can run the "install" script to install a harden Nginx from source. 

```
bash install.sh
```

---
**Final Note**

If you have any recommendations, I would appreciate it. 
---
