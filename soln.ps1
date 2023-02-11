# Build output object
$stackMetadata = [PSCustomObject]@{
    stack_name = ""
    front_door = $false
    webstack_cores_by_region = @()
}

# Populate Stack Name

# Needs validation to at least determine an ASE resource group exists?
$stackMetadata.stack_name = "chicken-dinner"

# Find Front Door Instances and populate front_door boolean
$stackMetadata.front_door = $false

$coreMetadata1 = [PSCustomObject]@{
        location = ""
        vnet_resource_group = ""
        vnet_name = ""
        deployment_option = ""
        app_gateways = @()
        app_groupSubnets = @()
        ases = @()
    }

    
    $coreMetadata1.location = "North Central US"
    $coreMetadata1.vnet_resource_group = "chickendinnernc-rg"
    $coreMetadata1.vnet_name = "chickendinnernc-vnet"

    # Need to convert this assignment to a function call to translate North Central US to 
    # $locationSplitString = $coreMetadata1.location.toLower().split(" ")

    # HOW DO WE DETERMINE DEPLOYMENT OPTION?
    $coreMetadata1.deployment_option = "chickendinner-deploymentoption"
    
    $coreMetadata1.app_gateways = @("app gateway 1", "app gateway 2")

    $coreMetadata1.app_groupSubnets = @()
    # $app_group_subnet_types = @("redis")

        $appGroupSubnet = [PSCustomObject]@{
            type = ""
            name = ""
            networksize = 24
            ruleoffset = 0
        }
            $appGroupSubnet.type = "Redis"
            $appGroupSubnet.name = "ChickenDinnerRedis"
            $appGroupSubnet.networksize = 24
            $appGroupSubnet.ruleoffset = 0 # TBD - not sure how this is calculated

            # Add the subnet to the output object
            $coreMetadata1.app_groupSubnets += $appGroupSubnet

            $stackMetadata.webstack_cores_by_region += $coreMetadata1


$coreMetadata2 = [PSCustomObject]@{
        location = ""
        vnet_resource_group = ""
        vnet_name = ""
        deployment_option = ""
        app_gateways = @()
        app_groupSubnets = @()
        ases = @()
    }

    
    $coreMetadata2.location = "South Central US"
    $coreMetadata2.vnet_resource_group = "chickendinnersc-rg"
    $coreMetadata2.vnet_name = "chickendinnersc-vnet"

    # Need to convert this assignment to a function call to translate North Central US to 
    # $locationSplitString = $coreMetadata2.location.toLower().split(" ")

    # HOW DO WE DETERMINE DEPLOYMENT OPTION?
    $coreMetadata2.deployment_option = "chickendinner2-deploymentoption"
    
    $coreMetadata2.app_gateways = @("app gateway 1", "app gateway 2")

    $coreMetadata2.app_groupSubnets = @()
    # $app_group_subnet_types = @("redis")

        $appGroupSubnet = [PSCustomObject]@{
            type = ""
            name = ""
            networksize = 24
            ruleoffset = 0
        }
            $appGroupSubnet.type = "Redis"
            $appGroupSubnet.name = "ChickenDinner2Redis"
            $appGroupSubnet.networksize = 24
            $appGroupSubnet.ruleoffset = 0 # TBD - not sure how this is calculated

            # Add the subnet to the output object
            $coreMetadata2.app_groupSubnets += $appGroupSubnet

            $stackMetadata.webstack_cores_by_region += $coreMetadata2
##################################################### solution #####################################
$stackMetadata.front_door = $stackMetadata.front_door.ToString().ToLower()
$outputFilePath = "main.tfvars"

$jsonString = ConvertTo-Json $stackMetadata.webstack_cores_by_region -Depth 5
$outputString = $jsonString -replace '"(\w+)":', '$1 = '

$outputString = @"
stack_name = "$($stackMetadata.stack_name)"
front_door = $($stackMetadata.front_door)
webstack_cores_by_region = $($outputString)
"@

$outputString | Out-File $outputFilePath

# Define the name of the Terraform executable
$terraformExecutable = "terraform"

# Find the absolute path of the Terraform executable
$terraformPath = (Get-Command $terraformExecutable -ErrorAction SilentlyContinue).Path

# Check if Terraform was found
if (-not $terraformPath) {
    Write-Output "Terraform is not installed. No action taken."
    exit 0
}

# Run the `terraform fmt` command
& $terraformPath fmt

# Check the exit code of the previous command
if ($LASTEXITCODE -ne 0) {
    Write-Output "Error: Terraform fmt failed."
    exit 1
} else {
    Write-Output "Success: Terraform fmt completed successfully."
}


return $stackMetadata