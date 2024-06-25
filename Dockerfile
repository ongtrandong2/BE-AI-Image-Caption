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
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN apt install -y python3.10 python3.10-distutils python3.10-venv
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

RUN pip install numpy
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install -r requirements.txt

EXPOSE 80

CMD gunicorn --bind 0.0.0.0:80 app:app
