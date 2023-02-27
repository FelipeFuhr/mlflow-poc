FROM mlflow-base

WORKDIR /home/application

COPY application/ /home/application/

RUN pip3 install -r requirements.txt && \
    ln -s /usr/bin/python3  /usr/bin/python

# USER application

ENTRYPOINT ["/bin/bash", "-c", "sleep", "7200"]