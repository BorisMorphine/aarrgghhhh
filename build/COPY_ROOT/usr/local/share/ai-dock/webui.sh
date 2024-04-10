#!/bin/bash
umask 002
branch=forge

if [[ -n "main" ]]; then
    branch="${WEBUI_BRANCH}"
fi

# -b flag has priority
while getopts b: flag
do
    case "${flag}" in
        b) branch="$OPTARG";;
    esac
done

printf "Updating stable-diffusion-webui (main)...\n"

cd /opt/stable-diffusion-webui
git checkout ${branch}
git pull

micromamba run -n webui ${PIP_INSTALL} -r requirements_versions.txt
