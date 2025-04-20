local length = 50        
local torchInterval = 10 


function digForward()
  while turtle.detect() do
    turtle.dig()
    sleep(0.5)
  end
end


function digUp()
  while turtle.detectUp() do
    turtle.digUp()
    sleep(0.5)
  end
end


function forward()
  while not turtle.forward() do
    digForward()
    sleep(0.5)
  end
end


function placeTorch()
  for i = 1, 16 do
    local item = turtle.getItemDetail(i)
    if item and item.name and item.name:find("torch") then
      turtle.select(i)
      turtle.placeDown()
      return true
    end
  end
  return false
end


for i = 1, length do
  digForward()
  digUp()
  turtle.digDown()
  forward()


  if i % torchInterval == 0 then
    turtle.turnLeft()
    turtle.turnLeft()
    placeTorch()
    turtle.turnLeft()
    turtle.turnLeft()
  end
end

print("Bányászás kész! (" .. length .. " blokk)")
