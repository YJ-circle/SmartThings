local capabilities = require "st.capabilities"
local log = require "log"


local SEL_CAPA = capabilities["pilotgreen48610.varselector"]

local add_devices = {}

---common function ---
local function applyValue(driver, device, value)
  device:emit_event(SEL_CAPA.select(value))
end

local function getDeviceCount(driver, device)
    local device_count = device:get_field("count")
    if device_count == nil then
        device_count = 0
        log.debug("YJ LOG: device_count field Nil")
        for _, dev in ipairs(driver:get_devices()) do
        device_count = device_count + 1
        end
    end
    
    return device_count + 1
end
 ----
function add_devices.select(driver, device, command)
    local commandValue = command.args.setSelectVar
    applyValue(drive, device, commandValue)
end

function add_devices.add(driver, device, command)
  local select = device:get_latest_state(
                     "main", SEL_CAPA.ID,
                       SEL_CAPA.select.NAME
             )
   if select == "number" then
    add_devices.addNumDevices(driver, device)
   end
   
   if select == "string" then
    --addStrDevices(driver, deviceCount)
   end
end



function add_devices.addNumDevices(driver, device)
    local success = false
    local tryCount = 0;
    local deviceCount = getDeviceCount(driver, device)
    local metadata = {
          type = "EDGE_CHILD",
          parent_assigned_child_key = "YJ-Variable-Device-" .. os.time(),
          label = "NewVarDevice",
          profile = "variableNumber",
          parent_device_id = device.id,
          manufacturer = "YJ",
          model = "v1",
     }
    _, result = pcall(driver.try_create_device, driver, metadata)
    log.info("Device created result: " .. tostring(result))
end

local function addStrDevices(driver, deviceCount)
    local success = false
    local tryCount = 0;
    while not success do
        if tryCount == 10 then
            log.debug("Failed Added.." ..tryCount)
            break
        end
        local metadata = {
            type = "LAN",
            device_network_id = "YJ-Variable-Device-" .. deviceCount,
            label = "VarDevice" .. deviceCount,
            profile = "variableNumber",
            manufacturer = "YJ",
            model = "v1",
            vendor_provided_label = nil
        }
        success = driver:try_create_device(metadata)

        if not success then
            deviceCount = deviceCount + 1 
            tryCount = tryCount + 1
        end
    end
end

return add_devices
