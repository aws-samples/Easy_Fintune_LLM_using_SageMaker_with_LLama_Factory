#!/bin/bash
set -ex
wget  https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x  Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh  -b -f -p ../miniconda3
 
source  ../miniconda3/bin/activate
 
conda create -y -n py310  python=3.10
 
source activate py310

pip install --no-deps -e .
pip install -r requirements.txt
pip install torch==2.2.0
chmod +x ./s5cmd