# FROM python:3.13.0-alpine3.20
FROM python:3
LABEL maintainer="zuzej.de"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
RUN apt-get update && apt-get install firebird-dev libfbclient2 libgdsii-dev libib-util -y
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install firebird-driver && \
    /py/bin/pip install psycopg2 && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ]; \
      then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER root
