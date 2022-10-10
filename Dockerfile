#
# ISO-2022-JP MailHog Dockerfile
# @see https://bitbucket.org/symfo/pymailhog/src/master/
#

FROM python:3.10.7-alpine3.16

# Install MailHog:
RUN apk --no-cache add --virtual build-dependencies \
    git \
  && git clone https://bitbucket.org/symfo/pymailhog.git \
  && apk del build-dependencies \
# Add mailhog user/group with uid/gid 1000.
# This is a workaround for boot2docker issue #581, see
# https://github.com/boot2docker/boot2docker/issues/581
  && adduser -D -u 1000 mailhog

USER mailhog

WORKDIR /pymailhog

ENTRYPOINT ["python", "PyMailHog"]

# Expose the SMTP and HTTP ports:
EXPOSE 1025 8025
