# dockerfile-digdag-server-email

This is Dockerfile of [Digdag](https://github.com/treasure-data/digdag) server to test for email sending.

### Pull and Run this image

```
docker pull akito19/digdag-server-email-sending:latest
docker run -p 65432:65432 akito19/digdag-server-email-sending
```

Then, access to http://localhost:65432

### Requirements

When using email on Digdag server, you need to prepare some secrets such as `host`, `port`, `username`, `password` and so on.
The details are in [the docs](https://docs.digdag.io/operators/mail.html?highlight=email#mail-sending-email).

Therefore, this dockerfile expects these configuration have been put in `~/.config/digdag/config` like:

```
digdag.secret-access-policy-file = secret-access-policy.yml
digdag.secret-encryption-key = your encryption key
secrets.mail.host = smtp.gmail.com
secrets.mail.password = PASSWORD
...
```

A sample workflow is in [here](https://github.com/akito19/dockerized-digdag-server-email/sample).

If you try it by Gmail, [This document](https://support.google.com/accounts/answer/185833?hl=en) will help you when setting.
