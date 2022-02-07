# ------------------------------------------------------------------------------
# OUTPUT CALCULATED VARIABLES (prefer full objects)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT ALL RESOURCES AS FULL OBJECTS
# ------------------------------------------------------------------------------

output "zone" {
  description = "The `cloudflare_zone` resource object."
  value       = try(cloudflare_zone.zone[0], null)
}

output "record" {
  description = "All `cloudflare_record` resource objects."
  value       = try(cloudflare_record.record, null)
}

output "dnssec" {
  description = "All DNSSEC details."
  value       = try(cloudflare_zone_dnssec.default[0], null)
}

# ------------------------------------------------------------------------------
# OUTPUT ALL INPUT VARIABLES
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# OUTPUT MODULE CONFIGURATION
# ------------------------------------------------------------------------------

output "module_enabled" {
  description = "Whether the module is enabled."
  value       = var.module_enabled
}
