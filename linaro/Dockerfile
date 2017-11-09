FROM ubuntu

RUN apt-get update && apt-get install --yes --no-install-recommends \
  cmake \
  wget \
  xz-utils \
  && rm --recursive --force /var/lib/apt/lists/*

RUN mkdir -p /opt/linaro-4.9.4 && wget -qO- http://releases.linaro.org/components/toolchain/binaries/latest-4/arm-linux-gnueabihf/gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabihf.tar.xz | tar -xJv --strip-components=1 -C /opt/linaro-4.9.4

RUN apt-get purge --yes \
  wget \
  xz-utils \
  && apt-get autoremove --yes

COPY *.cmake /opt/
