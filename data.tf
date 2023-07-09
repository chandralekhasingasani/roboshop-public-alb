data "dns_a_record_set" "frontend" {
  host = "frontend-${var.ENV}.roboshop.internal"
}

locals {
  FRONTEND_ALB_IP = data.dns_a_record_set.frontend.addrs
}