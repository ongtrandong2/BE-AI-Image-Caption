FROM ubuntu:20.04

# Set timezone
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install necessary packages and tools
RUN apt update && apt install -y \
    libsndfile-dev \
    openjdk-8-jdk \
    git \
    software-properties-common \
    build-essential \
    wget \
    curl \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    python3.9 \
    python3.9-dev \
    python3.9-distutils \
    python3-pip

# Update alternatives to use Python 3.9
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 2 && \
    update-alternatives --set python3 /usr/bin/python3.9

# Ensure pip is up-to-date
RUN python3.9 -m pip install --upgrade pip

# Copy project files
WORKDIR /usr/src/app
COPY . .

# Install Python packages
RUN pip install numpy
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install -r requirements.txt

# Expose port 80
EXPOSE 80

# Start the Flask application
CMD ["flask", "run", "--host=0.0.0.0", "--port=80"]
