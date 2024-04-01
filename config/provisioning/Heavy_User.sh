!#bin/bash

### Step 1 ###

# cd Home 
cd /Home/User/

# Get A1111
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

# start service
./webui.sh

### Step 2 ###

# Get Forge
git clone https://github.com/lllyasviel/stable-diffusion-webui-forge

# update webui-user.sh
sudo curl -O webui-user.sh https://raw.githubusercontent.com/BorisMorphine/stable-diffusion-webui/main/webui-user.sh

# update webui-user.bat
sudo curl -O https://raw.githubusercontent.com/BorisMorphine/stable-diffusion-webui/main/build/webui-user.bat

# Set global variable
git config --global pull.rebase false

# cd to main repo and clone Forge
cd /workspace/stable-diffusion-webui/
git remote add forge https://github.com/lllyasviel/stable-diffusion-webui-forge
git branch lllyasviel/main
git checkout lllyasviel/main
git fetch forge
git branch -u forge/main
git pull 

### Step 3 ###

# cd back into Forge via Workspace and update user docs
cd /workspace/home/user/stable-diffusuion-webui-forge/

# Run script
bash ./webui-user.sh

# Run backup script
bash ./webui-user.bat

# & start service
./webui.sh

### Step 4 ###

# Setup additional repositories (ensure you're in the correct directory for these operations)
install git lfs
cd ${controlnet_dir}
git lfs
git clone Deliberate_v.5.safetensors https://huggingface.co/XpucT/Deliberate/blob/main/Deliberate_v5.safetensors
git lfs
git clone Deliberate_v.5.safetensors https://huggingface.co/XpucT/Deliberate/blob/main/Deliberate_v5.safetensors
https://huggingface.co/XpucT/Deliberate/blob/main/Deliberate_v5-inpainting.safetensors

cd ${ESRGAN}
wget -O 4xUltraSharp.pth https://huggingface.co/uwg/upscaler/resolve/main/ESRGAN/4x-UltraSharp.pth
wget -O 4xUltraMix_Balanced.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/KBJRBQyR
wget -O 4xUltraMix_Restore.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/KBJRBQyR
wget -O 4xUltraMix_Smooth.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/PIRDEYgT
wget -O 4x-FSDedither.pth https://drive.google.com/uc?export=download&confirm=1&id=1H4KQyhcknOoExjvDdsoxAgTBMO7JuJ3w
wget -O 8xESRGAN.pth https://icedrive.net/1/43GNBihZyi
wget -O 16xESRGAN.pth https://objectstorage.us-phoenix-1.oraclecloud.com/n/ax6ygfvpvzka/b/open-modeldb-files/o/16x-ESRGAN.pth
wget -O 1x_GainRESV3_Aggro.pth https://mega.nz/folder/yg0lHQoJ#sP8_BfDk2YlshFjOL9Qrtg/file/TlkHjITR
wget -O 1x_GainRESV3_Nautral.pth https://mega.nz/folder/yg0lHQoJ#sP8_BfDk2YlshFjOL9Qrtg/file/KxkVEaAQ
wget -O 1x_GainRESV3_Passive.pth https://mega.nz/folder/yg0lHQoJ#sP8_BfDk2YlshFjOL9Qrtg/file/H49nEAzI
wget -O 4xNomos8kDAT.pth https://drive.usercontent.google.com/download?id=1JRwXYeuMBIsyeNfsTfeSs7gsHqCZD7x
wget -O 4xLSDIRplus.pth https://github.com/Phhofm/models/blob/main/4xLSDIRplus/4xLSDIRplus.pth
wget -0 BSRGAN https://github.com/cszn/KAIR/releases/download/v1.0/BSRGAN.pth

cd ${ckpt}
wget https://huggingface.co/stabilityai/sdxl-turbo/blob/main/sd_xl_turbo_1.0.safetensors

cd ${lora}
wget -O weird_lanscape.safetensors https://civitai.com/api/download/models/309330?type=Model&format=SafeTensor
wget -O sheet_of_acid.safetensors https://civitai.com/api/download/models/145277?type=Model&format=SafeTensor
wget -O gonzo.safetensors https://civitai.com/api/download/models/127015?type=Model&format=SafeTensor

# Build StableSR
cd ${extensions}
git clone https://github.com/pkuliyi2015/sd-webui-stablesr.git
cd /scripts
wget -O stablesr_turbo.ckpt https://huggingface.co/Iceclear/StableSR/blob/main/stablesr_turbo.ckpt

