resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "e152a86b-fbd1-40bc-90d4-e123ca52077c"
    avm_git_commit           = "9334bbe30a8a837be71aba9a8a34939abea0840f"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-11-07 07:39:26"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  nonce = 27263

  lifecycle {
    ignore_changes = [nonce]
  }
}
