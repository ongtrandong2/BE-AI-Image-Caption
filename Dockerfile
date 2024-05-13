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
RUN apt install -y python3 python3-pip git

RUN pip install numpy
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install -r requirements.txt

EXPOSE 80

CMD flask run --host 0.0.0.0 -p 80