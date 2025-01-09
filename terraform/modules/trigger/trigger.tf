resource "genesyscloud_processautomation_trigger" "trigger" {
  name       = "Disconnected Call Trigger"
  topic_name = "v2.detail.events.conversation.{id}.customer.end"
  enabled    = true
  target {
    id   = var.workflow_id
    type = "Workflow"
    workflow_target_settings {
      data_format = "TopLevelPrimitives"
    }
  }
  match_criteria = jsonencode([
    {
      "jsonPath" : "mediaType",
      "operator" : "Equal",
      "value" : "VOICE"
    },
    {
      "jsonPath" : "disconnectType",
      "operator" : "In",
      "values" : ["UNKNOWN","SYSTEM","ERROR","OTHER","TIMEOUT","TRANSPORT_FAILURE","UNCALLABLE"]
    },
    {
      "jsonPath" : "dnis",
      "operator" : "In",
      "values" : ["${var.dnis}"]
    }
  ])
  event_ttl_seconds = 60
}