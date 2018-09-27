####################################################################
####################################################################
FROM alpine:3.8 AS base
LABEL maintainer="Nate Strandberg <nater540@gmail.com>"

# Destination directory for the application
ENV INSTALL_PATH /app/current

# Destination directory for nginx unit
ENV DESTDIR /opt/unit/

WORKDIR ${INSTALL_PATH}

RUN apk --no-cache add bash
COPY ./scripts /scripts

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

ADD ./examples .

RUN ln -sf /dev/stdout /var/log/unitd.log

COPY ./conf.json /opt/unit/state

# RUN apk --no-cache add tree

ENTRYPOINT ["/usr/local/bin/dumb-init", "--rewrite", "15:3", "--"]
CMD ["/opt/unit/sbin/unitd", "--no-daemon", "--control", "0.0.0.0:8080", "--modules", "/opt/unit/modules", "--state", "/opt/unit/state"]
