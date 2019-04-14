# Debugging

## Things to Check

* RAM utilization -- piond is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The pion blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 2GB+ is necessary.

## Viewing piond Logs

    docker logs piond-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the piond node, but will not connect to already running containers or processes.

    docker run -v piond-data:/pion --rm -it pioncoin/piond bash -l

You can also attach bash into running container to debug running piond

    docker exec -it piond-node bash -l


