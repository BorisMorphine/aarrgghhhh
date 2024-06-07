#!/bin/bash
# This file will be sourced in init.sh
# Namespace functions with provisioning_

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root or with sudo. Re-running with sudo..."
   sudo bash "$0" "$@"
   exit $?
fi

# Clone and synchronize the Forge repository with the stable-diffusion-webui directory
git clone -b main https://github.com/lllyasviel/stable-diffusion-webui-forge /workspace/stable-diffusion-webui-forge/ || {
    echo "Failed to clone the repository."
    exit 1
}
rsync -avzh /workspace/stable-diffusion-webui-forge/ /workspace/stable-diffusion-webui/ || {
    echo "Failed to synchronize the repository."
    exit 1
}

### Edit the following arrays to suit your workflow - values must be quoted and separated by newlines or spaces.

DISK_GB_REQUIRED=100

MAMBA_PACKAGES=(
    "package1"
    "package2=version"
)

PIP_PACKAGES=(
    "bitsandbytes==0.41.2.post2"
    "ezsynth"
    "numexpr"
    "matplotlib"
    "pandas"
    "av"
    "pims"
    "imageio_ffmpeg"
    "rich"
    "gdown"
    "insightface"
)

EXTENSIONS=(
    "https://github.com/lllyasviel/ControlNet-v1-1-nightly"
    "https://github.com/deforum-art/sd-forge-deforum.git"
    "https://github.com/VBVerduijn/sd-webui-mov2mov"
    "https://github.com/foglerek/SD-CN-Animation"
)

CHECKPOINT_MODELS=(
    "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt"
    "https://huggingface.co/lllyasviel/fav_models/resolve/main/fav/juggernautXL_v8Rundiffusion.safetensors"
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
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_canny-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_depth-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_scribble-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_depth-fp16.safetensors"
    "https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_sketch-fp16.safetensors"
)

function build_extra_start() {
    source /opt/ai-dock/etc/environment.sh
    build_extra_get_mamba_packages
    build_extra_get_pip_packages
    build_extra_get_extensions
    build_extra_get_models \
        "/opt/storage/stable_diffusion/models/ckpt" \
        "${CHECKPOINT_MODELS[@]}"
    build_extra_get_models \
        "/opt/storage/stable_diffusion/models/lora" \
        "${LORA_MODELS[@]}"
    build_extra_get_models \
        "/opt/storage/stable_diffusion/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    build_extra_get_models \
        "/opt/storage/stable_diffusion/models/vae" \
        "${VAE_MODELS[@]}"
    build_extra_get_models \
        "/opt/storage/stable_diffusion/models/esrgan" \
        "${ESRGAN_MODELS[@]}"
   
    cd /opt/stable-diffusion-webui && \
        micromamba run -n webui -e LD_PRELOAD=libtcmalloc.so python launch.py \
        --use-cpu all \
        --skip-torch-cuda-test \
        --skip-python-version-check \
        --no-download-sd-model \
        --do-not-download-clip \
        --no-half \
        --port 11404 \
        --exit
    
    # Ensure pytorch hasn't been clobbered
    micromamba run -n webui python /opt/ai-dock/tests/assert-torch-version.py
}

function build_extra_get_mamba_packages() {
    if [[ -n $MAMBA_PACKAGES ]]; then
        micromamba install -n webui ${MAMBA_PACKAGES[@]}
    fi
}

function build_extra_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
        micromamba run -n webui pip install ${PIP_PACKAGES[@]}
    fi
}

function build_extra_get_extensions() {
    for repo in "${EXTENSIONS[@]}"; do
        dir="${repo##*/}"
        path="/opt/stable-diffusion-webui/extensions/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating extension: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                    micromamba run -n webui pip install -r "$requirements"
                fi
            fi
        else
            printf "Downloading extension: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                micromamba run -n webui pip install -r "${requirements}"
            fi
        fi
    done
}

function build_extra_get_models() {
    if [[ -n $2 ]]; then
        dir="$1"
        mkdir -p "$dir"
        shift
        arr=("$@")
        
        printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
        for url in "${arr[@]}"; do
            printf "Downloading: %s\n" "${url}"
            build_extra_download "${url}" "${dir}"
            printf "\n"
        done
    fi
}

# Download from $1 URL to $2 file path
function build_extra_download() {
    wget -qnc --content-disposition --show-progress -e dotbytes="${3:-4M}" -P "$2" "$1"
}

umask 002
build_extra_start
fix-permissions.sh -o container
rm /etc/ld.so.cache
ldconfig
cd /workspace/stable-diffusion-webui
micromamba run -n webui python3 launch.py
