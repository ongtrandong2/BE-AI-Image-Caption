# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Update package lists and install necessary packages
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    libsndfile-dev \
    openjdk-8-jdk \
    git \
    tzdata \
    wget \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    curl \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python 3.10.0 from source
RUN wget https://www.python.org/ftp/python/3.10.0/Python-3.10.0.tgz && \
    tar xzf Python-3.10.0.tgz && \
    cd Python-3.10.0 && \
    ./configure --enable-optimizations && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.10.0 Python-3.10.0.tgz

# Set up the working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy the entire project to the working directory
COPY . .

# Set timezone to Asia/Ho_Chi_Minh
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python dependencies
RUN python3.10 -m venv /usr/src/app/venv
RUN /usr/src/app/venv/bin/pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN /usr/src/app/venv/bin/pip install -r requirements.txt

# Ensure the virtual environment is used
ENV PATH="/usr/src/app/venv/bin:$PATH"

# Expose port 80 for the Flask application
EXPOSE 80

CMD flask run --host 0.0.0.0 -p 80
