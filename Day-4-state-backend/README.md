# Day 4 - Terraform State Backend
flowchart TB
    DEV1["Developer 1<br/>Dev-1 EC2"] -->|Pull / Push code| GIT["Git Repository<br/>GitHub"]
    DEV2["Developer 2<br/>Dev-2 EC2"] -->|Pull / Push code| GIT

    GIT -->|Terraform configuration| DEV1
    GIT -->|Terraform configuration| DEV2

    DEV1 -->|terraform init / plan / apply| TF1["Terraform CLI – Dev-1"]
    DEV2 -->|terraform init / plan / apply| TF2["Terraform CLI – Dev-2"]

    TF1 -->|Read / write state| S3["Common Remote Backend<br/>Amazon S3 Bucket<br/>terraform.tfstate"]
    TF2 -->|Read / write state| S3

    TF1 -->|Acquire state lock| LOCK["S3 Lock File<br/>terraform.tfstate.tflock"]
    TF2 -->|Acquire state lock| LOCK

    TF1 -->|AWS Provider API calls| AWS["AWS Account"]
    TF2 -->|AWS Provider API calls| AWS

    subgraph INFRA["Infrastructure managed by Terraform"]
      VPC["VPC"]
      SUBNET["Public / Private Subnets"]
      EC2["Application EC2 Instances"]
      OTHER["Other AWS Resources"]
      VPC --> SUBNET
      SUBNET --> EC2
      SUBNET --> OTHER
    end

    AWS --> INFRA
