FROM debian:jessie-slim as Freebasic

# Required by Freebasic
# @see https://freebasic.net/wiki/DevBuildLinux
RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	gcc \
	make \
	zip \
	unzip \
	valgrind \
	libncurses5-dev \
	libffi-dev \
	libxrender-dev \
	libxrandr-dev \
	libxpm-dev \
	libx11-dev \
	libxext-dev \
	libgpm-dev \
	libcmocka0 \
	libgl1-mesa-dev

# Cannot wget / curl it for some reason => Inspect
COPY ./FreeBASIC-1.05.0-linux-x86_64.tar.gz /usr/local/Freebasic.tar.gz

WORKDIR /usr/local/

RUN tar -xf Freebasic.tar.gz \
	&& cd ./FreeBASIC-1.05.0-linux-x86_64 \
	&& ./install.sh -i \
	&& cd .. \
	&& rm -rf ./FreeBASIC-1.05.0-linux-x86_64 Freebasic.tar.gz

# Final cleaning => Significantly decrease image size
RUN apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

CMD [ "tail", "-f", "/dev/null" ]
