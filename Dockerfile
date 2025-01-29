# Use the official Ubuntu 20.04 as a base image
FROM ubuntu:20.04

# Set environment variables to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    cmake \
    build-essential \
    libopencv-dev \
    libeigen3-dev \
    libboost-all-dev \
    libsuitesparse-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the svo directory into the Docker container
COPY svo /app/svo

# Build the application
RUN mkdir -p /app/svo/build && cd /app/svo/build && \
    cmake .. && \
    make -j$(nproc)

# Set the entry point to run the application
ENTRYPOINT ["/app/svo/build/svo_application"]
