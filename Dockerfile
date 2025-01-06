FROM nvcr.io/nvidia/pytorch:24.10-py3

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3.10-venv && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip install -U pip ninja
# Create and use virtual environment
RUN which nvcc && nvcc --version
RUN MAX_JOBS=4 TORCH_CUDA_ARCH_LIST="9.0" pip install -v -U git+https://github.com/Dao-AILab/flash-attention.git

RUN MAX_JOBS=4 pip install deepspeed

RUN BUILD_VERSION=0.0.28.post2 MAX_JOBS=4 TORCH_CUDA_ARCH_LIST="9.0" pip install -v -U git+https://github.com/facebookresearch/xformers.git@2bcbc55#egg=xformers@v0.0.28.post2

RUN git clone https://github.com/triton-lang/triton.git /triton && cd /triton && pip install -e python

RUN git clone -b 0.45.0  https://github.com/TimDettmers/bitsandbytes.git && cd bitsandbytes && pip install -r requirements-dev.txt && cmake -DCOMPUTE_BACKEND=cuda -DCMAKE_SYSTEM_PROCESSOR=arm64 -S . && make && pip install .

RUN MAX_JOBS=4 TORCH_CUDA_ARCH_LIST="9.0" pip install -v -U git+https://github.com/pytorch/ao.git@v0.5.0

RUN pip3 install --no-build-isolation  axolotl