FROM python:3.6

LABEL maintainer="Hyperlync Technologies <roni@hyperlync.com>" \
      version="1.0"

RUN pip install --upgrade pip
RUN mkdir -p /app
WORKDIR /app

COPY ./app/requirements.txt requirements.txt
RUN pip install -r requirements.txt

EXPOSE 80

COPY ./app /app

ENV UWSGI_INI /app/uwsgi.ini

CMD gunicorn -b 0.0.0.0:80 application:app