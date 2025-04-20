

local length = 50          
local torchInterval = 10    
local minFuel = length * 2   




function checkFuel()
  if turtle.getFuelLevel() == "unlimited" then return true end

  while turtle.getFuelLevel() < minFuel do
    local fueled = false
    for i = 1, 16 do
      turtle.select(i)
      if turtle.refuel(0) then
        turtle.refuel(1)
        fueled = true
        break
      end
    end
    if not fueled then
      print("Nincs elég üzemanyag! Helyezz üzemanyagot az inventoryba.")
      sleep(5)
    end
  end
end


function digForward()
  while turtle.detect() do
    turtle.dig()
    sleep(0.3)
  end
end


function digUp()
  while turtle.detectUp() do
    turtle.digUp()
    sleep(0.3)
  end
end


function forward()
  while not turtle.forward() do
    digForward()
    sleep(0.3)
  end
end


function placeTorch()
  for i = 1, 16 do
    local item = turtle.getItemDetail(i)
    if item and item.name and item.name:lower():find("torch") then
      turtle.select(i)
      turtle.placeDown()
      return true
    end
  end
  return false
end



print("Bányászás indul. Célhossz: " .. length .. " blokk.")
checkFuel()

for i = 1, length do
  digForward()
  digUp()
  turtle.digDown()
  forward()

  -- Fáklya minden X-edik blokknál
  if i % torchInterval == 0 then
    turtle.turnLeft()
    turtle.turnLeft()
    placeTorch()
    turtle.turnLeft()
    turtle.turnLeft()
  end
end

print("Kész! Az alagút " .. length .. " blokk hosszú lett.")
