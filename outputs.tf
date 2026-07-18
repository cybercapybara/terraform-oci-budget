output "id" {
  description = "OCID of the budget."
  value       = oci_budget_budget.this.id
}

output "display_name" {
  description = "Display name of the budget."
  value       = oci_budget_budget.this.display_name
}

output "amount" {
  description = "Budget amount in the tenancy currency."
  value       = oci_budget_budget.this.amount
}

output "alert_rule_ids" {
  description = "OCIDs of the alert rules attached to the budget."
  value       = oci_budget_alert_rule.this[*].id
}

output "state" {
  description = "Lifecycle state of the budget."
  value       = oci_budget_budget.this.state
}