# Build DeOldify
cd ${extensions}
git clone https://github.com/SpenserCai/modles/sd-webui-deoldify.git
cd ${extensions}/DeOldify/models/Deoldify
wget -O ColorizeArtistic_gen.pth https://data.deepai.org/deoldify/ColorizeArtistic_gen.pth
wget -O ColorizeArtistic_crit https://www.dropbox.com/s/xpq2ip9occuzgen/ColorizeArtistic_crit.pth
wget -O ColorizeArtisitic_PretrainOnly.pth https://www.dropbox.com/s/h782d1zar3vdblw/ColorizeArtistic_PretrainOnly_gen.pth
wget -O ColorizeArtistic_PretrainOnly.pth https://www.dropbox.com/s/gr81b3pkidwlrc7/ColorizeArtistic_PretrainOnly_crit.pth
wget -O ColorizeStable_gen.pth https://www.dropbox.com/s/axsd2g85uyixaho/ColorizeStable_gen.pth
wget -O ColorizeStable_crit.pth https://www.dropbox.com/s/xpq2ip9occuzgen/ColorizeStable_crit.pth
wget -O ColorizeStable_PretrainOnly_gen.pth https://www.dropbox.com/s/h782d1zar3vdblw/ColorizeStable_PretrainOnly_gen.pth
wget -O ColorizeStable_PretrainOnly_crit.pth https://www.dropbox.com/s/gr81b3pkidwlrc7/ColorizeStable_PretrainOnly_crit.pth
wget -O ColorizeVideo_gen.pth https://www.dropbox.com/s/axsd2g85uyixaho/ColorizeVideo_gen.pth
wget -O ColorizeVideo_crit.pth https://www.dropbox.com/s/xpq2ip9occuzgen/ColorizeVideo_crit.pth
wget -O ColorizeVideo_PretrainOnly_gen.pth  https://www.dropbox.com/s/h782d1zar3vdblw/ColorizeVideo_PretrainOnly_gen.pth
wget -O ColorizeVideo_PretrainOnly_crit.pth https://www.dropbox.com/s/gr81b3pkidwlrc7/ColorizeVidoe_PretrainOnly_crit.pth
wget -O Deoldify790000.pth https://drive.google.com/uc?export=download&confirm=1&id=1-mxmDF1Dh-PnQqRz_PeCrvsTkHjYCbi3

# Add any additional model download or setup commands here
# Remember to adjust commands for services like Google Drive or Mega as needed

# Final steps or cleanup, if necessary

cd /workspace
sudo wget -O -force stable-diffusion-webui https://github.com/lllyasviel/stable-diffusion-webui-forge 
cd /workspace/stable-diffusion-webui
pip install -r requirements.txt
pip install -r requirements_versions.txt
pip install -r requirements_npu.txt
pip install -r requirements-test.txt
sudo wget force webui-user.sh https://raw.githubusercontent.com/Roldondo/stable-diffusion-webui/main/webui-user.sh

cd /opt
sudo wget -force -O stable-diffusion-webui https://github.com/lllyasviel/stable-diffusion-webui-forge 
cd /opt/stable-diffusion-webui
pip install -r requirements.txt
pip install -r requirements_versions.txt
pip install -r requirements_npu.txt
pip install -r requirements-test.txt
sudo wget -force -O webui-user.sh https://raw.githubusercontent.com/Roldondo/stable-diffusion-webui/main/webui-user.sh

