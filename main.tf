resource "azurerm_subscription_policy_assignment" "subscription_policy_assignments" {
  for_each = var.subscription_policy_assignments

  name                 = each.value.name
  policy_definition_id = each.value.policy_definition_id
  subscription_id      = each.value.subscription_id
  description          = each.value.description
  display_name         = each.value.display_name
  enforce              = each.value.enforce
  location             = each.value.location
  metadata             = each.value.metadata
  not_scopes           = each.value.not_scopes
  parameters           = each.value.parameters

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      identity_ids = identity.value.identity_ids
      type         = identity.value.type
    }
  }

  dynamic "non_compliance_message" {
    for_each = each.value.non_compliance_message != null ? [each.value.non_compliance_message] : []
    content {
      content                        = non_compliance_message.value.content
      policy_definition_reference_id = non_compliance_message.value.policy_definition_reference_id
    }
  }

  dynamic "overrides" {
    for_each = each.value.overrides != null ? [each.value.overrides] : []
    content {
      dynamic "selectors" {
        for_each = overrides.value.selectors != null ? [overrides.value.selectors] : []
        content {
          in     = selectors.value.in
          kind   = selectors.value.kind
          not_in = selectors.value.not_in
        }
      }
      value = overrides.value.value
    }
  }

  dynamic "resource_selectors" {
    for_each = each.value.resource_selectors != null ? [each.value.resource_selectors] : []
    content {
      name = resource_selectors.value.name
      selectors {
        in     = resource_selectors.value.selectors.in
        kind   = resource_selectors.value.selectors.kind
        not_in = resource_selectors.value.selectors.not_in
      }
    }
  }
}

