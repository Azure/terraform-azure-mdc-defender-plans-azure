resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "74109ab9-0eb8-4c79-9c6b-219d4fba3f4b"
    avm_git_commit           = "26baebe7d43148261be970e78864835bf9cd8cd3"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-10-31 13:33:00"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  nonce = 25005

  lifecycle {
    ignore_changes = [nonce]
  }
}
