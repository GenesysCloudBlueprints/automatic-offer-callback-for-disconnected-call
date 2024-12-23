/*
  Creates the action
*/
resource "genesyscloud_integration_action" "create_callback" {
  name                   = var.action_name
  category               = var.action_category
  integration_id         = var.integration_id
  contract_input = jsonencode({
    "type" = "object",
    "properties" = {
      "callbackNumber" = {
        "type" = "string"
      },
      "queueId" = {
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
    request_url_template = "/api/v2/conversations/callbacks"
    request_type         = "POST"
    request_template     = "{\"queueId\": \"$${input.queueId}\",\"callbackNumbers\": [\"$${input.callbackNumber}\"]}"
    headers = {}
  }
  config_response {
    translation_map = {}
    translation_map_defaults = {}
    success_template = "$${rawResult}"
  }
}
