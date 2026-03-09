# Terraform Remote State Project (AWS)

This project demonstrates how to manage Terraform infrastructure using a **remote backend** in AWS.

The Terraform state file is stored securely in **Amazon S3**, and state locking is implemented using **Amazon DynamoDB** to prevent concurrent infrastructure changes.

This setup reflects how infrastructure is managed in real-world **DevOps environments** where multiple engineers collaborate on cloud resources.

---

## Project Objectives

This project demonstrates:

- Terraform remote backend configuration
- Infrastructure provisioning using Terraform
- State storage using AWS S3
- State locking using DynamoDB
- Infrastructure lifecycle management

---

## Architecture

```
Developer Machine
│
▼
Terraform CLI
│
▼
S3 Bucket (Terraform State Storage)
│
▼
DynamoDB Table (State Locking)
│
▼
AWS Infrastructure
│
▼
EC2 Instance
```

---

## Technologies Used

| Tool | Purpose |
|------|---------|
| Terraform | Infrastructure as Code |
| AWS | Cloud Provider |
| Amazon S3 | Remote State Storage |
| Amazon DynamoDB | State Locking |
| Amazon EC2 | Compute Resource |
| Git | Version Control |

---

## Project Structure

```
terraform/
│
├── project1
│   │
│   ├── backend
│   │   └── main.tf
│   │
│   └── infrastructure
│       ├── provider.tf
│       ├── ec2.tf
│       └── outputs.tf
│
├── project2
│
└── .gitignore
```

### Backend Folder

Responsible for creating backend infrastructure:

- S3 bucket for storing Terraform state
- DynamoDB table for state locking

### Infrastructure Folder

Responsible for provisioning AWS resources such as:

- EC2 instances
- Networking components (future expansion)

---

## Terraform Remote Backend Configuration

Terraform backend configuration stores the Terraform state remotely in S3.

**Benefits include:**

- Centralized state storage
- Safe collaboration between multiple engineers
- Version history of state files
- Protection against accidental infrastructure corruption

Example backend configuration:

```hcl
terraform {
  backend "s3" {
    bucket         = "terraform-state-demo"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}
```

---

## Prerequisites

Before running this project, ensure the following tools are installed:

- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [AWS CLI](https://aws.amazon.com/cli/)
- [Git](https://git-scm.com/)
- An active AWS Account

---

## Configure AWS Credentials

Configure AWS credentials locally:

```bash
aws configure
```

Provide the following values when prompted:

```
AWS Access Key ID
AWS Secret Access Key
Default Region
Output Format
```

Terraform will use these credentials to interact with AWS.

---

## How to Run the Project

### 1. Install Terraform

Download and install Terraform from:

```
https://developer.hashicorp.com/terraform/downloads
```

Verify the installation:

```bash
terraform -version
```

---

### 2. Configure AWS Credentials

```bash
aws configure
```

Enter your AWS Access Key, Secret Key, Region, and Output format.

---

### 3. Initialize Terraform

```bash
terraform init
```

This will:
- Download required Terraform providers
- Configure the remote backend
- Prepare the working environment

---

### 4. Check Execution Plan

```bash
terraform plan
```

This command shows what infrastructure Terraform will create **before** any deployment occurs.

---

### 5. Deploy Infrastructure

```bash
terraform apply
```

Terraform will create the defined resources in AWS. Confirm when prompted.

---

### 6. Verify Infrastructure

After deployment, verify the following resources in the **AWS Console**:

- ✅ EC2 Instance
- ✅ S3 Bucket
- ✅ DynamoDB Table

---

### 7. Destroy Infrastructure

To remove all infrastructure created by Terraform:

```bash
terraform destroy
```

> This ensures cloud resources do not incur unnecessary costs.

---

## State Locking with DynamoDB

When Terraform runs, it creates a lock entry in DynamoDB to prevent multiple users from modifying infrastructure simultaneously.

**This prevents:**

- State corruption
- Conflicting infrastructure changes
- Simultaneous updates from different users

Once Terraform execution completes, the lock is **released automatically**.

---

## Why Remote State is Important

| Without Remote State | With Remote State |
|----------------------|-------------------|
| State stays on local machine | Centralized state management |
| Team collaboration is difficult | Safe multi-user operations |
| Infrastructure changes may conflict | Version control for state files |
| State file may be lost or corrupted | Secure, durable storage |

---

## Future Improvements

Possible enhancements to this project include:

- [ ] Creating VPC infrastructure
- [ ] Adding security groups
- [ ] Deploying applications on EC2
- [ ] Implementing CI/CD pipelines
- [ ] Integrating Docker containers
- [ ] Managing Kubernetes clusters

---

## Author

**Kashyap**  
DevOps Learning Project
