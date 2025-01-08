variable "client_id" {
  type        = string
  description = "The OAuth (Client Credentails) Client ID to be used by Data Actions"
}

variable "client_secret" {
  type        = string
  description = "The OAuth (Client Credentails) Client Secret to be used by Data Actions"
}

variable "dnis" {
  type        = string
  description = "Add your configured DID Number with the format `tel:+11234567890`"
}

variable "sms_number" {
  type        = string
  description = "Add your purchased SMS number with the format `+11234567890`"
}