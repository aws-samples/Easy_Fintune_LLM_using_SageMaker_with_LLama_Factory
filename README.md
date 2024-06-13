# For workshop <(中文) Easy Fintune LLM using SageMaker Notebook - Training Job- HyperPod with LLama-Factory>

## Introduction
- LLaMA-Factory is an open-source community framework for large model integration and training. AWS SageMaker is a comprehensive machine learning platform within Amazon Web Services (AWS). It provides a simple and efficient way to build, train, and deploy machine learning models. SageMaker Training Job is one of the core features of this platform for training machine learning models.

- In this workshop, it demostrate the method and process of fintuning LLama-3 using SageMaker Training Job with LLama-Factory under the hood.  
    1. QLora SFT in SageMaker Notebook with Single GPU 
    2. Deploy Finetune Lora Adpaters in SageMaker Notebook 
    3. Deploy Finetune Lora Adpaters in SageMaker Endpoint with Lmi-vllm engine 
    4. Finetune in SageMaker Training Job distributed in Multi Nodes and Multi GPUs 
    5. Setup HyperPod cluster and finetune in Hyperpod cluster

### SageMaker Introduction
SageMaker Training Job works by running training jobs on AWS cloud resources, utilizing the computing power of Amazon EC2 instances to execute the training process. Users can choose to use built-in SageMaker algorithms or bring their own algorithms to train models.

- The main advantages of using SageMaker for training large language models:
    - High-performance GPU instances to meet the demands of large model training, with better performance and scalability than on-premises data centers.
    - Support for distributed training, parallelizing training across multiple GPU instances to significantly improve training speed.
    - Pre-built deep learning container images with optimized frameworks and libraries to accelerate the training process.
    - Integration with Amazon S3 for convenient storage and access to large-scale training data.
    - Monitoring and debugging tools to monitor the training process in real-time, record metrics and logs.
    - Cloud environment provides multi-layered security protection, compliant with various industry standards.

### LLaMA-Factory Introduction
- LLaMA-Factory is an open-source community framework for large model integration and training, supporting:
    - Various models: LLaMA, LLaVA, Mistral, Mixtral-MoE, Qwen, Yi, Gemma, Baichuan, ChatGLM, Phi, and more.
    - Integration methods: (incremental) pre-training, (multimodal) instructional supervised fine-tuning, reward model training, PPO training, DPO training, KTO training, ORPO training, and more.
    - Multiple precisions: 32-bit full parameter fine-tuning, 16-bit frozen fine-tuning, 16-bit LoRA fine-tuning, and 2/4/8-bit QLoRA fine-tuning based on AQLM/AWQ/GPTQ/LLM.int8.
    - Advanced algorithms: GaLore, BAdam, DoRA, LongLoRA, LLaMA Pro, Mixture-of-Depths, LoRA+, LoftQ, and Agent fine-tuning.
- Therefore, LLaMA-Factory, combined with SageMaker, can also be applied to other models and training methods, fully leveraging SageMaker's managed services. This eliminates the need to worry about resource system configuration and allows training tasks to be launched on-demand. After training is complete, node resources are automatically released, avoiding long-term resource occupation and providing a more convenient and economical training experience.

### Experiment Objectives
- Familiarize yourself with using LLaMA-Factory on SageMaker Notebook for QLora SFT training and inference.
- Familiarize yourself with using SageMaker Training Job based on LLaMA-Factory for multi-node multi-GPU training.
- Familiarize yourself with using SageMaker LMI container to deploy Lora models and provide high-performance real-time inference.
- Familiarize yourself with setting up a SageMaker HyperPod cluster and using LLaMA-Factory for multi-node multi-GPU training on the cluster.

## Prerequisites
- Some experience with AWS
- Basic experience with Linux environments
- Basic experience with Python and Jupyter Notebook

## Target Audience
- Algorithm/Software Engineers
- Algorithm/Software Architects

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

