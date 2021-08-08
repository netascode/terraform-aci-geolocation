<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-geolocation/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-geolocation/actions/workflows/test.yml)

# Terraform ACI Geolocation Module

ACI Geolocation

Location in GUI:
`Fabric` » `Fabric Policies` » `Policies` » `Geolocation`

## Examples

```hcl
module "aci_geolocation" {
  source = "netascode/geolocation/aci"

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

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Site name. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Site description. | `string` | `""` | no |
| <a name="input_buildings"></a> [buildings](#input\_buildings) | List of buildings. Allowed values `id`: 1-4000. Allowed values `pod`: 1-255. Default value `pod`: 1. | <pre>list(object({<br>    name        = string<br>    description = optional(string)<br>    floors = optional(list(object({<br>      name        = string<br>      description = optional(string)<br>      rooms = optional(list(object({<br>        name        = string<br>        description = optional(string)<br>        rows = optional(list(object({<br>          name        = string<br>          description = optional(string)<br>          racks = optional(list(object({<br>            name        = string<br>            description = optional(string)<br>            nodes = optional(list(object({<br>              id  = number<br>              pod = optional(number)<br>            })))<br>          })))<br>        })))<br>      })))<br>    })))<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `geoSite` object. |
| <a name="output_name"></a> [name](#output\_name) | Site name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.geoBuilding](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.geoFloor](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.geoRack](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.geoRoom](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.geoRow](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.geoRsNodeLocation](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.geoSite](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->