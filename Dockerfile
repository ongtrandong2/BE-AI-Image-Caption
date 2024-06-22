FROM ubuntu:20.04

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . .

RUN apt update

ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

# Install necessary dependencies
RUN apt install -y libsndfile-dev openjdk-8-jdk git software-properties-common build-essential

# Add repository for newer Python versions
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update

# Install Python 3.9 and development headers
RUN apt install -y python3.9 python3.9-dev python3.9-distutils python3-pip

# Update alternatives to use Python 3.9 as default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2
RUN update-alternatives --set python3 /usr/bin/python3.9

# Install numpy separately to avoid potential conflicts
RUN pip install numpy

# Install PyTorch
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu

# Install remaining Python dependencies
RUN pip install -r requirements.txt

EXPOSE 80

CMD ["flask", "run", "--host=0.0.0.0", "-p", "80"]
