FROM alpine:latest
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN apk add --update py3-pip nano wget
RUN python3
RUN pip install --break-system-packages pymodbus
RUN 
