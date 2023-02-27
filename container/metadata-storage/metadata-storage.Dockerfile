FROM postgres:alpine3.17@sha256:53a02ecbe9d18ff6476e6651c34811da39f054424c725fc15d2b480fc3fab877

RUN chmod a-w /etc

EXPOSE 5432
