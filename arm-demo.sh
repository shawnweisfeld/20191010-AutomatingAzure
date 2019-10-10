# create a project name
projectName=demo-$RANDOM

# Set the resource group name and location for your server
resourceGroupName=myResourceGroup-$RANDOM
location='eastus'

# Set an admin login and password for your database
adminUser=ServerAdmin
adminPassword=`openssl rand -base64 16`

# Create a resource group
az group create \
    --name $resourceGroupName \
    --location $location

# Create a resource group with my templates
az group deployment create -g $resourceGroupName \
    --template-uri 'https://raw.githubusercontent.com/shawnweisfeld/20191010-AutomatingAzure/master/arm-demo.json' \
    --parameters projectName=$projectName location=$location adminUser=$adminUser adminPassword=$adminPassword

