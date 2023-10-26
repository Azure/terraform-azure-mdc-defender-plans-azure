resource "modtm_telemetry" "this" {
  tags = {
    avm_yor_name  = "this"
    avm_yor_trace = "b7642d6f-c1b3-45da-8837-9a64e8b7396e"
  }

  lifecycle {
    ignore_changes = [nonce]
  }
}
