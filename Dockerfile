FROM python:alpine3.19

RUN pip install yamlfix 

WORKDIR /yamlfix-action

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

