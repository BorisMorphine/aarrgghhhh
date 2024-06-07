#!/bin/bash
# This file will be sourced in init.sh
# Namespace functions with provisioning_

# https://raw.githubusercontent.com/ai-dock/stable-diffusion-webui/main/config/provisioning/default.sh

### Edit the following arrays to suit your workflow - values must be quoted and separated by newlines or spaces.

# Download and prepare the replacement files from the main branch
git clone -b main https://github.com/lllyasviel/stable-diffusion-webui-forge /workspace/stable-diffusion-webui-forge/
rsync -avzh /workspace/stable-diffusion-webui-forge/ /workspace/stable-diffusion-webui/

DISK_GB_REQUIRED=200

MAMBA_PACKAGES=(
    "package1"
    "package2=version"
)
  
PIP_PACKAGES=(
    "bitsandbytes==0.41.2.post2"
)

EXTENSIONS=(
    "https://github.com/lllyasviel/ControlNet-v1-1-nightly"
    "https://github.com/deforum-art/sd-forge-deforum"
    "https://github.com/VBVerduijn/sd-webui-mov2mov"
)

CHECKPOINT_MODELS=(
    "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
    #"https://huggingface.co/stabilityai/stable-diffusion-2-1/resolve/main/v2-1_768-ema-pruned.ckpt"
    #"https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0.safetensors"
    #"https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0.safetensors"
)

LORA_MODELS=(
    #"https://civitai.com/api/download/models/16576"
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
    "https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1e_sd15_tile.pth"
    "https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11f1e_sd15_tile.yaml"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    source /opt/ai-dock/etc/environment.sh
    DISK_GB_AVAILABLE=$(( $(df --output=avail -m "${WORKSPACE}" | tail -n1) / 1000 ))
    DISK_GB_USED=$(( $(df --output=used -m "${WORKSPACE}" | tail -n1) / 1000 ))
    DISK_GB_ALLOCATED=$(( DISK_GB_AVAILABLE + DISK_GB_USED ))
    provisioning_print_header
    provisioning_get_mamba_packages
    provisioning_get_pip_packages
    provisioning_get_extensions
    provisioning_get_models "${WORKSPACE}/stable_diffusion/models/Stable-diffusion" "${CHECKPOINT_MODELS[@]}"
    provisioning_get_models "${WORKSPACE}/stable_diffusion/models/lora" "${LORA_MODELS[@]}"
    provisioning_get_models "${WORKSPACE}/stable_diffusion/models/controlnet" "${CONTROLNET_MODELS[@]}"
    provisioning_get_models "${WORKSPACE}/stable_diffusion/models/vae" "${VAE_MODELS[@]}"
    provisioning_get_models "${WORKSPACE}/stable_diffusion/models/ESRGAN" "${ESRGAN_MODELS[@]}"
     
    PLATFORM_FLAGS=""
    if [[ "${XPU_TARGET}" = "CPU" ]]; then
        PLATFORM_FLAGS="--use-cpu all --skip-torch-cuda-test --no-half"
    fi
    PROVISIONING_FLAGS="--skip-python-version-check --xformers --cuda-malloc --no-half --no-half-vae --autolaunch"
    FLAGS_COMBINED="${PLATFORM_FLAGS} $(cat /etc/a1111_webui_flags.conf) ${PROVISIONING_FLAGS}"
    
    # Start and exit because webui will probably require a restart
    cd /opt/stable-diffusion-webui && \
    micromamba run -n webui -e LD_PRELOAD=libtcmalloc.so python launch.py ${FLAGS_COMBINED}
    provisioning_print_end
}

function provisioning_get_mamba_packages() {
    if [[ -n "${MAMBA_PACKAGES}" ]]; then
        micromamba install -n webui "${MAMBA_PACKAGES[@]}"
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n "${PIP_PACKAGES}" ]]; then
        micromamba run -n webui pip install "${PIP_PACKAGES[@]}"
    fi
}

function provisioning_get_extensions() {
    for repo in "${EXTENSIONS[@]}"; do
        dir="${repo##*/}"
        path="/opt/stable-diffusion-webui/extensions/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d "${path}" ]]; then
            if [[ "${AUTO_UPDATE,,}" != "false" ]]; then
                printf "Updating extension: %s...\n" "${repo}"
                (cd "${path}" && git pull)
                if [[ -e "${requirements}" ]]; then
                    micromamba run -n webui pip install -r "${requirements}"
                fi
            fi
        else
            printf "Downloading extension: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e "${requirements}" ]]; then
                micromamba run -n webui pip install -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_models() {
    if [[ -z "$2" ]]; then return 1; fi
    dir="$1"
    mkdir -p "${dir}"
    shift
    if [[ "${DISK_GB_ALLOCATED}" -ge "${DISK_GB_REQUIRED}" ]]; then
        arr=("$@")
    else
        printf "WARNING: Low disk space allocation - Only the first model will be downloaded!\n"
        arr=("$1")
    fi
    
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "${dir}"
    for url in "${arr[@]}"; do
        printf "
