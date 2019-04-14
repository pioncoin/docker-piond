Piond for Docker
================

[![Docker Stats](http://dockeri.co/image/pioncoin/piond)](https://hub.docker.com/r/pioncoin/piond/)

[![Build Status](https://travis-ci.org/pioncoin/docker-piond.svg?branch=master)](https://travis-ci.org/pioncoin/docker-piond/)


Docker image that runs the Pion piond node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. Vultr, Digital Ocean, KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 4 GB to store the block chain files
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on Vultr 1024 MB RAM/320 GB disk instance @ $8/mo.  Vultr also *accepts Bitcoin payments*!  May run on the 512 MB instance, but took *forever* (1+ week) to initialize due to swap and disk thrashing.


Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/pioncoin/docker-piond/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `piond-data` volume to persist the piond blockchain data, should exit immediately.  The `piond-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=piond-data
        docker run -v piond-data:/pion --name=piond-node -d \
            -p 9953:9953 \
            -p 127.0.0.1:9954:9954 \
            pioncoin/piond

2. Verify that the container is running and piond node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        pioncoin/piond:latest          "pion_oneshot"      2 seconds ago       Up 1 seconds        127.0.0.1:9954->9953/tcp, 0.0.0.0:9954->9954/tcp   piond-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f piond-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* To run in testnet, add environment variable `TESTNET=1` to `docker run` as such:

        docker run -v piond-data:/pion --name=piond-node -d \
            --env TESTNET=1 \
            -p 19954:19954 \
            -p 127.0.0.1:19953:19953 \
            pioncoin/piond

* Additional documentation in the [docs folder](docs).

Credits
-------

Original work by Kyle Manna [https://github.com/kylemanna/docker-bitcoind](https://github.com/kylemanna/docker-bitcoind).
Modified to use Pion Core instead of Bitcoin Core.

