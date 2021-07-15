FROM ucsdets/datahub-base-notebook:2021.2.2

USER root

# tensorflow, pytorch stable versions
# https://pytorch.org/get-started/previous-versions/
# https://www.tensorflow.org/install/source#linux

RUN apt-get update && \
	apt-get install -y \
			libtinfo5 
#			nvidia-cuda-toolkit

#RUN conda install cudatoolkit=10.2 \
RUN conda update -n base conda
RUN conda install cudatoolkit=11.2 \
				  cudatoolkit-dev=11.2\
				  cudnn \
				  nccl \
				  -y

# Install pillow<7 due to dependency issue https://github.com/pytorch/vision/issues/1712
RUN pip install --no-cache-dir  datascience \
								PyQt5 \
								scapy \
								nltk \
								jupyter-tensorboard \
								pycocotools \
								"pillow<7" \
								tensorflow-gpu>=2.5

# torch must be installed separately since it requires a non-pypi repo. See stable version above
#RUN pip install torch==1.5.0+cu101 torchvision==0.6.0+cu101 pytorch-ignite -f https://download.pytorch.org/whl/torch_stable.html;
#RUN conda install pytorch torchvision torchaudio cudatoolkit=10.2 -c pytorch

RUN ln -s /usr/local/nvidia/bin/nvidia-smi /opt/conda/bin/nvidia-smi

USER $NB_UID:$NB_GID
ENV PATH=${PATH}:/usr/local/nvidia/bin
