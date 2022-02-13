# Harden Nginx Based On CIS Benchmark

I have prepared a fully hardened Nginx web server based on the CIS benchmark.
You can download the deb file and install it on ubuntu. I have included a docker file for those who want a docker image. all the configurations are included in this repo, you can copy and paste them into your configuration; but installing using deb file does all the work including permissions.

*Notes*
* Nginx version: 1.20.2
* I have assumed SSL certificates will be offloaded on Firewall UTMs.
* If you need to install certificate on the nginx webserver, you should follow CIS Benchmark SSl Section.

## Table of Contents

* [Install](#install)
  * [Debian_file](#debian_file)
  * [Docker](#docker)
  
## Install

### Debian_file

Simply you can install the deb file using below command:

```
dpkg -i nginx_1.20.2-1_all.deb
```
Or if you need to build your own deb file, clone the repository and edit "postinst" or "preinst" file according to your needs and then run the following command:

```
dpkg --build nginx_1.20.2-1_all
```

** All the configs are located inside nginx_1.20.2-1_all folder.


### Docker

Check the Dockerfile. i have used nginx-lpine as my base image. Replace all the configuration with custom configs. You shoud harden docker container also for best security. 

```
docker build -t harden-nginx .
```

*Recommendation*

* If you have any recomendation, I would appreciate it. 
