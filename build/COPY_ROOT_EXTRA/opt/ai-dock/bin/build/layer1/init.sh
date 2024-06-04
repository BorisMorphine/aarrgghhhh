#!/bin/bash
# This file will be sourced in init.sh
# Namespace functions with provisioning_

# https://raw.githubusercontent.com/ai-dock/stable-diffusion-webui/main/config/provisioning/default.sh

### Edit the following arrays to suit your workflow - values must be quoted and separated by newlines or spaces.

DISK_GB_REQUIRED=200

# Download and prepare the replacement files
git clone https://github.com/lllyasviel/stable-diffusion-webui-forge /tmp/stable-diffusion-webui-forge/
rsync -avzh /tmp/stable-diffusion-webui-forge/ /workspace/stable-diffusion-webui/

MAMBA_PACKAGES=(
    "package1"
    "package2=version"
  )
  
PIP_PACKAGES=(
    "bitsandbytes==0.41.2.post2"
  )

EXTENSIONS=(
    "https://github.com/lllyasviel/ControlNet-v1-1-nightly"
    "https://github.com/continue-revolution/sd-forge-animatediff"
    "https://github.com/deforum-art/sd-forge-deforum"
    "https://github.com/continue-revolution/sd-webui-segment-anything"
    "https://github.com/miaoshouai/miaoshouai-assistant"
    "https://github.com/hotshotco/Hotshot-XL-Automatic1111"
    "https://github.com/volotat/SD-CN-Animation"
    "https://github.com/Scholar01/sd-webui-mov2mov"
    "https://github.com/LonicaMewinsky/gif2gif.git"
    "https://github.com/wcde/sd-webui-kohya-hiresfix"
)

# Renaming Extensions
mv workspace/stable-diffusion-webui/extensions/sd-forge-deforum workspace/stable-diffusion-webui/extensions/deforum

# Renaming Extensions
mv workspace/stable-diffusion-webui/extensions/ControlNet-v1-1-nightly workspace/stable-diffusion-webui/extensions/controlnet

# Renaming Extensions
mv workspace/stable-diffusion-webui/extensions/sd-forge-animatediff workspace/stable-diffusion-webui/extensions/animatediff

CHECKPOINT_MODELS=(
    "https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
    "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
    "https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.ckpt"
    "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
    "https://huggingface.co/XpucT/Deliberate/resolve/main/Deliberate_v6-inpainting.safetensors"
    "https://huggingface.co/XpucT/Deliberate/resolve/main/Deliberate_v6.safetensors"
)

LORA_MODELS=(
    "https://civitai.com/api/download/models/445042"
    "https://civitai.com/api/download/models/114163"
    "https://civitai.com/api/download/models/161516"
    "https://civitai.com/api/download/models/296828"
    "https://civitai.com/api/download/models/16576"
    "https://civitai.com/api/download/models/7555"
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
)

CONTROLNET_MODELS=(
    "https://huggingface.co/crishhh/animatediff_controlnet/resolve/main/controlnet_checkpoint.ckpt"
    "https://huggingface.co/crishhh/animatediff_controlnet/resolve/main/motion_checkpoint_less_motion.ckpt"
    "https://huggingface.co/crishhh/animatediff_controlnet/resolve/main/motion_checkpoint_more_motion.ckpt"
)

# Navigate to SVD Folder
cd /workspace/stable-diffusion-webui/models/svd/

# Downloading img2vid-xt-1.1
wget https://civitai.com/api/download/models/329995 --content-disposition

# Downloading Img2Vid
wget https://civitai.com/api/download/models/234212 --content-disposition

# Downloading Img2Vid-xt
wget https://civitai.com/api/download/models/234202 --content-disposition

# Install Deforum
cd workspace/stable-diffusion-webui/extensions/deforum
pip install -r requirements.txt

# Navigate to animatediff folder...
cd /workspace/stable-diffusion-webui/extensions/animatediff/models

# ...and get AnDiff Motion Models
wget https://huggingface.co/guoyww/animatediff/blob/main/v3_sd15_adapter.ckpt
wget https://huggingface.co/guoyww/animatediff/blob/main/v3_sd15_mm.ckpt
wget https://huggingface.co/guoyww/animatediff/blob/main/v3_sd15_sparsectrl_scribble.ckpt

# Downloading v3_sd15_sparsectrl_rgb
wget -O v3_sd15_sparsectrl_rgb.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v3_sd15_sparsectrl_rgb.ckpt

# Downloading mm_sdxl_v10_beta
wget -O mm_sdxl_v10_beta.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v3_sd15_sparsectrl_rgb.ckpt

# Downloading mm_sd_v15_v2
wget -O mm_sd_v15_v2.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/mm_sdxl_v10_beta.ckpt

if [ ! -d "/workspace/stable-diffusion-webui/models/MotionLORA" ]; then
  mkdir -p /workspace/stable-diffusion-webui/models/MotionLORA
fi

cd /workspace/stable-diffusion-webui/models/MotionLORA

# Downloading v2_lora_ZoomIn
wget -O v2_lora_ZoomIn.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/mm_sd_v15_v2.ckpt

# Downloading v2_lora_ZoomOut
wget -O v2_lora_ZoomOut.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v2_lora_ZoomIn.ckpt

