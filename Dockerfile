FROM python:alpine3.19

RUN pip install yamlfix 

WORKDIR /yamlfix-action

COPY entrypoint.sh /yamlfix-action/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

