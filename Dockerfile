FROM alpine:latest

RUN apk add --update git bash wget openssl groff less python py-pip jq perl openssh
RUN pip install --quiet awscli

# https://github.com/hashicorp/docker-hub-images/blob/master/packer/Dockerfile-light
ENV PACKER_VERSION=1.3.4
ENV PACKER_SHA256SUM=73074f4fa07fe15b5d65a694ee7afae2d1a64f0287e6b40897adee77a7afc552

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
RUN sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

ENV TERRAFORM_VERSION=0.11.13

# https://github.com/hashicorp/terraform/blob/master/scripts/docker-release/Dockerfile-release
COPY releases_public_key .

# What's going on here?
# - Download the indicated release along with its checksums and signature for the checksums
# - Verify that the checksums file is signed by the Hashicorp releases key
# - Verify that the zip file matches the expected checksum
# - Extract the zip file so it can be run

RUN echo Building image for Terraform ${TERRAFORM_VERSION} && \
    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig && \
    wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    apk add --update gnupg && \
    gpg --import releases_public_key && \
    gpg --verify terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    apk del gnupg && \
    grep linux_amd64 terraform_${TERRAFORM_VERSION}_SHA256SUMS >terraform_${TERRAFORM_VERSION}_SHA256SUMS_linux_amd64 && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS_linux_amd64 && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip terraform_${TERRAFORM_VERSION}_SHA256SUMS*

# irrelevant
CMD ["/bin/ash"]
