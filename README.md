# terraform-cloudflare-dns

<!-- BEGIN TERRAFORM DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.7, < 2.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.record](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_zone.zone](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_jump_start"></a> [jump\_start](#input\_jump\_start) | (Optional) Boolean of whether to scan for DNS records on creation. Ignored after zone is created. Default: false. | `bool` | `false` | no |
| <a name="input_module_depends_on"></a> [module\_depends\_on](#input\_module\_depends\_on) | (Optional) A list of external resources the module depends\_on. Default is '[]'. | `any` | `[]` | no |
| <a name="input_module_enabled"></a> [module\_enabled](#input\_module\_enabled) | (Optional) Whether to create resources within the module or not. Default is 'true'. | `bool` | `true` | no |
| <a name="input_paused"></a> [paused](#input\_paused) | (Optional) Boolean of whether this zone is paused (traffic bypasses Cloudflare). Default: false. | `bool` | `false` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | (Optional) The name of the commercial plan to apply to the zone, can be updated once the zone is created; one of free, pro, business, enterprise. | `string` | `"free"` | no |
| <a name="input_records"></a> [records](#input\_records) | (Optional) A list of DNS records. | `any` | `[]` | no |
| <a name="input_type"></a> [type](#input\_type) | (Optional) A full zone implies that DNS is hosted with Cloudflare. A partial zone is typically a partner-hosted zone or a CNAME setup. Valid values: full, partial. Default is full. | `string` | `"full"` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | (Required) The DNS zone name which will be added. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_module_enabled"></a> [module\_enabled](#output\_module\_enabled) | Whether the module is enabled. |
| <a name="output_record"></a> [record](#output\_record) | All `cloudflare_record` resource objects. |
| <a name="output_zone"></a> [zone](#output\_zone) | The `cloudflare_zone` resource object. |

<!-- END TERRAFORM DOCS -->
