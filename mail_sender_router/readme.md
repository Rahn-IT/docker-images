# mail_sender_router

image: ``ghcr.io/rahn-it/mail_sender_router``

This is a really simple preconfigured Postfix instace, to route to the correct smarthost based on the sender.

There are 3 types of env variables. All of them are based on a counter. You can as many as you'd like.
Just make sure that you have all 3 variables set for each number.


``EMAIL_{counter}``
This variable is used to determine the sender.
e.g.:
```
EMAIL_1="@example.com"
EMAIL_2="@smarthost.com"
```


``SERVER_{counter}``
This variable contains the server to use for relaying.
e.g.:
```
SERVER_1="\[mail.example.com\]:587"
SERVER_2="\[mail.smarthost.com\]:25"
```


``CREDENTIALS_{counter}``
This variable contains the server to use for relaying.
e.g.:
```
CREDENTIALS_1="exampleadmin:examplepassword"
CREDENTIALS_2="smartadmin:supersecretpassword"
```
