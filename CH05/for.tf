variable "names" {
  description = "A list of names"
  type        = list(string)
  default     = ["JANG", "HUN", "LEE"]
}

output "lower_names" {
  value = [for name in var.names : lower(name)]
}
