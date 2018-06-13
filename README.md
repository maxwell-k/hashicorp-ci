# hashicorp-ci

container with packer & terraform for hashicorp based CI/CD pipeline usage



We use maven:3-alpine as the base, and then add in packer, in the same fashion as Hashicorp build there own packer container

* https://github.com/carlossg/docker-maven/tree/798decbb2f987a14f345c017f8fa3725c2467758/jdk-8-alpine
* https://hub.docker.com/r/hashicorp/packer/~/dockerfile/

## build

## test/experiment


    docker run -it --rm jenkins201/hashicorp-ci:latest /bin/ash
# hashicorp-ci
