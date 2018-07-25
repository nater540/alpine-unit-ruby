####################################################################
####################################################################
FROM alpine:3.8 AS base
LABEL maintainer="Nate Strandberg <nater540@gmail.com>"

# Destination directory for the application
ENV INSTALL_PATH /app/current

# Destination directory for nginx unit
ENV DESTDIR /opt/unit/

WORKDIR ${INSTALL_PATH}

COPY ./scripts /scripts
RUN apk --no-cache add bash

RUN /scripts/base_packages.sh && \
  /scripts/install_ruby.sh

####################################################################
####################################################################
FROM base AS nginx-unit

RUN /scripts/build_unit.sh

# ####################################################################
# ####################################################################
FROM base AS final-destination

COPY --from=nginx-unit ${DESTDIR} ${DESTDIR}

ADD ./tests .

RUN ln -sf /dev/stdout /var/log/unitd.log

# RUN apk --no-cache add tree
COPY ./config.json /opt/unit/state

ENTRYPOINT ["/usr/local/bin/dumb-init", "--rewrite", "15:3", "--"]
CMD ["/opt/unit/sbin/unitd", "--no-daemon", "--control", "0.0.0.0:8080", "--modules", "/opt/unit/modules", "--state", "/opt/unit/state"]
# CMD ["tree", "/opt/unit"]
