local capabilities = require "st.capabilities"
local NUM_CAPA = capabilities["pilotgreen48610.varnum"]

local number_handlers = {}

--- Common Local Function ---
local function getInputValue(command)
    local inputValue = command.args.value
    if inputValue <= 0 then
        log.debug("YJ LOG: Input value error - Received value: %d", inputValue)
        inputValue = 1
    end
    return inputValue
end

local function getOldValue(command)
    return device:get_latest_state(
                     "main", NUM_CAPA.ID,
                       NUM_CAPA.numvalue.NAME
             )
end


local function applyValue(driver, device, value)
    device:emit_event(NUM_CAPA.numvalue(value))
end

--- Handler ---
function number_handlers.set(driver, device, command)
  local value = getInputValue(command)
  applyValue(driver, device, value)
end

function number_handlers.add(driver, device, command)
  local value = getInputValue(command) + getOldValue(command)
  applyValue(driver, device, value)
end

function number_handlers.minus(driver, device, command)
  local value = getInputValue(command) - getOldValue(command)
  applyValue(driver, device, value)
end

function number_handlers.multiply(driver, device, command)
    local value = getInputValue(command) * getOldValue(command)
    applyValue(driver, device, value)
end

function number_handlers.divide(driver, device, command)
    local value = getInputValue(command) * getOldValue(command)
    applyValue(driver, device, value)
end

return number_handlers
