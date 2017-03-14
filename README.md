## Ventrilo

#### Ventrilo docker container based on Debian Jessie

_*You will need to download Ventrilo package for Linux i386 first [www.ventrilo.com/download.php](http://www.ventrilo.com/download.php)_

Build and deploy using docker-compose;

    $ docker-compose up -d --build

Build and deploy image manually;

    $ docker build -t ventrilo .
    $ docker run -d -p 3784:3784 -p 3784:3784/udp ventrilo
