FROM alpine:3.3

RUN \
	mkdir -p /aws && \
	apk --no-cache add python py-pip groff ca-certificates && \
	pip install awscli && \
	apk --purge -v del py-pip py-setuptools && \
    adduser -D user

USER user

COPY entry /usr/bin/entry
COPY tools/* /usr/bin/tools/

ENTRYPOINT ["/usr/bin/entry"]
CMD ["help"]