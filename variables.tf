variable "id" {
  type = string

  default = ""
}

variable "name" {
  type = string
}

variable "repository_name" {
  type = string
}

variable "groups" {
  type = list(string)
}

variable "labels" {
  type = list(string)

  default = [
  ]
}

variable "host" {
  type = string
}

variable "user" {
  type = string
}

variable "private_key" {
  type = string
}
