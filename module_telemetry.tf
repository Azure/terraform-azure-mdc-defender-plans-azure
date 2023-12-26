resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name             = "this"
    avm_yor_trace            = "1c027ebf-9562-4860-a5a7-61fae225f66b"
    avm_git_commit           = "69d05159693e12ac793c78d0895784dc9f1c28e4"
    avm_git_file             = "module_telemetry.tf"
    avm_git_last_modified_at = "2023-11-07 08:53:40"
    avm_git_org              = "Azure"
    avm_git_repo             = "terraform-azure-mdc-defender-plans-azure"
  }
  ephemeral_number = 13797

  lifecycle {
    ignore_changes = [ephemeral_number]
  }
}
