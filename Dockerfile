FROM docker:17.12.0-ce as static-docker-source

FROM alpine:3.10
# docker run -it --rm dmilan/alpine-plus
LABEL maintainer="Milan Das <milan.das77@gmail.com>"


# Metadata

ENV KUBE_LATEST_VERSION="v1.15.1"

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && apk add  --no-cache git \
 && apk add  --no-cache bash \
 && apk add  --no-cache curl \
 && apk add  --no-cache jq \
 && apk add  --no-cache util-linux \
 && apk add --update --no-cache bind-tools \
 && apk add --update --no-cache nmap \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /usr/bin/kubectl \
 && chmod +x /usr/bin/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/* 
# Install aws-cli
RUN apk -Uuv add groff less python py-pip
RUN pip install awscli
RUN apk --purge -v del py-pip

ARG CLOUD_SDK_VERSION=289.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION
ENV CLOUDSDK_PYTHON=python3

ENV PATH /google-cloud-sdk/bin:$PATH
COPY --from=static-docker-source /usr/local/bin/docker /usr/local/bin/docker

RUN apk --no-cache add \
        curl \
        python3 \
        py3-crcmod \
        bash \
        libc6-compat \
        openssh-client \
        git \
        gnupg \
        postgresql-client \
        vim \
    && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version
RUN curl  https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip -o /tmp/terraform.zip --silent
RUN unzip /tmp/terraform.zip -d /tmp/
RUN chmod 755 /tmp/terraform
RUN mv /tmp/terraform /usr/bin/
RUN rm /var/cache/apk/*
RUN rm -rf /tmp/*
