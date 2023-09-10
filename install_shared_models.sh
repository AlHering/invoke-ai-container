#!/bin/bash
#################################################
# Access point for linking model. Note that the
# folder and model structure follows own preferences.
#################################################

# invoke-ai model linker v0.1

if [ -z $1 ]
then 
    central_sd_model_dir="/invoke-ai-container/machine_learning_models"
else 
    central_sd_model_dir=$1
fi


# create folders
source /invoke-ai-container/venv/bin/activate
cd /invoke-ai-container/invoke-ai
MODEL_FOLDERS=("STABLE_DIFFUSION" "CHECKPOINTS" "VAE" "LORA" "GFPGAN" "ESRGAN" "BLIP" "DEEPBOORU" "TORCH_DEEPDANBOORU" "CODEFORMER" "REAL_ESRGAN" "CONTROL_NET" "KARLO" "HYPERNETWORKS" "LDSR" "SWINIR" "POSES" "EMBEDDINGS" "TEXTUAL_INVERSION" "LYCORIS" "WILDCARDS" "BSRGAN")
EXTENSIONS=("safetensors" "ckpt" "bin" "pt" "pth")
for FOLDER in "${MODEL_FOLDERS[@]}"
do  
    for extension in "${EXTENSIONS[@]}"
    do
        for file in $(find "${central_sd_model_dir}/${FOLDER}/" -name "**.${extension}")
        do 
            if [ -f "${file}" ]
            then
                invokeai-model-install --add $file
            fi
        done
    done
done 

