/*
  Creates the action
*/
resource "genesyscloud_integration_action" "agentless_sms" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "fromAddress" = {
        "type" = "string"
      },
      "toAddress" = {
        "type" = "string"
      },
      "toAddressMessengerType" = {
        "type" = "string"
      },
      "textBody" = {
        "type" = "string"
      }
    }
  })
  contract_output = jsonencode({
    "type" = "object",
    "properties" = {}
  })
  config_request {
    # Use '$${' to indicate a literal '${' in template strings. Otherwise Terraform will attempt to interpolate the string
    # See https://www.terraform.io/docs/language/expressions/strings.html#escape-sequences
    request_url_template = "/api/v2/conversations/messages/agentless"
    request_type         = "POST"
    request_template     = "$${input.rawRequest}"
    headers = {}
  }
  config_response {
    translation_map = {}
    translation_map_defaults = {}
    success_template = "$${rawResult}"
  }
}
