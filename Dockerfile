# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set up the working directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy the entire project to the working directory
COPY . .

# Update and install necessary dependencies
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    software-properties-common \
    curl \
    gnupg \
    lsb-release \
    libsndfile-dev \
    openjdk-8-jdk \
    python3.10 \
    python3.10-distutils \
    python3.10-venv

# Install pip for Python 3.10
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

# Set timezone to Asia/Ho_Chi_Minh
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary Python packages
RUN pip3.10 install --upgrade pip
RUN pip3.10 install numpy<2.0.0
RUN pip3.10 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip3.10 install -r requirements.txt

# Expose port 80
EXPOSE 80

# Start the application with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:80", "app:app"]
