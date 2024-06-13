#!/bin/bash

sg_config=sg_config_multl_node_lora_ds.yaml
echo "sg_config=$sg_config"

#注意把s3 bucket 替换成自己账号的地址
OUTPUT_MODEL_S3_PATH=s3://sagemaker-us-west-2-434444145045/hyperpod/llama3-8b-ds/

source  ../miniconda3/bin/activate

conda activate py310

chmod +x ./s5cmd

#download training dataset
./s5cmd sync s3://sagemaker-us-west-2-434444145045/dataset-for-training/train/* /home/ubuntu/LLaMA-Factory/data/

NODE_RANK=$SLURM_NODEID
echo "NODE_RANK=$NODE_RANK"

WORLD_SIZE_JOB=$SLURM_NTASKS
echo "WORLD_SIZE_JOB=$WORLD_SIZE_JOB"

MASTER_ADDR=(`scontrol show hostnames \$SLURM_JOB_NODELIST | head -n 1`)
MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))

echo "MASTER_ADDR=$MASTER_ADDR"
echo "MASTER_PORT=$MASTER_PORT"

# get gpu count
gpu_count=$(nvidia-smi --query-gpu=gpu_name --format=csv,noheader | wc -l)

DEVICES=""

# 构建设备字符串
for ((i=0; i<gpu_count; i++)); do
    DEVICES+="$i"
    if ((i < gpu_count - 1)); then
        DEVICES+=","
    fi
done

echo "DEVICES=$DEVICES"

# export NCCL_IB_DISABLE=1

# 注意这里的网卡不是eth0，需要登录等工作集群用ip addr show命令查看
# export NCCL_SOCKET_IFNAME=ens6
export DS_BUILD_FUSED_ADAM=1
export NCCL_PROTO=simple
export NCCL_DEBUG=INFO
export HCCL_OVER_OFI=1
export FI_PROVIDER=efa
export NCCL_IGNORE_DISABLED_P2P=1



#注意如果有多个节点，则修改NNODES数了，并依次在各个node上执行llamafactory-cli train
if [ "$NODE_RANK" == "0" ]; then
    CUDA_VISIBLE_DEVICES="$DEVICES" NNODES=$WORLD_SIZE_JOB RANK=0 MASTER_ADDR="$MASTER_ADDR" MASTER_PORT="$MASTER_PORT" llamafactory-cli train "$sg_config"
else
    CUDA_VISIBLE_DEVICES="$DEVICES" NNODES=$WORLD_SIZE_JOB RANK=$NODE_RANK MASTER_ADDR="$MASTER_ADDR" MASTER_PORT="$MASTER_PORT" llamafactory-cli train "$sg_config"
fi

if [ "$NODE_RANK" == "0" ]; then
    echo "*****************finished training, start cp finetuned model*****************************"
    ./s5cmd sync "/home/ubuntu/finetuned_model" "$OUTPUT_MODEL_S3_PATH"
    echo '-----finished cp-------'
fi
