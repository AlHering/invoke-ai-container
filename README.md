## Important Notes
- this repo is a customized and decoupled version of the InvokeAI WebUI (https://github.com/invoke-ai/InvokeAI) 
- this repo is strongly linked personal infrastructure preferences and experiments
    - this especially includes the mounting, linking and model installation concept

## Used Repositories/Code
| Name         | Link     | commit |
|--------------|-----------|------------|
| InvokeAI WebUI |  https://github.com/invoke-ai/InvokeAI    |   a79d590     |

## Installation
### 1. Install Docker

```sh
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
(https://docs.docker.com/engine/install/ubuntu/)

### 2. Install the NVIDIA-Docker-Runtime
The NVIDIA-Docker-Runtime needs to be installed.
```sh
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
    && curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu20.04/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2 nvidia-container-runtime

sudo systemctl restart docker
```
(https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0))

### 3. Clone or download and unpack this repository

After cloning or downloading and unpacking, you might want to add to or adjust the code. Examples might be `invoke-ai/invokeai.yaml`, `install_webui.sh` or `install_shared_models.sh`.
The second script is later used for installing the model files which will be mounted to `/invoke-ai-container/machine_learning_models`. You can, however, ignore this file and later mount your local invoke-ai model folder and configs directly to the appropriate target folders, condigured inside the `invoke-ai/invokeai.yaml` file. Be aware that - depending on the model folder structure - the webui might prompt you to download default models, if they are not already available under their intended path.

### 4. Build a Docker image from the repository
```sh
nvidia-docker build -t invoke-ai-container:v3.1.0 <path to repo folder>
```
### 5. Start a container based off of the image
```sh
nvidia-docker run  \
    -it --net=host -p 9090:9090 --gpus all \
    --mount type=bind,source=<my local model folder>,target=/stable-diffusion-webui-container/machine_learning_models \
    --mount type=bind,source=<my local output folder>,target=/stable-diffusion-webui-container/stable_diffusion_output \
    "invoke-ai-container:v3.1.0"
```

Note, that you can also open a terminal by appending `/bin/bash` to the command above. You will get to a terminal inside the running container and execute the bash script for linking the machine learning model folders. Afterwards you can start the webui manually with `bash run_webui.sh`.

Note, that you can also directly mount your model or output folders to the target folders, that are defined inside the `invoke-ai/invokeai.yaml` file.

### 6. (Re)run the container
If you exit the container and it is stopped, you can use 
```sh
docker ps --all
```
to retrieve the name of the `invoke-ai-container:v3.1.0` container and rerun and interactively enter it with
```sh
nvidia-docker restart <container name> &&  nvidia-docker exec -it <container name> /bin/bash
```
Inside the docker container's shell, you can run the webui again by using 
```sh
bash run_webui.sh
```

