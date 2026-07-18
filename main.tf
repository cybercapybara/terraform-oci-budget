resource "oci_budget_budget" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  description    = var.description

  target_type = "COMPARTMENT"
  targets     = [var.target_compartment_id]

  amount       = var.amount
  reset_period = var.reset_period

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}

resource "oci_budget_alert_rule" "this" {
  count = length(var.alert_rules)

  budget_id      = oci_budget_budget.this.id
  type           = var.alert_rules[count.index].type
  threshold      = var.alert_rules[count.index].threshold
  threshold_type = var.alert_rules[count.index].threshold_type
  recipients     = var.alert_rules[count.index].recipients
  message        = var.alert_rules[count.index].message
}
