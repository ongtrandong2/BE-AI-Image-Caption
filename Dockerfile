FROM ubuntu:20.04

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . .

RUN apt update

ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

RUN apt install -y libsndfile-dev
RUN apt install -y openjdk-8-jdk
# Install Python 3.9 and pip
RUN apt install -y python3.9 python3.9-distutils
RUN apt install -y curl
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9

RUN pip3.9 install numpy
RUN pip3.9 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
# Install fairseq from a pre-built wheel or specify the version
RUN pip3.9 install fairseq==0.10.2
RUN pip3.9 install -r requirements.txt

EXPOSE 80

CMD ["flask", "run", "--host=0.0.0.0", "-p", "80"]
