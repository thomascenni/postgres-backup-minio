FROM alpine:3.14

LABEL maintainer="Thomas Cenni <hello@thomascenni.com>"

ENV MINIO_MC_VERSION mc.RELEASE.2021-09-02T09-21-27Z

ADD . /
RUN sh install.sh && rm install.sh

CMD ["sh", "run.sh"]
