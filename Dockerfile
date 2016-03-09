
FROM alpine:3.3

RUN \
	mkdir -p /aws && \
	apk -Uuv add python py-pip bash curl && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

COPY entry /usr/bin/entry
COPY tools/* /usr/bin/tools/

ENTRYPOINT ["/usr/bin/entry"]
CMD ["help"]

