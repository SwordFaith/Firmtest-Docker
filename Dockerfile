FROM skysider/pwndocker
LABEL maintainer="swordfaith <mindsculptor@yeah.net>"

RUN apt-get -y update && \
	apt-get install -y \
	build-essential \
	pkg-config \
	libglib2.0-dev \
	gdb-multiarch \
	'binfmt*' \
	pandoc \
	postgresql \
	postgresql-contrib \
	python-dev \
	python3-dev \
	libc6-mipsel-cross \
	libc6-dbg-mipsel-cross \
	libc6-mips-cross \
	libc6-dbg-mips-cross \
	libc6-mips64el-cross \
	libc6-dbg-mips64el-cross \
	libc6-mips64-cross \
	libc6-dbg-mips64-cross \
	libc6-armel-cross \
	libc6-dbg-armel-cross \
	libc6-armhf-cross \
	libc6-dbg-armhf-cross \
	libc6-arm64-cross \
	libc6-dbg-arm64-cross \
	libxml2-dev \
	libxslt-dev \
	libssl-dev \
	libffi-dev \
	socat wget patch \
	binwalk autoconf automake libtool \
	libffi-dev libssl-dev libpixman-1-dev \
	libncurses5-dev \ 
	flex --fix-missing && \
	rm -rf /var/lib/apt/list/*

RUN pip install cryptography==2.5 \
	mitmproxy &&  \
	rm -rf /tmp/*

COPY qemu-4.1.0.tar.xz qemu-4.1.0.tar.xz
RUN tar xvJf qemu-4.1.0.tar.xz && cd qemu-4.1.0 && \
	./configure && make && make install && cd .. && rm -rf qemu*

# Install buildroot
COPY buildroot-2018.11.3.tar.gz buildroot-2018.11.3.tar.gz
#RUN wget -q http://buildroot.org/downloads/buildroot-2018.11.3.tar.gz \
#    | tar xz && mv buildroot-2018.11.3 /opt/buildroot
RUN tar xzvf buildroot-2018.11.3.tar.gz && mv buildroot-2018.11.3 /opt/buildroot \
	&& rm buildroot-2018.11.3.tar.gz

# Apply patches
COPY patches /opt/buildroot/patches
RUN cd /opt/buildroot && \
	for patch in /opt/buildroot/patches/*.patch; do echo "Applying patch '$patch'" && patch -p1 < "$patch"; done

CMD ["/sbin/my_init"]