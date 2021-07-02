Digital Security Core API is an implementation using Azure functions based on the Provider & Shared Services business needs - for both analytical and transactional use cases.  The implementation contain the following.
- APIs supporting the Digital Security user interactions in the UI such as registration and authorization requests.
- User information will be stored in the Azure COSMOS DB and Azure Active Directory over the Cloud. 
- Using Azure API Management for securing the APIs. 


### Product Information
| Product Name      | ASK ID          | Delivery Lead      | Architect       |
|-------------------|-----------------|--------------------|-----------------|
| Digital Security  | UHGWM110-026580 | Venkata S Chunduri | Subhash Kommuru |

### Data Usage
This API would not collect PHI or PII data for any user. The gateway uses oAuth2, access and refresh token to fetch the data ensuring data security.

### Code Management
We use Jenkins DSL shared library to support all of our CI/CD needs. 
Please refer documentation at [here](https://github.optum.com/ct-instrumentation/jenkins)

### Architecture Summary
<img src="https://github.optum.com/digitalsecurity/DigitalSecurity-Core/blob/master/architecturesummary.png">

### provider Block Information
Make sure you set these environment varibales before running this terraform script on local. You don't have to provide this in actual CI/CD implementation since we use service principal

First, we need to create service principal

```
    az ad sp create-for-rbac --name="BookDemoTerraform" --role="Contributor" --scopes="/subscriptions/<Subscription Id>"
```

Then, You can export the following information as environment variables

```
    export ARM_SUBSCRIPTION_ID="f7b70a1c-6526-4eb6-bc09-473019d75cf8"
    export ARM_CLIENT_ID="2fc09e97-1ce1-4aa4-88af-0d3b5915339b"
    export ARM_CLIENT_SECRET="0KgZyPYYP0L06ZU9GiSDT6_gefOAbTbVo8"
    export ARM_TENANT_ID="db05faca-c82a-4b9d-b9c5-0f64b6755421"
```

## Initialization

We have to create a remote backend for the terraform state so that we can collaborate as a team and protect sensitive information in the state.

First, we need to create a storage account with the following commands. **This should be done only once.**

```
    # 1- Create Resource Group
    az group create --name <resource group name> --location westeurope

    # 2- Create storage account
    az storage account create --resource-group <resource group name> --name <stoarge account name> --sku Standard_LRS --encryption-services blob

    # 3- Create blob container
    az storage container create --name <container name> --account-name <stoarge account name>

    # 4- Get storage account key
    ACCOUNT_KEY=$(az storage account keys list --resource-group <resource group name> --account-name <stoarge account name> --query [0].value -o tsv)

    echo $ACCOUNT_KEY
```

Save the Access Key as the environment varible

```
    export ARM_ACCESS_KEY="DrPiq4VZxdzPRY7NY+OpfKulhzaI+aPU2zPzqhCRMT5x51/RGnpNat0OEpcJCB+HmKjQYksBojtlrH5712l5qw=="
    export ARM_ACCESS_KEY=$ACCOUNT_KEY
```

Initilaze the terraform for different environments

```
    # Dev Environment
    terraform init -backend-config="tfvars/backends/dev.backend.tfvars"

    # QA Environment
    terraform init -backend-config="tfvars/backends/qa.backend.tfvars"

    # Prod Environment
    terraform init -backend-config="tfvars/backends/prod.backend.tfvars"
```

## Pre-Commit Hooks

It's better to run these commands as Pre-commit Hooks for the consisitency

```
   terraform validate
   terraform fmt
```

## Zero Down Deployment

We can use the follwoing lifecycle method for the zero down deployment. Make sure we have different names since resources with the same name can't be created.

```
    lifecycle { 
        create_before_destroy = true
    }
```



terraform plan -var-file="tfvars/environment/dev.tfvars"

terraform plan -var-file="tfvars/environment/qa.tfvars"



terraform apply -var-file="tfvars/environment/dev.tfvars"

terraform apply -var-file="tfvars/environment/qa.tfvars"