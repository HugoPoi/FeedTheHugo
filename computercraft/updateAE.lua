local meBridgeSide = 'back'
local postDataUrl = 'http://fb2.poissonnet.fr/minecraft/'

local JSON = (loadfile "jsonpurlua")()

if peripheral.isPresent(meBridgeSide) and peripheral.getType(meBridgeSide) == "meBridge" then
  local meBridgeWrap = peripheral.wrap(meBridgeSide)
  local items = meBridgeWrap.listItems()
  local count = 0
  local export = {}
  for i,d in pairs(items) do
      export[""..i] = d
  end
  local jsondata = JSON:encode(export)
  local postStatus = http.post(postDataUrl, jsondata)
  if postStatus ~= nil then
    if postStatus.getResponseCode() == 200 then
      local response = postStatus.readAll()
      print("Respond : "..response)
    end
  else
    print("Connection to "..postDataUrl.." failed, server unaivalable.")
  end
end

