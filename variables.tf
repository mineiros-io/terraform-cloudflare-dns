# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# These variables must be set when using this module.
# ---------------------------------------------------------------------------------------------------------------------

variable "account_id" {
  description = "(String) Account ID to manage the zone resource in."
  type        = string
}

variable "zone" {
  description = "(Required) The DNS zone name which will be added."
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# These variables have defaults, but may be overridden.
# ---------------------------------------------------------------------------------------------------------------------

variable "paused" {
  description = "(Optional) Boolean of whether this zone is paused (traffic bypasses Cloudflare). Default: false."
  type        = bool
  default     = false
}

variable "jump_start" {
  description = "(Optional) Boolean of whether to scan for DNS records on creation. Ignored after zone is created. Default: false."
  type        = bool
  default     = false
}

variable "plan" {
  description = "(Optional) The name of the commercial plan to apply to the zone, can be updated once the zone is created; one of free, pro, business, enterprise."
  type        = string
  default     = "free"

  validation {
    condition     = contains(["free", "pro", "business", "enterprise"], var.plan)
    error_message = "The value must only be one of these valid values: free, pro, business, enterprise."
  }
}

variable "type" {
  description = "(Optional) A full zone implies that DNS is hosted with Cloudflare. A partial zone is typically a partner-hosted zone or a CNAME setup. Valid values: full, partial. Default is full."
  type        = string
  default     = "full"

  validation {
    condition     = contains(["full", "partial"], var.type)
    error_message = "The value must only be one of these valid values: full, partial."
  }
}

variable "records" {
  description = "(Optional) A list of DNS records."
  type        = any
  default     = []

  validation {
    condition     = alltrue([for x in var.records : can(x.name)])
    error_message = "All record sets must have a defined name."
  }

  validation {
    condition     = alltrue([for x in var.records : can(x.type)])
    error_message = "All record sets must have a defined type."
  }
}

variable "dnssec_enabled" {
  description = "(Optional) Whether to enable DNSSEC for the zone."
  type        = bool
  default     = false
}

# ------------------------------------------------------------------------------
# MODULE CONFIGURATION PARAMETERS
# These variables are used to configure the module.
# ------------------------------------------------------------------------------

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is 'true'."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  default     = []
}
