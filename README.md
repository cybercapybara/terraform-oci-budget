# terraform-oci-budget

Terraform module that manages an [Oracle Cloud Infrastructure](https://www.oracle.com/cloud/)
Budget that tracks spend for a target compartment, along with any number of alert rules
that email recipients when actual or forecast spend crosses a threshold.

## Usage

```hcl
module "budget" {
  source = "github.com/moveeeax/terraform-oci-budget"

  compartment_id        = var.tenancy_id
  display_name          = "prod-budget"
  target_compartment_id = var.prod_compartment_id
  amount                = 5000

  alert_rules = [
    {
      threshold  = 90
      recipients = "finops@example.com"
    }
  ]

  freeform_tags = {
    Environment = "production"
    ManagedBy   = "terraform"
  }
}
```

A runnable example lives in [`examples/basic`](examples/basic).

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.5   |
| oci       | >= 5.0   |

## Inputs

| Name                    | Description                                                        | Type                | Default     | Required |
|-------------------------|--------------------------------------------------------------------|---------------------|-------------|:--------:|
| `compartment_id`        | OCID of the compartment (tenancy) in which to create the budget.   | `string`            | n/a         |   yes    |
| `display_name`          | Human-readable name for the budget.                               | `string`            | n/a         |   yes    |
| `description`           | Description of the budget.                                         | `string`            | `null`      |    no    |
| `target_compartment_id` | OCID of the compartment the budget tracks spend for.              | `string`            | n/a         |   yes    |
| `amount`                | Budget amount in the tenancy currency.                            | `number`            | n/a         |   yes    |
| `reset_period`          | How often the budget resets.                                      | `string`            | `"MONTHLY"` |    no    |
| `alert_rules`           | Alert rules notifying recipients on threshold crossings.          | `list(object(...))` | `[]`        |    no    |
| `freeform_tags`         | Free-form tags applied to the budget.                             | `map(string)`       | `{}`        |    no    |
| `defined_tags`          | Defined tags applied to the budget, keyed `namespace.key`.        | `map(string)`       | `{}`        |    no    |

## Outputs

| Name             | Description                                     |
|------------------|-------------------------------------------------|
| `id`             | OCID of the budget.                             |
| `display_name`   | Display name of the budget.                     |
| `amount`         | Budget amount in the tenancy currency.          |
| `alert_rule_ids` | OCIDs of the alert rules attached to the budget.|
| `state`          | Lifecycle state of the budget.                  |

## License

[MIT](LICENSE)
