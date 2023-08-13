FROM ubuntu:22.04

ARG USER_NAME USER_ID GROUP_NAME GROUP_ID PASSWORD IMAGE_NAME

RUN if [ -z "${USER_NAME}"  ] || \
       [ -z "${USER_ID}"    ] || \
       [ -z "${GROUP_NAME}" ] || \
       [ -z "${GROUP_ID}"   ] || \
       [ -z "${PASSWORD}"   ];   \
    then echo "Please specify args"; \
    exit 1; \
    fi

# basic
RUN apt update -y

# add user and group
RUN groupadd -g $GROUP_ID $GROUP_NAME
RUN useradd -u $USER_ID -g $GROUP_ID -m $USER_NAME
RUN echo "$USER_NAME:$PASSWORD" | chpasswd

# ESP-IDF Prerequisites
RUN apt install -y git wget flex bison gperf python3 python3-pip python3-setuptools cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0
RUN apt install -y g++ 

# Get ESP-IDF
USER ${USER_ID}
RUN mkdir -p ~/esp
RUN git clone --recursive https://github.com/espressif/esp-idf.git -b v4.4.4 ~/esp/esp-idf

# ESP-IDF Set up the tools
RUN ~/esp/esp-idf/install.sh esp32
RUN echo "alias get_idf='. $HOME/esp/esp-idf/export.sh'" > ~/.bash_aliases

# Set Prompt
RUN echo PS1="'(docker)${IMAGE_NAME}:\w${PS1}'" >> ~/.bashrc
