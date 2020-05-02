variable "loc" {
    description = "Default Azure region"
    default     =   "westeurope"
}

variable "webapplocs" {
    type = "list"
    default = ["eastus2", "uksouth", "centralindia"]
}

variable "tags" {
    default     = {
        source  = "citadel"
        env     = "training"
    }
}