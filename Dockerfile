FROM ubuntu:18.04

MAINTAINER andriikrymus@gmail.com

RUN apt-get update && \
    apt-get install -y iputils-ping && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo "#!/bin/bash" > /bootstrap.sh
RUN echo "while true; do echo 'Im not sleeping!!!'; sleep 5; done" >> /bootstrap.sh
RUN chmod +x "/bootstrap.sh"

HEALTHCHECK --interval=5s --timeout=5s --start-period=3s --retries=2 \
    CMD ["ping","-c", "1", "localhost"] || exit 1
ENTRYPOINT ["/bootstrap.sh"]
