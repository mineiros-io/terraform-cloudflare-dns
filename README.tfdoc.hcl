header {
  image = "https://raw.githubusercontent.com/mineiros-io/brand/3bffd30e8bdbbde32c143e2650b2faa55f1df3ea/mineiros-primary-logo.svg"
  url   = "https://mineiros.io/?ref=terraform-cloudflare-dns"

  badge "build" {
    image = "https://github.com/mineiros-io/terraform-cloudflare-dns/workflows/Tests/badge.svg"
    url   = "https://github.com/mineiros-io/terraform-cloudflare-dns/actions"
    text  = "Build Status"
  }

  badge "semver" {
    image = "https://img.shields.io/github/v/tag/mineiros-io/terraform-cloudflare-dns.svg?label=latest&sort=semver"
    url   = "https://github.com/mineiros-io/terraform-cloudflare-dns/releases"
    text  = "GitHub tag (latest SemVer)"
  }

  badge "terraform" {
    image = "https://img.shields.io/badge/terraform-0.14.7+%20|%202-623CE4.svg?logo=terraform"
    url   = "https://github.com/hashicorp/terraform/releases"
    text  = "Terraform Version"
  }

  badge "slack" {
    image = "https://img.shields.io/badge/slack-@mineiros--community-f32752.svg?logo=slack"
    url   = "https://mineiros.io/slack"
    text  = "Join Slack"
  }
}

