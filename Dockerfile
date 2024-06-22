FROM ubuntu:20.04

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . .

RUN apt update

ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

# Install necessary dependencies
RUN apt install -y libsndfile-dev openjdk-8-jdk git

# Install Python 3.9 and set it as default
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN apt install -y python3.9 python3.9-distutils python3-pip

# Update alternatives to use Python 3.9 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2
RUN update-alternatives --set python3 /usr/bin/python3.9

RUN pip install numpy
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install -r requirements.txt

EXPOSE 80

CMD ["flask", "run", "--host=0.0.0.0", "-p", "80"]
