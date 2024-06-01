#!/bin/bash
# This file will be sourced in init.sh
# Namespace functions with provisioning_

# https://raw.githubusercontent.com/ai-dock/stable-diffusion-webui/main/config/provisioning/default.sh

### Edit the following arrays to suit your workflow - values must be quoted and separated by newlines or spaces.

DISK_GB_REQUIRED=60

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
)

CHECKPOINT_MODELS=(
    "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
    "https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.ckpt"
    "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
    "https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
    "https://civitai.com/api/download/models/396524?type=Model&format=SafeTensor&size=pruned&fp=fp16"
    "https://civitai.com/api/download/models/537505?type=Model&format=SafeTensor&size=pruned&fp=fp32"
    "https://civitai.com/api/download/models/495292?type=Model&format=SafeTensor&size=full&fp=fp32"
    "https://civitai.com/api/download/models/501240?type=Model&format=SafeTensor&size=full&fp=fp16"
    "https://civitai.com/api/download/models/245598?type=Model&format=SafeTensor&size=full&fp=fp16"
    "https://civitai.com/api/download/models/245627?type=Model&format=SafeTensor&size=full&fp=fp16"
    "https://huggingface.co/XpucT/Deliberate/resolve/main/Deliberate_v6.safetensors"
    "https://huggingface.co/XpucT/Deliberate/resolve/main/Deliberate_v6-inpainting.safetensors"
)

LORA_MODELS=(
    "https://civitai.com/api/download/models/16576"
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
)

CONTROLNET_MODELS=(
    "https://huggingface.co/crishhh/animatediff_controlnet/resolve/main/controlnet_checkpoint.ckpt"
    "https://huggingface.co/crishhh/animatediff_controlnet/resolve/main/motion_checkpoint_less_motion.ckpt"
    "https://huggingface.co/crishhh/animatediff_controlnet/resolve/main/motion_checkpoint_more_motion.ckpt"
)

# Navigate to SVD Folder
cd /workspace/stable-diffusion-webui/models/svd/

# Downloading img2vid-xt-1.1
wget -O img2vid-xt-1.1.safetensors -q https://civitai.com/api/download/models/329995?type=Model&format=SafeTensor&size=pruned&fp=fp16

# Downloading Img2Vid
wget -O Img2Vid.safetensors -q https://civitai.com/api/download/models/234212?type=Model&format=SafeTensor&size=full&fp=fp32

# Downloading Img2Vid-xt
wget -O Img2Vid-xt.safetensors -q https://civitai.com/api/download/models/234202?type=Model&format=SafeTensor&size=full&fp=fp32

###

# Navigate to embeddings Folder
cd /workspace/stable-diffusion-webui/embeddings

# Downloading SoftRealistic Positive
wget -O soft--good.pt -q https://civitai.com/api/download/models/399643?type=Model&format=PickleTensor

# Downloading SoftRealistic Negative
wget -O soft--neg.pt -q https://civitai.com/api/download/models/396717?type=Model&format=PickleTensor

# Downloading CyberRealistic Negative
wget -O cyber--neg.pt -q https://civitai.com/api/download/models/82745?type=Negative&format=Other

#Downloading RealisticVision Negative
wget -O realistic--neg.pt -q https://civitai.com/api/download/models/42247?type=Model&format=Other

# Download Deliberate Negative
wget -O deliberate--neg.pt -q https://civitai.com/api/download/models/36426?type=Negative&format=Other

# Renaming Extensions
mv workspace/stable-diffusion-webui/extensions/sd-forge-deforum workspace/stable-diffusion-webui/extensions/deforum
mv workspace/stable-diffusion-webui/extensions/ControlNet-v1-1-nightly workspace/stable-diffusion-webui/extensions/controlnet
mv workspace/stable-diffusion-webui/extensions/sd-forge-animatediff workspace/stable-diffusion-webui/extensions/animatediff

# Install Deforum
cd workspace/stable-diffusion-webui/extensions/deforum
pip install -r requirements.txt

# Navigate to animatediff folder and add models
cd /workspace/stable-diffusion-webui/extensions/animatediff/models

# Downloading v3_adapter_sd_v15
wget -O v3_adapter_sd_v15.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v3_sd15_adapter.ckpt

# Downloading v3_sd15_mm
wget -O v3_sd15_mm.ckpt.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v3_sd15_mm.ckpt.ckpt-,Link,-Motion%20Module

# Downloading v3_sd15_sparsectrl_scribble
wget -O v3_sd15_sparsectrl_scribble.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v3_sd15_mm.ckpt.ckpt-,Link,-Motion%20Module

# Downloading v3_sd15_sparsectrl_rgb
wget -O v3_sd15_sparsectrl_rgb.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v3_sd15_sparsectrl_scribble.ckpt

# Downloading mm_sdxl_v10_beta
wget -O mm_sdxl_v10_beta.ckpt -q https://huggingface.co/guoyww/animatediff/blob/main/v3_sd15_sparsectrl_rgb.ckpt

# Downloading mm_sd_v15_v2
wget -O mm_sd_v15_v2.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=mm_sd_v15_v2.ckpt-,Link,-Motion%20Module

# Downloading v2_lora_ZoomIn
wget -O v2_lora_ZoomIn.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v2_lora_ZoomIn.ckpt-,Link,-MotionLoRA

# Downloading v2_lora_ZoomOut
wget -O v2_lora_ZoomOut.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v2_lora_ZoomOut.ckpt-,Link,-MotionLoRA

# Downloading v2_lora_PanLeft
wget -O v2_lora_PanLeft.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v2_lora_PanLeft.ckpt-,Link,-MotionLoRA

# Downloading v2_lora_PanRight
wget -O v2_lora_PanRight.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v2_lora_PanRight.ckpt-,Link,-MotionLoRA

# Downloading v2_lora_TiltUp
wget -O v2_lora_TiltUp.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v2_lora_TiltUp.ckpt-,Link,-MotionLoRA

# Downloading v2_lora_TiltDown
wget -O v2_lora_TiltDown.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v2_lora_TiltDown.ckpt-,Link,-MotionLoRA

# Downloading v2_lora_RollingClockwise
wget -O v2_lora_RollingClockwise.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v2_lora_RollingClockwise.ckpt-,Link,-MotionLoRA

# Downloading v2_lora_RollingAntiClockwise
wget -O v2_lora_RollingAntiClockwise.ckpt -q https://github.com/guoyww/AnimateDiff?tab=readme-ov-file#setup-for-inference:~:text=v2_lora_RollingAnticlockwise.ckpt-,Link,-MotionLoRA

# Downloading AnimateDiff-LCM Motion Model
wget -O AnimateDiff-LCM_Motion_Model.pt -q https://civitai.com/api/download/models/366178?type=Model&format=PickleTensor&size=full&fp=fp32

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
    PROVISIONING_FLAGS="--skip-python-version-check --no-download-sd-model --do-not-download-clip --port 11404 --exit"
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
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
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
