# Inference Operator on Amazon SageMaker HyperPod EKS

Deploy large language models using the [Inference Operator](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-model-deployment.html) on an **existing** [Amazon SageMaker HyperPod](https://docs.aws.amazon.com/sagemaker/latest/dg/sagemaker-hyperpod-eks.html) EKS cluster.

> **This guide assumes you already have a SageMaker HyperPod EKS cluster
> in `InService` state with the Inference Operator installed.** It does not create VPC, EKS or SageMaker Hyperπod
> infrastructure from scratch. You can confirm if it is installed with `kubectl get inferenceendointconfigs`

The `models` directory contains folders for each model. Each model folder will contain a deployment YAML file alongside any additional instructions for deploying the model.