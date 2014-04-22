mercury-bootstrap
=================

A [docker.io](https://www.docker.io) Dockfile for creating a bootstrapping [Mercury](https://github.com/Mercury-Language/mercury) compiler.
This is the source for the [sebgod/mercury-bootstrap](https://index.docker.io/u/sebgod/mercury-bootstrap) repository.

Since the trusted build fails to execute `apt-get install openjdk-7-jdk`, the base repository is using a pre-installed Java (1.7.51)
