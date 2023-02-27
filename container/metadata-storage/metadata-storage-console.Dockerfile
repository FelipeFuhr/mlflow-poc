FROM dpage/pgadmin4:6.20@sha256:2efd6d20c528e939f28257bdb0160b3907a677151199a11a4e72c9704697ab70

USER root

RUN chmod a-w /etc

USER pgadmin

EXPOSE 80
