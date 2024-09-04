FROM python:alpine3.19

RUN pip install yamlfix 

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

