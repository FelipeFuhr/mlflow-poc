FROM minio/minio:RELEASE.2023-02-22T18-23-45Z.fips@sha256:0bfb072e485137e42d7d55481756f66acc1c015550dd18614a1f10cd4845585b

RUN chmod a-w /etc                  && \
    groupadd --gid 2000 application && \
    useradd --uid 1000 --gid application --shell /bin/bash --create-home application && \
    rm -rf /bin/*

USER application

WORKDIR /home/application

EXPOSE 9000
EXPOSE 9001

ENTRYPOINT ["minio", "server"]
CMD ["/home/application/data", "--console-address", ":9001", "--address", ":9000"]
