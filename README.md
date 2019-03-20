# hashicorp-ci

container with packer & terraform for hashicorp based CI/CD pipeline usage

This uses `alpine:latest` as the base, and then adds in packer & terraform,
using the same techniques Hashicorp use to build their own packer & terraform
containers:

* [hashicorp/packer:light](https://github.com/hashicorp/docker-hub-images/blob/master/packer/Dockerfile-light)
* [hashicorp/terraform:light](https://github.com/hashicorp/terraform/blob/master/scripts/docker-release/Dockerfile-release)


## build

    ./build.sh

## test/experiment


    docker run -it --rm jenkins201/hashicorp-ci:latest /bin/ash
