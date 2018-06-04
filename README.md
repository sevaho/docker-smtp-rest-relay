# docker-smtp-rest-relay

A simple python docker SMTP rest relay

Run:

```
$ mv app/.env-example app/.env
```

Edit the .env file.

Then run:

```
$ make docker
```

And now you can do something like:

```
$ curl -H "Content-Type: application/json" -X POST -d '{"from":"sebastiaan@sevaho.io", "to":"sebastiaan@sevaho.io", "message": "hell yeah", "code":"test"}' http://localhost:8000/sendmail
```