cd /opt/stable-diffusion-webui/models/ESRGAN
wget -O 4xUltraSharp.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/vRYVhaDA
wget -O 4xUltraMix_Balanced.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/KBJRBQyR
wget -O 4xUltraMix_Restore.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/KBJRBQyR
wget -O 4xUltraMix_Smooth.pth https://mega.nz/folder/qZRBmaIY#nIG8KyWFcGNTuMX_XNbJ_g/file/PIRDEYgT
wget -O 4x-FSDedither.pth https://drive.google.com/uc?export=download&confirm=1&id=1H4KQyhcknOoExjvDdsoxAgTBMO7JuJ3w
wget -O Bendel_Halftone.pth https://drive.google.com/uc?export=download&confirm=1&id=1vR_tvWNi8jXhXdmgW5xvWsQp0pXN3ge-
wget -O 8xESRGAN.pth https://icedrive.net/1/43GNBihZyi
wget -O 16xESRGAN.pth https://objectstorage.us-phoenix-1.oraclecloud.com/n/ax6ygfvpvzka/b/open-modeldb-files/o/16x-ESRGAN.pth
wget -O 16xPNSR.pth https://openmodeldb.info/models/16x-PSNR#:~:text=Download%20(64.1,by%20Google%20Drive
wget -O RealSR_DF2K.pth https://openmodeldb.info/models/4x-realsr-df2k#:~:text=Download%20(63.8,by%20Google%20Drive
wget -O ClearRealityV1.pth https://mega.nz/folder/Xc4wnC7T#yUS5-9-AbRxLhpdPW_8f2w/file/fQJ3wDAT
wget -O ClearRealitySoft.pth https://mega.nz/folder/Xc4wnC7T#yUS5-9-AbRxLhpdPW_8f2w/file/PVR3lL7J
wget - 2xDeGIF.pth https://icedrive.io/download?p=Q3Y7zO1byHKbp_6dk4z8vLT9s7pTRI6x8IB4006YWiMsqTkKrBU_hFPjCNSOk3T7B.2EQkV2AjhbopISfrZQakFWwg9lsYtqHvDO0zGXZSfiqQ5WwYLr9jbE2g4AZyi59d1FntI1s4cR8.VFrikS6HKMOnq8.5fCVS6NkVqB8_9wqFM.9rE3H5Dn6r7XvIh0KFnpTXYmyaB2gIHASJXwP8h.A3i42W8s1wtR_QpqD8E-
wget -O  1x_NMKD-h264Texturize_500k.pth https://icedrive.io/download?p=Q3Y7zO1byHKbp_6dk4z8vLT9s7pTRI6x8IB4006YWiMsqTkKrBU_hFPjCNSOk3T7B.2EQkV2AjhbopISfrZQakFWwg9lsYtqHvDO0zGXZSfiqQ5WwYLr9jbE2g4AZyi59d1FntI1s4cR8.VFrikS6HKMOnq8.5fCVS6NkVqB8_9wqFM.9rE3H5Dn6r7XvIh0KFnpTXYmyaB2gIHASJXwP8h.A3i42W8s1wtR_QpqD8E-
wget -O 8x_NMKD-SUPERSCALE_150000_G https://icedrive.io/download?p=Q3Y7zO1byHKbp_6dk4z8vLT9s7pTRI6x8IB4006YWiM.hewQ706SaIhk7lSe0y__B.2EQkV2AjhbopISfrZQakFWwg9lsYtqHvDO0zGXZSdcMOwQcUGWT1Zz89h.bzuE6kHnd0AV8ehoUcW7WQlM_M.QgnRsxC6ncOV99qLFVioHdQRr7DXT1YL0MA87LtDCLJqkHZD8rczLen8twcloeuuzUBXdcViipJ5zwAgLHWQ-
wget -O 4x-Nomos8kHAT-L https://openmodeldb.info/models/4x-Nomos8kHAT-L-otf#:~:text=Download%20(158.1,by%20Google%20Drive
wget -O Deoldify790000.pth https://drive.google.com/uc?export=download&confirm=1&id=1-mxmDF1Dh-PnQqRz_PeCrvsTkHjYCbi3

cd /opt/stable-diffusion-webui/models/Stable-diffusion
wget https://huggingface.co/stabilityai/sdxl-turbo/blob/main/sd_xl_turbo_1.0.safetensors

cd /opt/stable-diffusion-webui/extensions
git clone https://civitai.com/models/151467/civitai-browser-or-sd-webui-extension.git
git clone https://github.com/pkuliyi2015/sd-webui-stablesr.git
cd /opt/stable-diffusion-webui/extensions/sd-webui-stablesr/scripts
wget -O stablesr_turbo.ckpt https://huggingface.co/Iceclear/StableSR/blob/main/stablesr_turbo.ckpt

cd /opt/stable-diffusion-webui/extensions
git clone https://github.com/SpenserCai/sd-webui-deoldify
cd /opt/stable-diffusion-webui/extensions/sd-webui-deoldify/models/deoldify 
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

cd /
pip install opencv-python
pip install imageio
pip install imageio-ffmpeg
pip install onnxruntime
pip install pymatting
pip install pooch
pip install ezsynth
git submodule update --init --recursive
(cd ebsynth && ./build-linux-cpu+cuda.sh)

cd /opt/stable-diffusion-webui/extensions
git clone https://github.com/s9roll7/ebsynth_utility.git
git clone https://github.com/Scholar01/sd-webui-mov2mov.git
git clone https://github.com/Scholar01/sd-webui-bg-mask.git

echo $PATH; if [ -z "${PATH-}" ]; then export PATH=/workspace/home/user/.local/bin; fi

python3 /opt/stable-diffusion-webui/launch.py
