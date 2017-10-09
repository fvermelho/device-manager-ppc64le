FROM ppc64le/python:2.7

RUN pip install wheel

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get -y install libevent-dev
RUN apt-get -y install python-all-dev

RUN pip install greenlet
RUN pip install gevent

RUN mkdir -p /usr/src/app/requirements
WORKDIR /usr/src/app

ADD . /usr/src/app
RUN pip install Cython-0.27.1-cp27-cp27mu-linux_ppc64le.whl
RUN ["python", "setup.py", "develop"]

EXPOSE 5000
CMD ["./docker/entrypoint.sh", "start"]

