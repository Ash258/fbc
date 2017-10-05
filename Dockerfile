FROM debian:jessie-slim as Freebasic

# Required by Freebasic
# @see https://freebasic.net/wiki/DevBuildLinux
# sudo apt install gcc make lib{ncurses5,gpm,x11,xext,xpm,xrandr,xrender,gl1-mesa,ffi}-dev
# sudo apt-get install gcc make lib{ncurses5,gpm,x11,xext,xpm,xrandr,xrender,gl1-mesa,ffi}-dev
RUN apt-get update && apt-get install -y --no-install-recommends \
	ca-certificates \
	gcc \
	make \
	valgrind \
	bzip2 \
	zip \
	unzip \
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
COPY ./FreeBASIC-1.05.0-linux-x86_64.tar.gz ./Criterion-v2.3.2-linux-x86_64.tar.bz2 /usr/local/

WORKDIR /usr/local/

# Freebasic
RUN tar -xf FreeBASIC-1.05.0-linux-x86_64.tar.gz \
	&& cd ./FreeBASIC-1.05.0-linux-x86_64 \
	&& ./install.sh -i \
	&& cd .. \
	&& tar -xjf Criterion-v2.3.2-linux-x86_64.tar.bz2 \
	&& cd criterion-v2.3.2 \
	&& cp -r * /usr/

# Final cleaning => Significantly reduce image size
RUN apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	&& cd /usr/local/ \
	&& rm -rf ./criterion-v2.3.2 ./Criterion-v2.3.2-linux-x86_64.tar.bz2 \
	./FreeBASIC-1.05.0-linux-x86_64 ./FreeBASIC-1.05.0-linux-x86_64.tar.gz

CMD [ "tail", "-f", "/dev/null" ]
