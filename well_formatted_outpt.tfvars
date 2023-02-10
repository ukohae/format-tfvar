stack_name = "chicken-dinner"
front_door = false
webstack_cores_by_region = [
  {
    location            = "North Central US"
    vnet_resource_group = "chickendinnernc-rg"
    vnet_name           = "chickendinnernc-vnet"
    deployment_option   = "chickendinner-deploymentoption"
    app_gateways        = ["app gateway 1", "app gateway 2"]
    app_groupSubnets = [
      {
        type        = "Redis"
        name        = "ChickenDinnerRedis"
        networksize = 24
        ruleoffset  = 0
      }
    ]
    ases = [""]
  }
]