#!/bin/bash
# This file will be sourced in init.sh
# Namespace functions with provisioning_

# https://raw.githubusercontent.com/ai-dock/stable-diffusion-webui/main/config/provisioning/default.sh

### Edit the following arrays to suit your workflow - values must be quoted and separated by newlines or spaces.

DISK_GB_REQUIRED=30

MAMBA_PACKAGES=(
    #"package1"
    #"package2=version"
)
  
PIP_PACKAGES=(
    "bitsandbytes==0.41.2.post2"
)

EXTENSIONS=(
    "https://github.com/lllyasviel/ControlNet-v1-1-nightly.git"
    "https://github.com/s9roll7/ebsynth_utility.git"
    "https://github.com/DavG25/sd-webui-mov2mov"
    "https://github.com/Scholar01/sd-webui-bg-mask.git"
    "https://github.com/feffy380/sd-webui-token-downsampling.git"
    "https://github.com/light-and-ray/sd-webui-replacer.git"
    "https://github.com/volotat/SD-CN-Animation.git"
    "https://github.com/Mikubill/sd-webui-controlnet"
    "https://github.com/d8ahazard/sd_dreambooth_extension"
    "https://github.com/deforum-art/sd-webui-deforum"
    "https://github.com/adieyal/sd-dynamic-prompts"
    "https://github.com/ototadana/sd-face-editor"
    "https://github.com/AlUlkesh/stable-diffusion-webui-images-browser"
    "https://github.com/hako-mikan/sd-webui-regional-prompter"
    "https://github.com/Coyote-A/ultimate-upscale-for-automatic1111"
    "https://github.com/fkunn1326/openpose-editor"
    "https://github.com/Gourieff/sd-webui-reactor"
)

CHECKPOINT_MODELS=(
    "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
    "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
    "https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
)

LORA_MODELS=(
    "https://civitai.com/api/download/models/16576"
    "https://civitai.com/api/download/models/309330"
    "https://civitai.com/api/download/models/145277?"
    "https://civitai.com/api/download/models/127015"
)

VAE_MODELS=(
    "https://huggingface.co/stabilityai/sd-vae-ft-ema-original/resolve/main/vae-ft-ema-560000-ema-pruned.safetensors"
    "https://huggingface.co/stabilityai/sd-vae-ft-mse-original/resolve/main/vae-ft-mse-840000-ema-pruned.safetensors"
    "https://huggingface.co/stabilityai/sdxl-vae/resolve/main/sdxl_vae.safetensors"
)

ESRGAN_MODELS=(
    "https://huggingface.co/ai-forever/Real-ESRGAN/resolve/main/RealESRGAN_x4.pth"
    "https://huggingface.co/FacehugmanIII/4x_foolhardy_Remacri/resolve/main/4x_foolhardy_Remacri.pth"
    "https://huggingface.co/Akumetsu971/SD_Anime_Futuristic_Armor/resolve/main/4x_NMKD-Siax_200k.pth"
    "https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x-UltraSharp.pth"
    "https://objectstorage.us-phoenix-1.oraclecloud.com/n/ax6ygfvpvzka/b/open-modeldb-files/o/16x-ESRGAN.pth"
    "https://drive.usercontent.google.com/download?id=1JRwXYeuMBIsyeNfsTfeSs7gsHqCZD7x"
    "https://github.com/Phhofm/models/blob/main/4xLSDIRplus/4xLSDIRplus.pth"
    "https://github.com/cszn/KAIR/releases/download/v1.0/BSRGAN.pth"
    "https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/KBJRBQyR"
    "https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/PIRDEYgT"
    "https://mega.nz/folder/yg0lHQoJ#sP8_BfDk2YlshFjOL9Qrtg/file/TlkHjITR"
    "https://mega.nz/folder/yg0lHQoJ#sP8_BfDk2YlshFjOL9Qrtg/file/KxkVEaAQ"
    "https://mega.nz/folder/yg0lHQoJ#sP8_BfDk2YlshFjOL9Qrtg/file/H49nEAzI"
    "https://drive.google.com/uc?export=download&confirm=1&id=1H4KQyhcknOoExjvDdsoxAgTBMO7JuJ3w"
    "https://icedrive.net/1/43GNBihZyi"
)

CONTROLNET_MODELS=(
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_canny-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_depth-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_hed-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_mlsd-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_normal-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_openpose-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_scribble-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_seg-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_canny-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_color-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_depth-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_keypose-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_openpose-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_seg-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_sketch-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_style-fp16.safetensors"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_clone_or_update_repos() {
    local webui_git="https://github.com/AUTOMATIC1111/stable-diffusion-webui"
    local forgeRepoURL="https://github.com/lllyasviel/stable-diffusion-webui-forge.git"
    
    local webui_dir="/opt/stable-diffusion-webui"
    local forgeRepoPath="/opt/stable-diffusion-webui-forge"
    
    # Clone or update stable-diffusion-webui
    if [ ! -d "$webui_dir" ]; then
        echo "Cloning stable-diffusion-webui..."
        git clone "$webui_git" "$webui_dir"
    else
        echo "Updating stable-diffusion-webui..."
        (cd "$webui_dir" && git pull)
    fi

    # Clone or update stable-diffusion-webui-forge
    if [ ! -d "$forgeRepoPath" ]; then
        echo "Cloning stable-diffusion-webui-forge..."
        git clone "$forgeRepoURL" "$forgeRepoPath"
    else
        echo "Updating stable-diffusion-webui-forge..."
        (cd "$forgeRepoPath" && git pull)
    fi
}

function provisioning_install_system_requirements() {
    echo "Installing system requirements..."
    apt-get update && apt-get install -y libgl1 libglib2.0-0
}

function provisioning_start() {
    source /opt/ai-dock/etc/environment.sh
    DISK_GB_AVAILABLE=$(($(df --output=avail -m "${WORKSPACE}" | tail -n1) / 1000))
    DISK_GB_USED=$(($(df --output=used -m "${WORKSPACE}" | tail -n1) / 1000))
    DISK_GB_ALLOCATED=$(($DISK_GB_AVAILABLE + $DISK_GB_USED))
    
    provisioning_print_header
    
    # Install system requirements
    provisioning_install_system_requirements
    
    # Clone or update repositories
    provisioning_clone_or_update_repos
    
    # Other provisioning steps (omitted for brevity)...
    
    provisioning_print_end
}

function provisioning_print_header() {
    echo -e "\n##############################################"
    echo "#                                            #"
    echo "#          Provisioning container            #"
    echo "#                                            #"
    echo "#         This will take some time           #"
    echo "#                                            #"
    echo "# Your container will be ready on completion #"
    echo "#                                            #"
    echo "##############################################\n"
    if [[ $DISK_GB_ALLOCATED -lt $DISK_GB_REQUIRED ]]; then
        echo "WARNING: Your allocated disk size ($DISK_GB_ALLOCATED GB) is below the recommended $DISK_GB_REQUIRED GB - Some models will not be downloaded."
    fi
}

function provisioning_print_end() {
    echo -e "\nProvisioning complete: Web UI will start now\n"
}

# Start the provisioning process
provisioning_start
