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

  name        = "SITE1"
  description = "Site Description"
  buildings = [{
    name        = "BUILDING1"
    description = "Building Description"
    floors = [{
      name        = "FLOOR1"
      description = "Floor Description"
      rooms = [{
        name        = "ROOM1"
        description = "Room Description"
        rows = [{
          name        = "ROW1"
          description = "Row Description"
          racks = [{
            name        = "RACK1"
            description = "Rack Description"
            nodes = [{
              id  = 101
              pod = 1
            }]
          }]
        }]
      }]
    }]
  }]
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

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.geoSite.content.descr
    want        = "Site Description"
  }
}

data "aci_rest" "geoBuilding" {
  dn = "${data.aci_rest.geoSite.id}/building-BUILDING1"

  depends_on = [module.main]
}

resource "test_assertions" "geoBuilding" {
  component = "geoBuilding"

  equal "name" {
    description = "name"
    got         = data.aci_rest.geoBuilding.content.name
    want        = "BUILDING1"
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.geoBuilding.content.descr
    want        = "Building Description"
  }
}

data "aci_rest" "geoFloor" {
  dn = "${data.aci_rest.geoBuilding.id}/floor-FLOOR1"

  depends_on = [module.main]
}

resource "test_assertions" "geoFloor" {
  component = "geoFloor"

  equal "name" {
    description = "name"
    got         = data.aci_rest.geoFloor.content.name
    want        = "FLOOR1"
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.geoFloor.content.descr
    want        = "Floor Description"
  }
}

data "aci_rest" "geoRoom" {
  dn = "${data.aci_rest.geoFloor.id}/room-ROOM1"

  depends_on = [module.main]
}

resource "test_assertions" "geoRoom" {
  component = "geoRoom"

  equal "name" {
    description = "name"
    got         = data.aci_rest.geoRoom.content.name
    want        = "ROOM1"
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.geoRoom.content.descr
    want        = "Room Description"
  }
}

data "aci_rest" "geoRow" {
  dn = "${data.aci_rest.geoRoom.id}/row-ROW1"

  depends_on = [module.main]
}

resource "test_assertions" "geoRow" {
  component = "geoRow"

  equal "name" {
    description = "name"
    got         = data.aci_rest.geoRow.content.name
    want        = "ROW1"
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.geoRow.content.descr
    want        = "Row Description"
  }
}

data "aci_rest" "geoRack" {
  dn = "${data.aci_rest.geoRow.id}/rack-RACK1"

  depends_on = [module.main]
}

resource "test_assertions" "geoRack" {
  component = "geoRack"

  equal "name" {
    description = "name"
    got         = data.aci_rest.geoRack.content.name
    want        = "RACK1"
  }

  equal "descr" {
    description = "descr"
    got         = data.aci_rest.geoRack.content.descr
    want        = "Rack Description"
  }
}

data "aci_rest" "geoRsNodeLocation" {
  dn = "${data.aci_rest.geoRack.id}/rsnodeLocation-[topology/pod-1/node-101]"

  depends_on = [module.main]
}

resource "test_assertions" "geoRsNodeLocation" {
  component = "geoRsNodeLocation"

  equal "tDn" {
    description = "tDn"
    got         = data.aci_rest.geoRsNodeLocation.content.tDn
    want        = "topology/pod-1/node-101"
  }
}
