iceScrum docker image
=====================
*based on canercandan/icescrum image*


### Start a mysql instance

```
docker run --name is-mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword -d mysql
```

### Create the icescrum database

```
docker run -it --link is-mysql:mysql --rm mysql sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD" -e "create database icescrum;"'
```

### Start the icescrum instance

```
docker run -d -p 8080:8080 -e ICESCRUM_EMAIL_DEV=dev@icescrum.org -e ICESCRUM_EMAIL_WEBMASTER=webmaster@icescrum.org -e ICESCRUM_SERVER_URL=http://localhost:8080/icescrum -e ICESCRUM_MAIL_USERNAME=username@gmail.com -e ICESCRUM_MAIL_PASSWORD=mypassword --link is-mysql:db dehy/icescrum
```

You can now connect to your new iceScrum instance from the following address: http://localhost:8080

### Credentials

Get ready to access to the admin account thanks to the following credentials:

username: admin
password: adminadmin!
