# vim: set ft=dockerfile:

FROM python:3-alpine

MAINTAINER sevaho

RUN apk --update add

ADD ./app /app

WORKDIR /app

RUN addgroup -S -g 1000 user && adduser -S -u 1000 -D -G user user
RUN chown -R user:user /app

USER user

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "app.py"]
ENTRYPOINT ["/home/user/.local/bin/gunicorn", "--access-logfile=-", "--workers=2", "--bind=0.0.0.0:8000", "app:app"]

EXPOSE 8000
