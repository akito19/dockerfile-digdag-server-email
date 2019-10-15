FROM java:8-alpine

ENV DIGDAG_VERSION=0.9.39

# Ref: https://github.com/myui/dockernized-digdag-server/blob/master/Dockerfile
RUN apk add curl --no-cache && \
    curl -o /usr/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-$DIGDAG_VERSION" && \
    chmod +x /usr/bin/digdag && \
    adduser -h /var/lib/digdag -g 'digdag user' -s /sbin/nologin -D digdag && \
    mkdir -p /var/lib/digdag/logs/tasks /var/lib/digdag/logs/server && \
    chown -R digdag.digdag /var/lib/digdag && \
    rm -rf /var/cache/apk/*

COPY digdag.properties /etc/digdag.properties
COPY secret-access-policy.yaml /home/digdag/.config/digdag/secret-access-policy.yaml
COPY config /home/digdag/.config/digdag/config

USER digdag

WORKDIR /var/lib/digdag

# Server mode command line args
# https://docs.digdag.io/command_reference.html#server-mode-commands
EXPOSE 65432
CMD exec digdag server --bind 0.0.0.0 \
                       --port 65432 \
                       --config /etc/digdag.properties \
                       --log /var/lib/digdag/logs/server \
                       --task-log /var/lib/digdag/logs/tasks \
