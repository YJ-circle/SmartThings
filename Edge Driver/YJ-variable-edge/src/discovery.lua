local discovery = {}

function discovery.handle_discovery(driver, _should_continue)
  local metadata = {
    type = "LAN",
    device_network_id = "YJ-Variable-Device-Main",
    label = "Variable Hub",
    profile = "variableHub",
    manufacturer = "YJ",
    model = "v1",
    vendor_provided_label = nil
  }

  -- tell the cloud to create a new device record, will get synced back down
  -- and `device_added` and `device_init` callbacks will be called
  driver:try_create_device(metadata)
end

return discovery
