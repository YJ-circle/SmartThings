local log = require "log"
local discovery = {}
local capabilities = require "st.capabilities"
local SEL_CAPA = capabilities["pilotgreen48610.varselector"]

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
   local add_device = driver:try_create_device(metadata)
   
    if add_device then
       
        log.debug(add_device)
    else
        log.debug("Failed to create device")
    end
end

return discovery
