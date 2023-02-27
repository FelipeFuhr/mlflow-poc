FROM mlflow-base

RUN chmod a-w /etc                  && \
    groupadd --gid 20001 application && \
    useradd --uid 10001 --gid application --shell /bin/bash --create-home application

USER application

WORKDIR /home/application
