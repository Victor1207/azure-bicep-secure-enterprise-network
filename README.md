# Azure Bicep Secure Enterprise Network
This project demonstrates how to design and deploy a **secure enterprise-grade Azure network** using **Infrastructure as Code (IaC) with Bicep**.  
It follows Azure networking and governance best practices suitable for production environments.

## 🔐 Architecture Overview
The solution includes:
- Virtual Network (VNet) with address space segmentation
- Dedicated subnets for workloads
- Network Security Group (NSG) with least-privilege rules
- NSG-to-subnet association (network-level security)
- Azure Policy to **deny Public IP creation** (governance & compliance)
- Parameterized Bicep templates (no hardcoded secrets)

This design aligns with **enterprise security and governance standards**.

## 🧱 Deployed Resources
- Azure Virtual Network (VNet)
- Subnets
- Network Security Group (NSG)
- NSG association to subnet
- Azure Policy Definition (Deny Public IPs)

## 🛠 Technologies Used
- **Azure Bicep** (Infrastructure as Code)
- **Azure Networking**
- **Azure Policy**
- **Azure CLI**
- **GitHub**

## 📂 Repository Structure
├── main.bicep        # Core network infrastructure
├── main.json         # ARM template (compiled from Bicep)
├── policy.bicep      # Azure Policy definition (deny public IPs)
├── policy.json       # ARM policy template
└── README.md

## 👤 Author
Victor Olasehinde
