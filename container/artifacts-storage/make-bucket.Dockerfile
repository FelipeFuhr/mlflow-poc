FROM minio/mc:RELEASE.2023-02-16T19-20-11Z@sha256:17de60de788e947c9200ae93d53628a10608f6dbda5ba86aac5096d50f96ae83

RUN chmod a-w /etc                  && \
    groupadd --gid 2000 application && \
    useradd --uid 1000 --gid application --shell /bin/bash --create-home application

USER application

WORKDIR /home/application

ENTRYPOINT ["/bin/bash", "-c", "sleep", "3600"]