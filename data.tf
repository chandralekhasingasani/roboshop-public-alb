data "dns_a_record_set" "frontend" {
  host = "frontend-{{COMPONENT}}.roboshop.internal"
}

locals {
  FRONTEND_ALB_IP = data.dns_a_record_set.frontend.addrs
}