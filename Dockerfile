FROM python:3.9-bookworm
LABEL maintainer="zuzej.de"

ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false
# RUN apt-get update && apt-get install firebird-dev libfbclient2 libgdsii-dev libib-util -y
# RUN git clone git://github.com/maxirobaina/django-firebird.git
# RUN ln -s django-firebird/firebird firebird
# RUN cd /usr/local/lib/python3.8/dist-packages/django/db/backends
# RUN ln -s /usr/local/lib/python3.8/dist-packages/django-firebird/firebird
RUN python -m venv /py && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install django-utils-six && \
#    /py/bin/pip install fdb && \
#    /py/bin/pip install firebird-driver && \
#    /py/bin/pip install django-firebird && \
#    /py/bin/pip install firebird-lib && \
#    /py/bin/pip install psycopg2 && \
    if [ $DEV = "true" ]; \
        then /py/bin/pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user 
# USER root
