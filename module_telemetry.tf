resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "f3833498-1ea8-47c0-8c27-71068b3da240"
    avm_git_commit           = "a8af972a8b2716463bdb957f89f5468cd60b6290"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-11-07 06:29:56"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  nonce = 27536

  lifecycle {
    ignore_changes = [nonce]
  }
}
