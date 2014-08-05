-- Screen library 0.1 for ComputerCraft

FTHScreen = {}

FTHScreen:Screen = {composants = {}}

function FTHScreen:Screen:new(side,bg)
  local o = {}
  self['side'] = side
  self['monitor'] = peripheral.wrap(side)
  self.monitor.setBackgroundColor(bg or colors.black)
  self.monitor.clear()

  setmetatable(o, self)
  self.__index = self
  return o
end

function FTHScreen:Screen:addComposant(composant,name)
  composant.attachToMonitor(self.monitor)
  self.composants[name] = composant
end

function FTHScreen:Screen:draw()
  for id,co in pairs(self.composants) do
    co.draw()
  end
end

function FTHScreen:Screen:touchEvent(side,x,y)
  if side == self.side then
    
  end
end

function FTHScreen:Screen:newButton(_text,_bg,_color)

  local ob = self.Composant(_width,_height,_x,_y,{text = _text, bg = _bg, color = _color})

  ob.draw = function()
    self.monitor.setBackgroundColor(self.bg)
    self.monitor.setTextColor(self.color)
    for i=0, self.height-1 do
      local str = ""
      for j = 0, self.width-1 do
        str = str .. " "
      end
      self.monitor.setCursorPos(self.x, self.y + i)
      self.monitor.write(str)
    end
    self.monitor.setCursorPos(math.ceil((self.x+self.x+self.width)/2)-math.ceil(#self.text/2), math.floor((self.y+self.y+self.height)/2))
    self.monitor.write(self.text)
  end

  return ob
end

function FTHScreen:Screen:newGauge(_width,_height,_x,_y,_bgColor,_shapeColor,_contentColor)

  local og = self.Composant(_width,_height,_x,_y,{level = 0, bgColor = _bgColor,shapeColor = _shapeColor, contentColor = _contentColor})
  
  og.draw = function()
    for i=self.height-1,0,-1  do
      self.monitor.setCursorPos(self.x, self.y + i)
      self.monitor.setBackgroundColor(self.shapeColor)
      self.monitor.write(" ")
      local str = ""
      for j = 0, self.width-2 do
        str = str .. " "
      end
      if i ~= self.height-1 and i ~= 0 then
        if ((self.height-i)/self.height)<=self.level then self.monitor.setBackgroundColor(self.contentColor)
        else self.monitor.setBackgroundColor(self.bgColor) end
      else self.monitor.setBackgroundColor(self.shapeColor) end
      self.monitor.write(str)
      self.monitor.setBackgroundColor(self.shapeColor)
      self.monitor.write(" ")
    end
  end

  return og
end

function FTHScreen:Screen:Composant(_width,_height,_x,_y,properties)
  local oc = {
    monitor = self.monitor,
    width = _width,
    height = _height,
    x = _x,
    y = _y
  }
  setmetatable(properties, oc)
  oc.__index = oc
  return properties
end

FTHScreen.__index = FTHScreen

function FTHScreen:new()
  local new = {}
  return setmetatable(new,FTHScreen)
end

return FTHScreen:new()
