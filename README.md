# terraform-ibm-cloud-vpn-gateway-example
terraform configuration example for ibm cloud VPN gateway setup, and use this a reference implementation for vpn gateway terraform configuration

What will be done in this vpn-gateway terraform configuration example:
1. Create one VPC
2. Create one subnet
3. Create VPN gateway
4. Create VPN connection
5. Create custom route if the VPN mode is "route".

# Run the configuration
For create policy based VPN:  
`tfa --var peer_address=1.2.3.4 --var preshared_key=my-preshare-key --var 'peer_cidrs=["192.168.0.0/24","192.168.1.0/24"]' --var 'mode=policy' -auto-approve`

For create route based VPN:  
`tfa --var peer_address=1.2.3.4 --var preshared_key=my-preshare-key --var 'peer_cidrs=["192.168.0.0/24","192.168.1.0/24"]' -auto-approve`

## Export IBM Cloud API Key
export IBMCLOUD_API_KEY=<YOUR_IBM_CLOUD_API_KEY>

## Initialize the directory
This is only done once while you intialized your terraform directory.

`terraform init`


## Show the plan
`terraform plan`


## Apply the configuration
`terraform apply`