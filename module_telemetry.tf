resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "2dd84119-7d9d-4a88-af90-3baedb46b0bf"
    avm_git_commit           = "e46eb8e8fcbe61904874eaf8b5de94c9e5f2a5c8"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-11-06 14:13:21"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  nonce = 27536

  lifecycle {
    ignore_changes = [nonce]
  }
}
