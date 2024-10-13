local capabilities = require "st.capabilities"
local security = require "st.security"

local command_handlers = {}

-- callback to handle an `on` capability command
function command_handlers.switch_on(driver, device, command)
  device:emit_event(capabilities.switch.switch.on())
end

-- callback to handle an `off` capability command
function command_handlers.switch_off(driver, device, command)
  
  device:emit_event(capabilities.switch.switch.off())
end

return command_handlers
