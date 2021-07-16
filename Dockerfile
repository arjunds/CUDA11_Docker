FROM ucsdets/datahub-base-notebook:2021.2.2

USER root

# tensorflow, pytorch stable versions
# https://pytorch.org/get-started/previous-versions/
# https://www.tensorflow.org/install/source#linux

RUN apt-get update && \
	apt-get install -y \
			libtinfo5 
#			nvidia-cuda-toolkit

RUN conda update -n base conda
RUN conda install -c anaconda cudatoolkit \
				  cudatoolkit-dev\
				  cudnn \
				  nccl \
				  -y

# Install pillow<7 due to dependency issue https://github.com/pytorch/vision/issues/1712
RUN pip install --no-cache-dir  datascience \
								PyQt5 \
								scapy \
								jupyter-tensorboard \
								pycocotools \
								"pillow<7" \
								tensorflow-gpu>=2.5


RUN ln -s /usr/local/nvidia/bin/nvidia-smi /opt/conda/bin/nvidia-smi

USER $NB_UID:$NB_GID
ENV PATH=${PATH}:/usr/local/nvidia/bin

CMD ["/bin/bash"]
