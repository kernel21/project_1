FROM ubuntu:18.04
COPY requirements.txt /tmp/
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y -q python-all python-pip
RUN mkdir /opt/webapp/
COPY * /opt/webapp/
RUN pip install -qr /tmp/requirements.txt
WORKDIR /opt/webapp/
EXPOSE 5000
CMD python ./app.py
