locals {
  base_tags = {
    Client          = var.client_name
    Environment     = var.environment
    Region          = var.aws_region
    Account         = data.aws_caller_identity.current.account_id
    Provisioning    = var.provisioning
    DefconLevel     = var.defcon_level
    PropagateLaunch = var.propagate_at_launch
  }
}
