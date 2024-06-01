#!/bin/bash

micromamba deactivate activate base
sudo micromamba run -n webui git clone https://github.com/lllyasviel/stable-diffusion-webui-forge.git

git branch -u forge/main
git pull 
git config pull.rebase false
/opt/stable-diffusion-forge-webui/ /opt/stable-diffusion-webui/
cd /opt/stable-diffusion-webui/
./webui.sh | bash sudo

mv /opt/stable-diffusion-webui /opt/stable-diffusion-forge-webui/extensions/A1111
rsync -av “/opt/stable-diffusion-webui” “/opt/stable-diffusion-webui/extensions/A1111“
echo "Synced “/opt/stable-diffusion-webui to /opt/stable-diffusion-webui/extensions/A1111”

micromamba deactivate activate base
micromamba run -n python_310 
venv_dir=“opt/micromamba/envs/webui”
export COMMANDLINE_ARGS="--port 7860 --listen --api --xformers --autolaunch”
export GIT="git"
export LAUNCH_SCRIPT="launch.py"
export TORCH_COMMAND="pip install torch==1.12.1+cu113 --extra-index-url https://download.pytorch.org/whl/cu113"
export REQS_FILE="requirements.txt"
set SDFORGE=“opt/stable-diffusion-webui/”
set models_dir=“{$SDFORGE}/models”
set forge_models=“{$SDFORGE}/models_forge”
set extensions_dir=“{$SDFORGE/extensions”
set Embeddings_dir=“{$SDFORGE/embeddings”
set Safetensors_dir=“${MODELS_DIR}/Stable-Diffusion}
set Lora_dir=“${MODELS_DIR}/Lora”
set ESRGAN_dir=“${MODELS_DIR}/ESRGAN”

cd ${Safetensors_dir}
install git lfs
wget https://huggingface.co/stabilityai/sdxl-turbo/blob/main/sd_xl_turbo_1.0.safetensors
git clone Deliberate_v.5.safetensors https://huggingface.co/XpucT/Deliberate/blob/main/Deliberate_v5.safetensors

cd ${ESRGAN_dir}
curl -O 4xUltraSharp.pth https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x-UltraSharp.pth
curl -O 4xUltraMix_Balanced.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/KBJRBQyR
curl -O 4xUltraMix_Restore.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/KBJRBQyR
curl -O 4xUltraMix_Smooth.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/PIRDEYgT
curl -O 4x-FSDedither.pth https://drive.google.com/uc?export=download&confirm=1&id=1H4KQyhcknOoExjvDdsoxAgTBMO7JuJ3w
curl -O 8xESRGAN.pth https://icedrive.net/1/43GNBihZyi
curl -O 16xESRGAN.pth https://objectstorage.us-phoenix-1.oraclecloud.com/n/ax6ygfvpvzka/b/open-modeldb-files/o/16x-ESRGAN.pth
curl -O 1x_GainRESV3_Aggro.pth https://mega.nz/folder/yg0lHQoJ#sP8_BfDk2YlshFjOL9Qrtg/file/TlkHjITR
curl -O 1x_GainRESV3_Nautral.pth https://mega.nz/folder/yg0lHQoJ#sP8_BfDk2YlshFjOL9Qrtg/file/KxkVEaAQ
curl -O 1x_GainRESV3_Passive.pth https://mega.nz/folder/yg0lHQoJ#sP8_BfDk2YlshFjOL9Qrtg/file/H49nEAzI
curl -O 4xNomos8kDAT.pth https://drive.usercontent.google.com/download?id=1JRwXYeuMBIsyeNfsTfeSs7gsHqCZD7x
curl -O 4xLSDIRplus.pth https://github.com/Phhofm/models/blob/main/4xLSDIRplus/4xLSDIRplus.pth
curl -0 BSRGAN https://github.com/cszn/KAIR/releases/download/v1.0/BSRGAN.pth

cd ${Lora_dir}
curl -O weird_lanscape.safetensors https://civitai.com/api/download/models/309330?type=Model&format=SafeTensor
curl -O sheet_of_acid.safetensors https://civitai.com/api/download/models/145277?type=Model&format=SafeTensor
curl -O gonzo.safetensors https://civitai.com/api/download/models/127015?type=Model&format=SafeTensor

# Build StableSR
cd ${EXTENSIONS_DIR}
git clone https://github.com/pkuliyi2015/sd-webui-stablesr.git StableSR

# cd into new directory and download models
cd StableSR/scripts 
git lfs clone https://huggingface.co/Iceclear/StableSR -force scripts

# Build DeOldify
cd ${EXTENSIONS_DIR}
git clone https://github.com/SpenserCai/sd-webui-deoldify.git DeOldify

# cd into new directory download models
cd DeOldify/models/deoldify
curl -O ColorizeArtistic_gen.pth https://data.deepai.org/deoldify/ColorizeArtistic_gen.pth
curl -O ColorizeArtistic_crit https://www.dropbox.com/s/xpq2ip9occuzgen/ColorizeArtistic_crit.pth
curl -O ColorizeArtisitic_PretrainOnly.pth https://www.dropbox.com/s/h782d1zar3vdblw/ColorizeArtistic_PretrainOnly_gen.pth
curl -O ColorizeArtistic_PretrainOnly.pth https://www.dropbox.com/s/gr81b3pkidwlrc7/ColorizeArtistic_PretrainOnly_crit.pth
curl -O ColorizeStable_gen.pth https://www.dropbox.com/s/axsd2g85uyixaho/ColorizeStable_gen.pth
curl -O ColorizeStable_crit.pth https://www.dropbox.com/s/xpq2ip9occuzgen/ColorizeStable_crit.pth
curl -O ColorizeStable_PretrainOnly_gen.pth https://www.dropbox.com/s/h782d1zar3vdblw/ColorizeStable_PretrainOnly_gen.pth
curl -O ColorizeStable_PretrainOnly_crit.pth https://www.dropbox.com/s/gr81b3pkidwlrc7/ColorizeStable_PretrainOnly_crit.pth
curl -O ColorizeVideo_gen.pth https://www.dropbox.com/s/axsd2g85uyixaho/ColorizeVideo_gen.pth
curl -O ColorizeVideo_crit.pth https://www.dropbox.com/s/xpq2ip9occuzgen/ColorizeVideo_crit.pth
curl -O ColorizeVideo_PretrainOnly_gen.pth  https://www.dropbox.com/s/h782d1zar3vdblw/ColorizeVideo_PretrainOnly_gen.pth
curl -O ColorizeVideo_PretrainOnly_crit.pth https://www.dropbox.com/s/gr81b3pkidwlrc7/ColorizeVidoe_PretrainOnly_crit.pth
curl -O Deoldify790000.pth https://drive.google.com/uc?export=download&confirm=1&id=1-mxmDF1Dh-PnQqRz_PeCrvsTkHjYCbi3


### Step 5 ###
# clean up after yourself
echo $PATH; if [ -z "${PATH-}" ]; then export PATH=/workspace/home/user/.local/bin; fi

# Create and activate the virtual environment
source ${VENV_DIR}
micromamba activate webui

### Final Step ###
# return home and run the program
cd INSTALL_DIR; ./${LAUNCH_SCRIPT}
#cd workspace/stable-diffusion-webui-forge; ./${LAUNCH_SCRIPT}
