variable "compartment_id" {
  description = "OCID of the compartment (tenancy) in which to create the budget."
  type        = string
}

variable "display_name" {
  description = "Human-readable name for the budget."
  type        = string
}

variable "description" {
  description = "Description of the budget."
  type        = string
  default     = null
}

variable "target_compartment_id" {
  description = "OCID of the compartment the budget tracks spend for."
  type        = string
}

variable "amount" {
  description = "Budget amount in the tenancy currency."
  type        = number

  validation {
    condition     = var.amount > 0
    error_message = "amount must be greater than zero."
  }
}

variable "reset_period" {
  description = "How often the budget resets."
  type        = string
  default     = "MONTHLY"

  validation {
    condition     = contains(["MONTHLY"], var.reset_period)
    error_message = "reset_period must be MONTHLY."
  }
}

variable "alert_rules" {
  description = "List of alert rules that notify recipients when thresholds are crossed."
  type = list(object({
    threshold      = number
    threshold_type = optional(string, "PERCENTAGE")
    type           = optional(string, "ACTUAL")
    recipients     = string
    message        = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for r in var.alert_rules : contains(["PERCENTAGE", "ABSOLUTE"], r.threshold_type)
    ])
    error_message = "alert_rules[*].threshold_type must be PERCENTAGE or ABSOLUTE."
  }
}

variable "freeform_tags" {
  description = "Free-form tags applied to the budget."
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "Defined tags applied to the budget, keyed as \"namespace.key\"."
  type        = map(string)
  default     = {}
}
