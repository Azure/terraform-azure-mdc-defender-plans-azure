resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "a2b13fdb-ad4b-45f9-80e4-8143a454867a"
    avm_git_commit           = "e3df5d1758708a83159dac00579a41934277520a"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-12-26 09:26:37"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  ephemeral_number = 10256

  lifecycle {
    ignore_changes = [ephemeral_number]
  }
}
