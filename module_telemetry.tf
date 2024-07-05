resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "d4540867-988f-4a6c-bfaf-4b57091c5f7f"
    avm_git_commit           = "743563eb889849537ebfcfefd459954e5a7e2908"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-12-26 10:10:45"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  ephemeral_number = 12264

  lifecycle {
    ignore_changes = [ephemeral_number]
  }
}
