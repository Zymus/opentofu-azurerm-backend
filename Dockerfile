FROM docker.io/zymus/opentofu:latest as opentofu

RUN apk upgrade -l

WORKDIR /home/opentofu
COPY . .

RUN tofu init
