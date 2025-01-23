# Axolotl Dockerfile

This repository contains a Dockerfile for [Axolotl](https://github.com/axolotl-ai-cloud/axolotl.git), specifically tailored for the Grace Hopper (GH200) superchip. The pre-built Docker image is available [here](https://hub.docker.com/repository/docker/tommasobendinelli/axolotl_arm64/general).

## Building the Docker Image

To build the Docker image from scratch, run the following command:

```bash
sudo docker build -t image_name:latest .
```

## Running the Docker Image

To run the Docker image after the building process, run the following command:

```bash
sudo docker run -it --rm --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 my_image:latest
```
