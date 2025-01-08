resource "genesyscloud_flow" "workflow" {
  filepath = "${path.module}/Send SMS to Schedule Callback.yaml"
  file_content_hash = filesha256("${path.module}/Send SMS to Schedule Callback.yaml")
  substitutions = {
    flow_name                      = "Send SMS to Schedule Callback"
    division                       = "Home"
    default_language               = "en-us"
    data_action_category           = var.data_action_category
    agentless_sms_data_action_name = var.agentless_sms_data_action_name
    sms_number                     = var.sms_number
  }
}

resource "genesyscloud_flow" "inbound_call_flow" {
  filepath = "${path.module}/SMS Schedule Callback.yaml"
  file_content_hash = filesha256("${path.module}/SMS Schedule Callback.yaml")
  substitutions = {
    flow_name                        = "SMS Schedule Callback"
    division                         = "Home"
    default_language                 = "en-us"
    data_action_category             = var.data_action_category
    create_callback_data_action_name = var.create_callback_data_action_name
  }
}