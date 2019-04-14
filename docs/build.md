Building
========

The image can be built from source by running:

        docker build .

A recommended security practice is to add an additional unprivileged user to run the daemon as on the host. For example, as a privileged user, run this on the host:

        useradd piond

To build an image which uses this unprivileged user's id and group id, run:

        docker build --build-arg USER_ID=$( id -u piond ) --build-arg GROUP_ID=$( id -g piond ) .

Now, when the container is run with the default options, the piond process will only have the privileges of the piond user on the host machine. This is especially important for a process such as piond which runs as a network service exposed to the internet.
