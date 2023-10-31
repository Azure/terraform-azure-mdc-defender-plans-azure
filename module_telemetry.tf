resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "b1201aa4-c4f4-45c2-b4a2-7146be57d538"
    avm_git_commit           = "032f48cbcb5fe1dd47893fb6f62d14a4e32f4c73"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-10-31 13:00:44"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  nonce = 27270

  lifecycle {
    ignore_changes = [nonce]
  }
}
