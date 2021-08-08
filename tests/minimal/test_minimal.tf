terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "SITE1"
}

data "aci_rest" "geoSite" {
  dn = "uni/fabric/site-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "geoSite" {
  component = "geoSite"

  equal "name" {
    description = "name"
    got         = data.aci_rest.geoSite.content.name
    want        = module.main.name
  }
}