section {
  title   = "terraform-cloudflare-dns"
  toc     = true
  content = <<-END
    A [Terraform] module for creating and managing a 
    [DNS Cloudfare](https://developers.cloudflare.com/fundamentals/internet/protocols/dns)
    resource.

    **_This module supports Terraform version 0.14.7 up to (not including) version 2.0
    and is compatible with the Terraform Cloudfare Provider version 3**

    This module is part of our Infrastructure as Code (IaC) framework
    that enables our users and customers to easily deploy and manage reusable,
    secure, and production-grade cloud infrastructure.
  END

  section {
    title   = "Module Features"
    content = <<-END
      This module implements the following Terraform resources

      - `cloudflare_zone`
      - `cloudflare_record`
      - `cloudflare_zone_dnssec`
    END
  }

  section {
    title   = "Getting Started"
    content = <<-END
      Most common usage of the module:

      ```hcl
      module "terraform-cloudflare-dns" {
        source = "git@github.com:mineiros-io/terraform-cloudflare-dns.git?ref=v0.1.0"
      }
      ```
    END
  }

  section {
    title   = "Module Argument Reference"
    content = <<-END
      See [variables.tf] and [examples/] for details and use-cases.
    END

    section {
      title = "Main Resource Configuration"

      variable "zone" {
        required    = true
        type        = string
        description = <<-END
          Account ID to manage the zone resource in.
        END
      }

      variable "zone" {
        required    = true
        type        = string
        description = <<-END
          The DNS zone name which will be added.
        END
      }

      variable "paused" {
        type        = bool
        default     = false
        description = <<-END
          Boolean of whether this zone is paused (traffic bypasses Cloudflare).
        END
      }

      variable "jump_start" {
        type        = bool
        default     = false
        description = <<-END
          Boolean of whether to scan for DNS records on creation. Ignored after
          zone is created.
        END
      }

      variable "plan" {
        type        = string
        default     = "free"
        description = <<-END
          The name of the commercial plan to apply to the zone, can be updated
          once the zone is created; one of free, pro, business, enterprise.
        END
      }

      variable "type" {
        type        = string
        default     = "full"
        description = <<-END
          A full zone implies that DNS is hosted with Cloudflare. A partial zone
          is typically a partner-hosted zone or a CNAME setup. Valid values:
          full, partial.
        END
      }
    }

    section {
      title = "Extended Resource Configuration"

      variable "records" {
        type        = list(record)
        default     = []
        description = <<-END
          A list of DNS records.
        END

        attribute "name" {
          required    = true
          type        = string
          description = <<-END
            The name of the record.
          END
        }

        attribute "type" {
          required    = true
          type        = string
          description = <<-END
            The type of the record
          END
        }

        attribute "value" {
          type        = string
          description = <<-END
            The value of the record. Either this or `data` must be
            specified
          END
        }

        attribute "ttl" {
          type        = number
          description = <<-END
            The TTL of the record ([automatic: '1'](https://api.cloudflare.com/#getting-started-endpoints))
          END
        }

        attribute "comment" {
          type        = string
          description = <<-END
            Comments or notes about the DNS record. This field has no effect on DNS responses.
          END
        }

        attribute "priority" {
          type        = number
          description = <<-END
            The priority of the record
          END
        }

        attribute "proxied" {
          type        = bool
          default     = false
          description = <<-END
            Whether the record gets Cloudflare's origin protection.
          END
        }

        attribute "allow_overwrite" {
          type        = bool
          default     = false
          description = <<-END
            Allow creation of this record in Terraform to overwrite an existing
            record, if any. This does not affect the ability to update the
            record in Terraform and does not prevent other resources within
            Terraform or manual changes outside Terraform from overwriting this
            record. Default configuration is not recommended for
            most environments.
          END
        }

        attribute "data" {
          type        = object(data)
          default     = false
          description = <<-END
            Map of attributes that constitute the record value. Primarily used
            for LOC and SRV record types. Either this or `value` must be
            specified.
          END

          attribute "service" {
            type = string
          }

          attribute "proto" {
            type = string
          }

          attribute "name" {
            type = string
          }

          attribute "priority" {
            type = number
          }

          attribute "weight" {
            type = number
          }

          attribute "port" {
            type = number
          }

          attribute "target" {
            type = string
          }
        }
      }

      variable "dnssec_enabled" {
        type        = bool
        default     = false
        description = <<-END
          Whether to enable DNSSEC for the zone.
        END
      }
    }

    section {
      title = "Module Configuration"

      variable "module_enabled" {
        type        = bool
        default     = true
        description = <<-END
          Specifies whether resources in the module will be created.
        END
      }

      variable "module_depends_on" {
        type           = list(dependency)
        description    = <<-END
          A list of dependencies.
          Any object can be _assigned_ to this list to define a hidden external dependency.
        END
        default        = []
        readme_example = <<-END
          module_depends_on = [
            null_resource.name
          ]
        END
      }
    }
  }

  section {
    title   = "Module Outputs"
    content = <<-END
      The following attributes are exported in the outputs of the module:
    END

    output "zone" {
      type        = object(zone)
      description = <<-END
        The `cloudflare_zone` resource object.
      END
    }

    output "record" {
      type        = list(record)
      description = <<-END
        All `cloudflare_record` resource objects.
      END
    }

    output "dnssec" {
      type        = object(dnssec)
      description = <<-END
        All DNSSEC details.
      END
    }

    output "module_enabled" {
      type        = bool
      description = <<-END
        Whether this module is enabled.
      END
    }
  }

  section {
    title = "External Documentation"

    section {
      title   = "Cloudfare Documentation"
      content = <<-END
        - DNS: https://developers.cloudflare.com/fundamentals/internet/protocols/dns
        - Zone: https://www.cloudflare.com/en-gb/learning/dns/glossary/dns-zone/
        - Records: https://www.cloudflare.com/en-gb/learning/dns/dns-records/
        - DNSSEC: https://www.cloudflare.com/en-gb/dns/dnssec/how-dnssec-works/
      END
    }

    section {
      title   = "Terraform Cloudfare Provider Documentation"
      content = <<-END
        - Zone: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone
        - Record: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record
        - DNSSEC: https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_dnssec
      END
    }
  }

  section {
    title   = "Module Versioning"
    content = <<-END
      This Module follows the principles of [Semantic Versioning (SemVer)].

      Given a version number `MAJOR.MINOR.PATCH`, we increment the:

      1. `MAJOR` version when we make incompatible changes,
      2. `MINOR` version when we add functionality in a backwards compatible manner, and
      3. `PATCH` version when we make backwards compatible bug fixes.
    END

    section {
      title   = "Backwards compatibility in `0.0.z` and `0.y.z` version"
      content = <<-END
        - Backwards compatibility in versions `0.0.z` is **not guaranteed** when `z` is increased. (Initial development)
        - Backwards compatibility in versions `0.y.z` is **not guaranteed** when `y` is increased. (Pre-release)
      END
    }
  }

  section {
    title   = "About Mineiros"
    content = <<-END
      [Mineiros][homepage] is a remote-first company headquartered in Berlin, Germany
      that solves development, automation and security challenges in cloud infrastructure.

      Our vision is to massively reduce time and overhead for teams to manage and
      deploy production-grade and secure cloud infrastructure.

      We offer commercial support for all of our modules and encourage you to reach out
      if you have any questions or need help. Feel free to email us at [hello@mineiros.io] or join our
      [Community Slack channel][slack].
    END
  }

  section {
    title   = "Reporting Issues"
    content = <<-END
      We use GitHub [Issues] to track community reported issues and missing features.
    END
  }

  section {
    title   = "Contributing"
    content = <<-END
      Contributions are always encouraged and welcome! For the process of accepting changes, we use
      [Pull Requests]. If you'd like more information, please see our [Contribution Guidelines].
    END
  }

  section {
    title   = "Makefile Targets"
    content = <<-END
      This repository comes with a handy [Makefile].
      Run `make help` to see details on each available target.
    END
  }

  section {
    title   = "License"
    content = <<-END
      [![license][badge-license]][apache20]

      This module is licensed under the Apache License Version 2.0, January 2004.
      Please see [LICENSE] for full details.

      Copyright &copy; 2020-2022 [Mineiros GmbH][homepage]
    END
  }
}

references {
  ref "homepage" {
    value = "https://mineiros.io/?ref=terraform-cloudflare-dns"
  }
  ref "hello@mineiros.io" {
    value = " mailto:hello@mineiros.io"
  }
  ref "badge-license" {
    value = "https://img.shields.io/badge/license-Apache%202.0-brightgreen.svg"
  }
  ref "releases-terraform" {
    value = "https://github.com/hashicorp/terraform/releases"
  }
  ref "releases-aws-provider" {
    value = "https://github.com/terraform-providers/terraform-provider-aws/releases"
  }
  ref "apache20" {
    value = "https://opensource.org/licenses/Apache-2.0"
  }
  ref "slack" {
    value = "https://mineiros.io/slack"
  }
  ref "terraform" {
    value = "https://www.terraform.io"
  }
  ref "aws" {
    value = "https://aws.amazon.com/"
  }
  ref "semantic versioning (semver)" {
    value = "https://semver.org/"
  }
  ref "variables.tf" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/variables.tf"
  }
  ref "examples/" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/examples"
  }
  ref "issues" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-dns/issues"
  }
  ref "license" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/LICENSE"
  }
  ref "makefile" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/Makefile"
  }
  ref "pull requests" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-dns/pulls"
  }
  ref "contribution guidelines" {
    value = "https://github.com/mineiros-io/terraform-cloudflare-dns/blob/main/CONTRIBUTING.md"
  }
}
