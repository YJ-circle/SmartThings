
--- Import Libarary -- -
local capabilities = require "st.capabilities"
local Driver = require "st.driver"
local log = require "log"

--- Import Sub Files ---
local discovery = require "discovery"
local number_handlers = require "number_handlers"
local add_devices = require "add_devices"
local NUM_CAPA = capabilities["pilotgreen48610.varnum"]
local SEL_CAPA = capabilities["pilotgreen48610.varselector"]


--- default function ---
local function device_added(driver, device)
  log.debug("YJ LOG: Add device")
  device:emit_event(SEL_CAPA.select("number"))
end

local function device_init(driver, device)
  log.debug("YJ LOG: Initializing device")
  device:online()
end

local function device_removed(driver, device)
  log.debug("YJ LOG: Remove device")
end

local VariableEdge_driver = Driver("VariableEdge", {
  discovery = discovery.handle_discovery,
  lifecycle_handlers = {
    added = device_added,
    init = device_init,
    removed = device_removed
  },
  capability_handlers = {
    [NUM_CAPA.ID] = {
      [NUM_CAPA.commands.set.NAME] = number_handlers.add,
      [NUM_CAPA.commands.add.NAME] = number_handlers.minus,
      [NUM_CAPA.commands.minus.NAME] = number_handlers.minus,
      [NUM_CAPA.commands.multiply.NAME] = number_handlers.multiply,
      [NUM_CAPA.commands.divide.NAME] = number_handlers.divide,
    },
    [SEL_CAPA.ID] = {
      [SEL_CAPA.commands.setSelectVar.NAME] = add_devices.select,
    },
    [capabilities.momentary.ID] = {
        [capabilities.momentary.commands.push.NAME] = add_devices.add,
    }
    
    
  }
})

VariableEdge_driver:run()
