
local meBridgeSide = 'back'
local postDataUrl = 'http://fb2.poissonnet.fr/minecraft/'


if peripheral.isPresent(meBridgeSide) and peripheral.getType(meBridgeSide) == "meBridge" then
  local meBridgeWrap = peripheral.wrap(meBridgeSide)
  local items = meBridgeWrap.listItems()
  local postStatus = http.post(postDataUrl, encode(items))
  if postStatus ~= nil then
    if postStatus.getResponseCode() == 200 then
      local response = postStatus.readAll()
      print("Respond : "..response)
    end
  else
    print("Connection to "..postDataUrl.." failed, server unaivalable.")
  end
end


