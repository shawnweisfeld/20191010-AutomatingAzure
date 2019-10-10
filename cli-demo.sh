# the azure cli uses the az command
az

# at any time I can ask for help on the current command
az -h

# for example if I needed help loging in I can do the following
az login -h

# however since I using the cloud shell I am already logged in
# so I can just pull up a list of the subscriptions that I have access to. 
az account list

# well that is not very readable, what if we format it as a table
az account list -o table

# remember earlier we talked about Resource Providers
# I can output a lit of them and check on there status. 
az provider list -o table

# I can also list all the resource groups in my subscription
az group list -o table

# lets create a new resouce group, but I forgot how
# lets ask for help
az group -h
az group create -help

# ok I need a location and a name
# but what locations are availabile to our account
az account -h

az account list-locations -o table

# Set the resource group name and location for your server
resourceGroupName=myResourceGroup-$RANDOM
location='eastus'

# Set an admin login and password for your database
adminlogin=ServerAdmin
password=`openssl rand -base64 16`

# The logical server name has to be unique in the system
servername=server-$RANDOM

# The ip address range that you want to allow to access your DB
startip=0.0.0.0
endip=0.0.0.0

# Create a resource group
az group create \
    --name $resourceGroupName \
    --location $location

# Create a logical server in the resource group
az sql server create \
    --name $servername \
    --resource-group $resourceGroupName \
    --location $location  \
    --admin-user $adminlogin \
    --admin-password $password

# Configure a firewall rule for the server
az sql server firewall-rule create \
    --resource-group $resourceGroupName \
    --server $servername \
    -n AllowYourIp \
    --start-ip-address $startip \
    --end-ip-address $endip

# Create a database in the server with zone redundancy as false
az sql db create \
    --resource-group $resourceGroupName \
    --server $servername \
    --name mySampleDatabase \
    --sample-name AdventureWorksLT \
    --edition GeneralPurpose \
    --family Gen4 \
    --capacity 1 \
    --zone-redundant false

# Echo random password
echo $password

# Cleanup
az group delete --name $resourceGroupName
