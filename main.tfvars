location = "North Central US"
vnet_resource_group = "chickendinnernc-rg"
vnet_name = "chickendinnernc-vnet"
deployment_option = "chickendinner-deploymentoption"
app_gateways = ["app gateway 1", "app gateway 2"]
app_groupSubnets = [{ @{type = Redis; name = ChickenDinnerRedis; networksize = 24; ruleoffset = 0} }]
ases = [""]
location = "South Central US"
vnet_resource_group = "chickendinnersc-rg"
vnet_name = "chickendinnersc-vnet"
deployment_option = "chickendinner2-deploymentoption"
app_gateways = ["app gateway 1", "app gateway 2"]
app_groupSubnets = [{ @{type = Redis; name = ChickenDinner2Redis; networksize = 24; ruleoffset = 0} }]
ases = [""]
