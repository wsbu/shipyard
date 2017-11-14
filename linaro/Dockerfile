FROM ubuntu

RUN apt-get update && apt-get install --yes --no-install-recommends \
  cmake \
  wget \
  xz-utils \
  && rm --recursive --force /var/lib/apt/lists/*

ENV WSBU_TOOLCHAIN_PATH /opt/linaro-4.9.4
RUN mkdir -p ${WSBU_TOOLCHAIN_PATH} \
  && txz="http://releases.linaro.org/components/toolchain/binaries/latest-4/arm-linux-gnueabihf/gcc-linaro-4.9.4-2017.01-i686_arm-linux-gnueabihf.tar.xz" \
  && wget -qO- ${txz} | tar -xJv --strip-components=1 -C ${WSBU_TOOLCHAIN_PATH}

RUN apt-get purge --yes \
  wget \
  xz-utils \
  && apt-get autoremove --yes

COPY linaro-4.9.4.cmake /opt/
RUN ln --symbolic --force linaro-4.9.4.cmake /opt/linaro.cmake \
  && ln --symbolic --force linaro.cmake /opt/toolchain.cmake
