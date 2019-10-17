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
RUN rm /var/cache/apk/*