# Downloading v2_lora_PanLeft
wget -O v2_lora_PanLeft.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v2_lora_PanLeft.ckpt

# Downloading v2_lora_PanRight
wget -O v2_lora_PanRight.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v2_lora_PanRight.ckpt

# Downloading v2_lora_TiltUp
wget -O v2_lora_TiltUp.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v2_lora_TiltUp.ckpt

# Downloading v2_lora_TiltDown
wget -O v2_lora_TiltDown.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v2_lora_TiltDown.ckpt

# Downloading v2_lora_RollingClockwise
wget -O v2_lora_RollingClockwise.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v2_lora_RollingClockwise.ckpt

# Downloading v2_lora_RollingAntiClockwise
wget -O v2_lora_RollingAntiClockwise.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v2_lora_RollingAntiClockwise.ckpt

# Navigate to embeddings Folder
cd /workspace/stable-diffusion-webui/embeddings

# Get Embeddings
wget https://civitai.com/api/download/models/399643 
wget https://civitai.com/api/download/models/396717
wget https://civitai.com/api/download/models/82745
wget https://civitai.com/api/download/models/42247
wget https://civitai.com/api/download/models/36426
wget https://civitai.com/api/download/models/539032
wget https://civitai.com/api/download/models/5382
wget https://civitai.com/api/download/models/20387
wget https://civitai.com/api/download/models/5637 
wget https://civitai.com/api/download/models/9208
wget https://civitai.com/api/download/models/98441
wget https://civitai.com/api/download/models/57451
wget https://civitai.com/api/download/models/125849

apt install nano -y
nano /workspace/stable-diffusion-webui/ui-config.json

"txt2img/Width/maximum": 8192,
"txt2img/Height/maximum": 8192,

cd /stable-diffusion-webui/models/Stable-diffusion/SDXL
wget https://huggingface.co/hotshotco/SDXL-512/blob/main/hsxl_base_1.0.f16.safetensors

cd /stable-diffusion-webui/extensions/Hotshot-XL-Automatic1111/model
wget https://huggingface.co/hotshotco/Hotshot-XL/resolve/main/hsxl_temporal_layers.f16.safetensors

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    source /opt/ai-dock/etc/environment.sh
    DISK_GB_AVAILABLE=$(($(df --output=avail -m "${WORKSPACE}" | tail -n1) / 1000))
    DISK_GB_USED=$(($(df --output=used -m "${WORKSPACE}" | tail -n1) / 1000))
    DISK_GB_ALLOCATED=$(($DISK_GB_AVAILABLE + $DISK_GB_USED))
    provisioning_print_header
    provisioning_get_mamba_packages
    provisioning_get_pip_packages
    provisioning_get_extensions
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/ckpt" \
        "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/lora" \
        "${LORA_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/vae" \
        "${VAE_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/storage/stable_diffusion/models/esrgan" \
        "${ESRGAN_MODELS[@]}"
     
    PLATFORM_FLAGS=""
    if [[ $XPU_TARGET = "CPU" ]]; then
        PLATFORM_FLAGS="--use-cpu all --skip-torch-cuda-test --no-half"
    fi
    PROVISIONING_FLAGS="--skip-python-version-check --no-download-sd-model --do-not-download-clip --port 17860 --exit"
    FLAGS_COMBINED="${PLATFORM_FLAGS} $(cat /etc/a1111_webui_flags.conf) ${PROVISIONING_FLAGS}"
    
    # Start and exit because webui will probably require a restart
    cd /opt/stable-diffusion-webui && \
    micromamba run -n webui -e LD_PRELOAD=libtcmalloc.so python launch.py \
        ${FLAGS_COMBINED}
    provisioning_print_end
}

function provisioning_get_mamba_packages() {
    if [[ -n $MAMBA_PACKAGES ]]; then
        $MAMBA_INSTALL -n webui ${MAMBA_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
        micromamba run -n webui $PIP_INSTALL ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_extensions() {
    for repo in "${EXTENSIONS[@]}"; do
        dir="${repo##*/}"
        path="/opt/stable-diffusion-webui/extensions/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} == "true" ]]; then
                printf "Updating extension: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                    micromamba -n webui run ${PIP_INSTALL} -r "$requirements"
                fi
            fi
        else
            printf "Downloading extension: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                micromamba -n webui run ${PIP_INSTALL} -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_models() {
    if [[ -z $2 ]]; then return 1; fi
    dir="$1"
    mkdir -p "$dir"
    shift
    if [[ $DISK_GB_ALLOCATED -ge $DISK_GB_REQUIRED ]]; then
        arr=("$@")
    else
        printf "WARNING: Low disk space allocation - Only the first model will be downloaded!\n"
        arr=("$1")
    fi
    
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
    if [[ $DISK_GB_ALLOCATED -lt $DISK_GB_REQUIRED ]]; then
        printf "WARNING: Your allocated disk size (%sGB) is below the recommended %sGB - Some models will not be downloaded\n" "$DISK_GB_ALLOCATED" "$DISK_GB_REQUIRED"
    fi
}

function provisioning_print_end() {
    printf "\nProvisioning complete:  Web UI will start now\n\n"
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
}

provisioning_start
