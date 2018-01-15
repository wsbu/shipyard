# wsbu/toolchain-linaro:4.9
#
# Example creation and upload of Conan library:
#   ```
#   docker run -it --rm \
#     -u $(id -u):$(id -g) \
#     -v $HOME/.conan/.conandb:/home/captain/.conan/.conan.db \
#     -v $HOME/.conan/data:/home/captain/.conan/data \
#     -v `pwd`:/opt/project \
#     wsbu/toolchain-linaro:4.9 \
#     conan create /opt/project <reference>
#   conan upload -r <remote> --all <reference>
#   ```
#
# Example build of CMake project:
#   ```
#   mkdir bin
#   docker run -it --rm \
#     -u $(id -u):$(id -g) \
#     -v `pwd`:/opt/project \
#     -w /opt/project/bin \
#     wsbu/toolchain-linaro:4.9 \
#     cmake -D CMAKE_TOOLCHAIN_FILE="${CMAKE_TOOLCHAIN_FILE}" ..
#   docker run -it --rm \
#     -u $(id -u):$(id -g) \
#     -v `pwd`:/opt/project \
#     -w /opt/project/bin \
#     wsbu/toolchain-linaro:4.9 \
#     make -j4
#   ```

FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install --yes --no-install-recommends \
  wget \
  xz-utils \
  make \
  automake \
  libtool \
  flex \
  bison

ENV GCC_PREFIX /opt/linaro-4.9.4
RUN mkdir -p ${GCC_PREFIX} \
  && txz="http://releases.linaro.org/components/toolchain/binaries/latest-4/arm-linux-gnueabihf/gcc-linaro-4.9.4-2017.01-x86_64_arm-linux-gnueabihf.tar.xz" \
  && wget -qO- ${txz} | tar -xJ --strip-components=1 -C ${GCC_PREFIX}

RUN wget --no-check-certificate --quiet -O /tmp/cmake.sh https://cmake.org/files/v3.10/cmake-3.10.1-Linux-x86_64.sh && \
sh /tmp/cmake.sh --prefix=/usr/local --exclude-subdir --skip-license && \
rm /tmp/cmake.sh

ENV CC "${GCC_PREFIX}/bin/arm-linux-gnueabihf-gcc"
ENV CXX "${GCC_PREFIX}/bin/arm-linux-gnueabihf-g++"
ENV EMULATOR "/usr/bin/qemu-arm"
# Make qemu work correctly: http://nairobi-embedded.org/qemu_usermode.html
ENV QEMU_LD_PREFIX "${GCC_PREFIX}/arm-linux-gnueabihf/libc"
ENV CMAKE_TOOLCHAIN_FILE "/opt/Toolchain.cmake"
ENV PATH "${GCC_PREFIX}/bin:${PATH}"
COPY linaro-4.9.4.cmake /opt/
RUN ln --symbolic --force /opt/linaro-4.9.4.cmake /opt/linaro.cmake \
  && ln --symbolic --force /opt/linaro.cmake "${CMAKE_TOOLCHAIN_FILE}"

# Lots of things complain if we are homeless
ENV HOME /home/captain
RUN mkdir --parents ${HOME}/.ccache

# Install utilities
RUN apt-get install --yes --no-install-recommends \
  qemu-system-arm \
  qemu-user \
  pkg-config \
  python-pip \
  python-setuptools \
  python-wheel

# Install Conan
RUN pip install conan==1.0.1
COPY conan/sitara_profile "${HOME}/.conan/profiles/default"
COPY conan/settings.yml "${HOME}/.conan/settings.yml"
COPY conan/registry.txt "${HOME}/.conan/registry.txt"
ENV CONAN_CMAKE_TOOLCHAIN_FILE "$CMAKE_TOOLCHAIN_FILE"
ENV CONAN_PRINT_RUN_COMMANDS 1

RUN chmod -R 777 "${HOME}"

# Cleanup
#RUN apt-get purge --yes \
#  wget \
#  xz-utils && \
#  apt-get autoremove --yes && \
#  apt-get clean && \
#  rm --recursive --force /var/lib/apt/lists/*

