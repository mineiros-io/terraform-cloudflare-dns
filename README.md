[<img src="https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg" width="400"/>](https://mineiros.io/?ref=terraform-cloudflare-dns)

[![Build Status](https://github.com/mineiros-io/terraform-cloudflare-dns/workflows/Tests/badge.svg)](https://github.com/mineiros-io/terraform-cloudflare-dns/actions)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/mineiros-io/terraform-cloudflare-dns.svg?label=latest&sort=semver)](https://github.com/mineiros-io/terraform-cloudflare-dns/releases)
[![Terraform Version](https://img.shields.io/badge/terraform-0.14.7+%20|%202-623CE4.svg?logo=terraform)](https://github.com/hashicorp/terraform/releases)
[![Join Slack](https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack)](https://mineiros.io/slack)

# terraform-cloudflare-dns

A [Terraform] module for creating and managing a 
[DNS Cloudfare](https://developers.cloudflare.com/fundamentals/internet/protocols/dns)
resource.

**_This module supports Terraform version 0.14.7 up to (not including) version 2.0
and is compatible with the Terraform Cloudfare Provider version 3**

This module is part of our Infrastructure as Code (IaC) framework
that enables our users and customers to easily deploy and manage reusable,
secure, and production-grade cloud infrastructure.


- [Module Features](#module-features)
- [Getting Started](#getting-started)
- [Module Argument Reference](#module-argument-reference)
  - [Main Resource Configuration](#main-resource-configuration)
  - [Extended Resource Configuration](#extended-resource-configuration)
  - [Module Configuration](#module-configuration)
- [Module Outputs](#module-outputs)
- [External Documentation](#external-documentation)
  - [Cloudfare Documentation](#cloudfare-documentation)
  - [Terraform Cloudfare Provider Documentation](#terraform-cloudfare-provider-documentation)
- [Module Versioning](#module-versioning)
  - [Backwards compatibility in `0.0.z` and `0.y.z` version](#backwards-compatibility-in-00z-and-0yz-version)
- [About Mineiros](#about-mineiros)
- [Reporting Issues](#reporting-issues)
- [Contributing](#contributing)
- [Makefile Targets](#makefile-targets)
- [License](#license)

## Module Features

This module implements the following Terraform resources

- `cloudflare_zone`
- `cloudflare_record`
- `cloudflare_zone_dnssec`

## Getting Started

Most common usage of the module:

```hcl
module "terraform-cloudflare-dns" {
  source = "git@github.com:mineiros-io/terraform-cloudflare-dns.git?ref=v0.1.0"
}
```

## Module Argument Reference

See [variables.tf] and [examples/] for details and use-cases.

### Main Resource Configuration

- [**`zone`**](#var-zone): *(**Required** `string`)*<a name="var-zone"></a>

  Account ID to manage the zone resource in.

- [**`zone`**](#var-zone): *(**Required** `string`)*<a name="var-zone"></a>

  The DNS zone name which will be added.

- [**`paused`**](#var-paused): *(Optional `bool`)*<a name="var-paused"></a>

  Boolean of whether this zone is paused (traffic bypasses Cloudflare).

  Default is `false`.

- [**`jump_start`**](#var-jump_start): *(Optional `bool`)*<a name="var-jump_start"></a>

  Boolean of whether to scan for DNS records on creation. Ignored after
  zone is created.

  Default is `false`.

- [**`plan`**](#var-plan): *(Optional `string`)*<a name="var-plan"></a>

  The name of the commercial plan to apply to the zone, can be updated
  once the zone is created; one of free, pro, business, enterprise.

  Default is `"free"`.

- [**`type`**](#var-type): *(Optional `string`)*<a name="var-type"></a>

  A full zone implies that DNS is hosted with Cloudflare. A partial zone
  is typically a partner-hosted zone or a CNAME setup. Valid values:
  full, partial.

  Default is `"full"`.

### Extended Resource Configuration

- [**`records`**](#var-records): *(Optional `list(record)`)*<a name="var-records"></a>

  A list of DNS records.

  Default is `[]`.

  Each `record` object in the list accepts the following attributes:

  - [**`name`**](#attr-records-name): *(**Required** `string`)*<a name="attr-records-name"></a>

    The name of the record.

  - [**`type`**](#attr-records-type): *(**Required** `string`)*<a name="attr-records-type"></a>

    The type of the record

  - [**`value`**](#attr-records-value): *(Optional `string`)*<a name="attr-records-value"></a>

    The value of the record. Either this or `data` must be
    specified

  - [**`ttl`**](#attr-records-ttl): *(Optional `number`)*<a name="attr-records-ttl"></a>

    The TTL of the record ([automatic: '1'](https://api.cloudflare.com/#getting-started-endpoints))

  - [**`comment`**](#attr-records-comment): *(Optional `string`)*<a name="attr-records-comment"></a>

    Comments or notes about the DNS record. This field has no effect on DNS responses.

  - [**`priority`**](#attr-records-priority): *(Optional `number`)*<a name="attr-records-priority"></a>

    The priority of the record

  - [**`proxied`**](#attr-records-proxied): *(Optional `bool`)*<a name="attr-records-proxied"></a>

    Whether the record gets Cloudflare's origin protection.

    Default is `false`.

  - [**`allow_overwrite`**](#attr-records-allow_overwrite): *(Optional `bool`)*<a name="attr-records-allow_overwrite"></a>

    Allow creation of this record in Terraform to overwrite an existing
    record, if any. This does not affect the ability to update the
    record in Terraform and does not prevent other resources within
    Terraform or manual changes outside Terraform from overwriting this
    record. Default configuration is not recommended for
    most environments.

    Default is `false`.

  - [**`data`**](#attr-records-data): *(Optional `object(data)`)*<a name="attr-records-data"></a>

    Map of attributes that constitute the record value. Primarily used
    for LOC and SRV record types. Either this or `value` must be
    specified.

    Default is `false`.

    The `data` object accepts the following attributes:

    - [**`service`**](#attr-records-data-service): *(Optional `string`)*<a name="attr-records-data-service"></a>

    - [**`proto`**](#attr-records-data-proto): *(Optional `string`)*<a name="attr-records-data-proto"></a>

    - [**`name`**](#attr-records-data-name): *(Optional `string`)*<a name="attr-records-data-name"></a>

    - [**`priority`**](#attr-records-data-priority): *(Optional `number`)*<a name="attr-records-data-priority"></a>

    - [**`weight`**](#attr-records-data-weight): *(Optional `number`)*<a name="attr-records-data-weight"></a>

    - [**`port`**](#attr-records-data-port): *(Optional `number`)*<a name="attr-records-data-port"></a>

    - [**`target`**](#attr-records-data-target): *(Optional `string`)*<a name="attr-records-data-target"></a>

- [**`dnssec_enabled`**](#var-dnssec_enabled): *(Optional `bool`)*<a name="var-dnssec_enabled"></a>

  Whether to enable DNSSEC for the zone.

  Default is `false`.

### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(Optional `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created.

  Default is `true`.

- [**`module_depends_on`**](#var-module_depends_on): *(Optional `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies.
  Any object can be _assigned_ to this list to define a hidden external dependency.

  Default is `[]`.

  Example:

  ```hcl
  module_depends_on = [
    null_resource.name
  ]
  ```

## Module Outputs

The following attributes are exported in the outputs of the module:

- [**`zone`**](#output-zone): *(`object(zone)`)*<a name="output-zone"></a>

  The `cloudflare_zone` resource object.

- [**`record`**](#output-record): *(`list(record)`)*<a name="output-record"></a>

  All `cloudflare_record` resource objects.

- [**`dnssec`**](#output-dnssec): *(`object(dnssec)`)*<a name="output-dnssec"></a>

  All DNSSEC details.

- [**`module_enabled`**](#output-module_enabled): *(`bool`)*<a name="output-module_enabled"></a>

  Whether this module is enabled.

## External Documentation

### Cloudfare Documentation

- DNS: https://developers.cloudflare.com/fundamentals/internet/protocols/dns
- Zone: https://www.cloudflare.com/en-gb/learning/dns/glossary/dns-zone/
- Records: https://www.cloudflare.com/en-gb/learning/dns/dns-records/
- DNSSEC: https://www.cloudflare.com/en-gb/dns/dnssec/how-dnssec-works/

### Terraform Cloudfare Provider Documentation

- Zone: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone
- Record: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record
- DNSSEC: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_dnssec

## Module Versioning

This Module follows the principles of [Semantic Versioning (SemVer)].

Given a version number `MAJOR.MINOR.PATCH`, we increment the:

1. `MAJOR` version when we make incompatible changes,
2. `MINOR` version when we add functionality in a backwards compatible manner, and
3. `PATCH` version when we make backwards compatible bug fixes.

### Backwards compatibility in `0.0.z` and `0.y.z` version

- Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
- Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)

## About Mineiros

[Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
that solves development, automation and security challenges in cloud infrastructure.

Our vision is to massively reduce time and overhead for teams to manage and
deploy production-grade and secure cloud infrastructure.

We offer commercial support for all of our modules and encourage you to reach out
if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
[Community Slack channel][slack].

## Reporting Issues

We use GitHub [Issues] to track community reported issues and missing features.

## Contributing

Contributions are always encouraged and welcome! For the process of accepting changes, we use
[Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].

## Makefile Targets

This repository comes with a handy [Makefile].
Run `make help` to see details on each available target.

## License

[![license][badge-license]][apache20]

This module is licensed under the Apache License Version 2.0, January 2004.
Please see [LICENSE] for full details.

Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]


<!-- References -->

[homepage]: https://mineiros.io/?ref=terraform-cloudflare-dns
[hello@mineiros.io]: mailto:hello@mineiros.io
[badge-license]: https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg
[releases-terraform]: https://github.com/hashicorp/terraform/releases
[releases-aws-provider]: https://github.com/terraform-providers/terraform-provider-aws/releases
[apache20]: https://opensource.org/licenses/Apache-2.0
[slack]: https://mineiros.io/slack
[terraform]: https://www.terraform.io
[aws]: https://aws.amazon.com/
[semantic versioning (semver)]: https://semver.org/
[variables.tf]: https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/variables.tf
[examples/]: https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/examples
[issues]: https://github.com/mineiros-io/terraform-cloudflare-dns/issues
[license]: https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/LICENSE
[makefile]: https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/Makefile
[pull requests]: https://github.com/mineiros-io/terraform-cloudflare-dns/pulls
[contribution guidelines]: https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/CONTRIBUTING.md
