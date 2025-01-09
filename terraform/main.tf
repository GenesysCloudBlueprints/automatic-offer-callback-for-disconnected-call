// Create a Data Action integration
module "data_action" {
  source                          = "git::https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module?ref=main"
  integration_name                = "Send SMS to Schedule Callback"
  integration_creds_client_id     = var.client_id
  integration_creds_client_secret = var.client_secret
}

// Create an Agentless SMS Data Action
module "agentless_sms_data_action" {
  source             = "./modules/actions/agentless-sms"
  action_name        = "Agentless SMS"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Create a Create Callback Data Action
module "create_callback_data_action" {
  source             = "./modules/actions/create-callback"
  action_name        = "Create Callback"
  action_category    = "${module.data_action.integration_name}"
  integration_id     = "${module.data_action.integration_id}"
}

// Get Queue ID of callback queue
data "genesyscloud_routing_queue" "callback_queue" {
  name = var.callback_queue
}

// Configures the architect workflow and inbound call flow
module "archy_flow" {
  source                           = "./modules/flow"
  data_action_category             = module.data_action.integration_name
  agentless_sms_data_action_name   = module.agentless_sms_data_action.action_name
  create_callback_data_action_name = module.create_callback_data_action.action_name
  sms_number                       = var.sms_number
  callback_queue                   = data.genesyscloud_routing_queue.callback_queue.id
  sms_queue                        = var.sms_queue
  depends_on                       = [ module.data_action, module.agentless_sms_data_action, module.create_callback_data_action ]
}

// Create a Trigger
module "trigger" {
  source       = "./modules/trigger"
  workflow_id  = module.archy_flow.flow_id
  dnis         = var.dnis
  depends_on   = [ module.archy_flow ]
}
