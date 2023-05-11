resource "cloudflare_zone" "zone" {
  count = var.module_enabled ? 1 : 0

  depends_on = [var.module_depends_on]

  account_id = var.account_id
  zone       = var.zone
  paused     = var.paused
  jump_start = var.jump_start
  plan       = var.plan
  type       = var.type
}

locals {
  records = { for r in var.records : "${r.type}/${r.name}-${try(r.key, md5(jsonencode(r.data)), md5(r.value))}" => r }
}

resource "cloudflare_record" "record" {
  for_each = var.module_enabled ? local.records : null

  zone_id         = cloudflare_zone.zone[0].id
  name            = each.value.name
  type            = each.value.type
  value           = try(each.value.value, null)
  comment         = try(each.value.comment, null)
  ttl             = try(each.value.ttl, null)
  priority        = try(each.value.priority, null)
  proxied         = try(each.value.proxied, false)
  allow_overwrite = try(each.value.allow_overwrite, false)

  dynamic "data" {
    for_each = try([each.value.data], [])
    content {
      service  = try(data.value.service, null)
      proto    = try(data.value.proto, null)
      name     = try(data.value.name, null)
      priority = try(data.value.priority, null)
      weight   = try(data.value.weight, null)
      port     = try(data.value.port, null)
      target   = try(data.value.target, null)
    }
  }

}

resource "cloudflare_zone_dnssec" "default" {
  count   = var.module_enabled && var.dnssec_enabled ? 1 : 0
  zone_id = cloudflare_zone.zone[0].id
}
