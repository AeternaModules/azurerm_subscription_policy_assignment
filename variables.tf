variable "subscription_policy_assignments" {
  description = <<EOT
Map of subscription_policy_assignments, attributes below
Required:
    - name
    - policy_definition_id
    - subscription_id
Optional:
    - description
    - display_name
    - enforce
    - location
    - metadata
    - not_scopes
    - parameters
    - identity (block):
        - identity_ids (optional)
        - type (required)
    - non_compliance_message (block):
        - content (required)
        - policy_definition_reference_id (optional)
    - overrides (block):
        - selectors (optional, block):
            - in (optional)
            - kind (optional)
            - not_in (optional)
        - value (required)
    - resource_selectors (block):
        - name (optional)
        - selectors (required, block):
            - in (optional)
            - kind (required)
            - not_in (optional)
EOT

  type = map(object({
    name                 = string
    policy_definition_id = string
    subscription_id      = string
    description          = optional(string)
    display_name         = optional(string)
    enforce              = optional(bool) # Default: true
    location             = optional(string)
    metadata             = optional(string)
    not_scopes           = optional(list(string))
    parameters           = optional(string)
    identity = optional(object({
      identity_ids = optional(set(string))
      type         = string
    }))
    non_compliance_message = optional(object({
      content                        = string
      policy_definition_reference_id = optional(string)
    }))
    overrides = optional(object({
      selectors = optional(object({
        in     = optional(list(string))
        kind   = optional(string) # Default: "policyDefinitionReferenceId"
        not_in = optional(list(string))
      }))
      value = string
    }))
    resource_selectors = optional(object({
      name = optional(string)
      selectors = object({
        in     = optional(list(string))
        kind   = string
        not_in = optional(list(string))
      })
    }))
  }))
}

