resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "c5b4b73f-f367-4176-8062-b925970d4cd5"
    avm_git_commit           = "0e50c8c119a1c59481ea25aa0375c04dca75f91d"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-10-30 10:08:34"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  nonce = 5983

  lifecycle {
    ignore_changes = [nonce]
  }
}
