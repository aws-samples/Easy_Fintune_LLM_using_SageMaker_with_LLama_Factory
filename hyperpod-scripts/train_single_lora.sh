#!/bin/bash
source  ../miniconda3/bin/activate

conda activate py310

chmod +x ./s5cmd

#download training dataset
./s5cmd sync s3://sagemaker-us-west-2-434444145045/dataset-for-training/train/* /home/ubuntu/LLaMA-Factory/data/

#start train
CUDA_VISIBLE_DEVICES=0 llamafactory-cli train sg_config_qlora.yaml


./s5cmd sync /home/ubuntu/finetuned_model s3://sagemaker-us-west-2-434444145045/hyperpod/llama3-8b-qlora/
