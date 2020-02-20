FROM alpine:3.10

ARG ARCH=
ARG DRONE_TAG=
ARG KUBECTL_VERSION=

ENV K3S_RELEASE https://github.com/rancher/k3s/releases/download/${DRONE_TAG}/k3s${ARCH}
ENV K3S_RELEASE_CHECKSUM https://github.com/rancher/k3s/releases/download/${DRONE_TAG}/sha256sum${ARCH}.txt

RUN apk add -U jq curl
#RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl \
#    && chmod +x ./kubectl \
#    &&  mv ./kubectl /bin/kubectl
RUN curl -L -o /opt/k3s ${K3S_RELEASE}
RUN chmod +x /opt/k3s
COPY scripts/upgrade.sh /bin/upgrade.sh

ENTRYPOINT ["/bin/upgrade.sh"]
CMD ["upgrade"]
