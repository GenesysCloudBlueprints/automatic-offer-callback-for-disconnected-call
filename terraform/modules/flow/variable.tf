
variable "data_action_category" {
  type        = string
  description = "The Data Action that is to be used in the Inbound Call Flow."
}

variable "agentless_sms_data_action_name" {
  type        = string
  description = "The Data Action name that is to be used in the Inbound Call Flow."
}

variable "create_callback_data_action_name" {
  type        = string
  description = "The Data Action name that is to be used in the Inbound Call Flow."
}

variable "sms_number" {
  type        = string
  description = "Purchased SMS number with the format `+11234567890`"
}

variable "callback_queue" {
  type        = string
  description = "The name of your configured queue for handling callbacks."
}

variable "sms_queue" {
  type        = string
  description = "The name of your configured queue for accepting SMS interactions."
}