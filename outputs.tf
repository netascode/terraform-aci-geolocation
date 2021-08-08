output "dn" {
  value       = aci_rest.geoSite.id
  description = "Distinguished name of `geoSite` object."
}

output "name" {
  value       = aci_rest.geoSite.content.name
  description = "Site name."
}
