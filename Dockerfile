
FROM alpine:3.3

RUN \
	mkdir -p /aws && \
	apk -Uuv add groff less python py-pip  bash && \
	pip install awscli && \
	apk --purge -v del py-pip && \
	rm /var/cache/apk/*

ADD aws-helpers /usr/bin/aws-helpers
WORKDIR /aws
CMD ["aws"]
