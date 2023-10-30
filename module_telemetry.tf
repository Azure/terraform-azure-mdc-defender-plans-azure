resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "e2169699-18c4-453e-b6a9-27bd218c50bb"
    avm_git_commit           = "339c764ce0f496e384f49628c70b002d6d93a6b7"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-10-26 10:49:51"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  nonce = 5983

  lifecycle {
    ignore_changes = [nonce]
  }
}
