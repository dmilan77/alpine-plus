FROM golang:alpine3.10

LABEL maintainer="Milan Das <milan.das77@gmail.com>"


# Metadata

ENV KUBE_LATEST_VERSION="v1.15.1"
ENV APP_HOME  /opt/kubeconfig-app
WORKDIR $APP_HOME

RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && apk add  --no-cache git \
 && apk add  --no-cache bash \
 && apk add  --no-cache curl \
 && apk add  --no-cache jq \
 && apk add  --no-cache util-linux \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_LATEST_VERSION}/bin/linux/amd64/kubectl -o /opt/kubeconfig-app/kubectl \
 && chmod +x /opt/kubeconfig-app/kubectl \
 && apk del --purge deps \
 && rm /var/cache/apk/* 

