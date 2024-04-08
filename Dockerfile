#
# Copyright 2021-2021 VMware, Inc.
# SPDX-License-Identifier: Apache-2.0
#
FROM bitnami/node:16

LABEL org.opencontainers.image.authors="https://bitnami.com/contact" \
      org.opencontainers.image.description="Readme Generator For Helm" \
      org.opencontainers.image.source="https://github.com/bitnami/readme-generator-for-helm" \
      org.opencontainers.image.title="readme-generator-for-helm" \
      org.opencontainers.image.vendor="VMware, Inc."

COPY . /app
WORKDIR /app
RUN npm install
RUN ln -s /app/bin/index.js /app/bin/readme-generator
RUN groupadd -g 10001 npm && \
    useradd -d /app -s /bin/bash -u 10000 -g npm npm && \
    chown -R npm:npm /app

USER npm

ENV PATH="/app/bin:$PATH"

ENTRYPOINT ["/app/bin/readme-generator"]
