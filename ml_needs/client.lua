local clienttime = 0
local hunger = 100
local thirst = 100
local stress = 0

function ml_thirst()
	return thirst
end

function ml_hunger()
	return hunger
end

function ml_stress()
	return stress
end

local UI = {
	x =  0.000 ,	-- Base Screen Coords 	+ 	 x
	y = -0.001 ,	-- Base Screen Coords 	+ 	-y
}
local init = false

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

AddEventHandler('playerSpawned', function(spawn)
	init = true
	hunger = 100
	thirst = 100
	TriggerEvent('ml_needs:unpause')
	
end)



local paused = false
RegisterNetEvent('ml_needs:pause')
RegisterNetEvent('ml_needs:unpause')
AddEventHandler('ml_needs:pause', function()
	paused = true
	
end)
AddEventHandler('ml_needs:unpause', function()
	
	paused = false
end)

local notifstarve = false
local notifthirst = false
local dead = false
local starve = false

local foodtime = 90000

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    clienttime = clienttime + 1
	Citizen.Wait(foodtime)
	
    if hunger <= 10 and starve == false then
	TriggerEvent("redemrp_notification:start", "You feel hungry!", 2)
	starve = true
	end
	
      if hunger <= 0 then
		
			if notifstarve == false then
				TriggerEvent("redemrp_notification:start", "You have died from hunger!", 3)
				notifstarve = true
				local pl = Citizen.InvokeNative(0x217E9DC48139933D)
				local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
				Citizen.InvokeNative(0x697157CED63F18D4, ped, 500000, false, true, true)
				print("you need to eat")	
			end
		
      else
		if not paused then
			hunger = hunger - 3 --2.4
			print("deduct hungry")
		end
		notifstarve = false
      end    
  end
end)

local thirsttime = 75000

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    clienttime = clienttime + 1
	Citizen.Wait(thirsttime)
	if thirst <= 10 and starve == false then
	TriggerEvent("redemrp_notification:start", "You feel thirsty!", 2)
	starve = true
	end
	
      if thirst <= 0 then
			if notifthirst == false then
				TriggerEvent("redemrp_notification:start", "You have died from thirst!", 3)
				notifthirst = true
				local pl = Citizen.InvokeNative(0x217E9DC48139933D)
				local ped = Citizen.InvokeNative(0x275F255ED201B937, pl)
				Citizen.InvokeNative(0x697157CED63F18D4, ped, 500000, false, true, true)
				print("you need to drink")
			end
		
      else
		if not paused then
			thirst = thirst - 3 --2.7
			print("deduct thirst")
		end
		notifthirst = false
      end	
  end
end)

Citizen.CreateThread(function() --just to check every 5 seconds otherwise the players needs can be like 100+ means they can abuse stuff like unlimited food cheats (will do a check for admins later)
    while true do
        Citizen.Wait(5000)
		if hunger > 101 then
			hunger = 100
			print("your food was over 100 setting to 100")
		end
		if thirst > 101 then
			thirst = 100
			print("your thirst was over 100 setting to 100")
		end
    end
end)

RegisterNetEvent('ml_needs:use:bread')
AddEventHandler('ml_needs:use:bread', function(amount)
  if hunger >= 100 then
    hunger = 100
	TriggerEvent("redemrp_notification:start", "You are not hungry!", 3)
	TriggerServerEvent("bread:refund")
  else
	print("this is fucked?")
	hunger = hunger + amount
	eatbread() --play animation just testing atm seems ok need to change rotation of bread
  end
  -- do what here?
end)

RegisterNetEvent('ml_needs:use:meat')
AddEventHandler('ml_needs:use:meat', function(amount)
  if hunger >= 100 then
    hunger = 100
	TriggerEvent("redemrp_notification:start", "You are not hungry!", 3)
	TriggerServerEvent("meat:refund")
  else
	print("this is fucked?")
	hunger = hunger + amount
	eatmeat() --play animation just testing atm seems ok need to change rotation of bread
  end
  -- do what here?
end)

RegisterNetEvent('ml_needs:use:fish')
AddEventHandler('ml_needs:use:fish', function(amount)
  if hunger >= 100 then
    hunger = 100
	TriggerEvent("redemrp_notification:start", "You are not hungry!", 3)
	TriggerServerEvent("fish:refund")
  else
	print("this is fucked?")
	hunger = hunger + amount
	eatfish() --play animation just testing atm seems ok need to change rotation of bread
  end
  -- do what here?
end)






---DUCKY EATING BLUEBERRY BUSHES TEST ^^

RegisterNetEvent('ml_needs:use:water')
AddEventHandler('ml_needs:use:water', function(amount)
  if thirst >= 100 then
    thirst = 100
	TriggerEvent("redemrp_notification:start", "You are not thirsty!", 3)
	TriggerServerEvent("water:refund")	
  else
  local propEntity = CreateObject(GetHashKey('p_bottleBeer01a'), GetEntityCoords(PlayerPedId()), false, true, false, false, true)

    local task = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleBeer01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD'), 1, 0, -1.0)
    local drink = true
    while drink do
        Wait(1)
        local retval  = DoesEntityExist(propEntity)
        if not retval then
            drink = false
			thirst = thirst + amount
	end
   end
  end
  -- do what here?
end)

RegisterNetEvent('ml_needs:stress:add')
AddEventHandler('ml_needs:stress:add', function(increase)
	if stress + increase >= 100 then
		stress = 100
	else
		stress = stress + increase
	end
end)

RegisterNetEvent('ml_needs:stress:remove')
AddEventHandler('ml_needs:stress:remove', function(relief)
	if stress - relief <= 0 then
		stress = 0
	else
		stress = stress - relief
	end
end)

RegisterNetEvent('ml_needs:resetall')
AddEventHandler('ml_needs:resetall', function()
	init = true
	hunger = 100
	thirst = 100
	TriggerEvent('ml_needs:unpause')
end)

function eatbread()
    local playerPed = PlayerPedId()
    local prop_name = 'P_BREAD_08_AB_SLICE_A'
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_Finger12")

    RequestAnimDict("mech_inventory@clothing@bandana")
    while not HasAnimDictLoaded("mech_inventory@clothing@bandana") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, "mech_inventory@clothing@bandana", "NECK_2_FACE_RH", 8.0, 8.0, 12600, 0, 0, true, 0, false, 0, false)
    AttachEntityToEntity(prop, playerPed, boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
	print("do animation?")
    --exports['progressBars']:startUI(12500, "mining")
    Citizen.Wait(2800)
	--print("delete axe and cancel anim")
    ClearPedSecondaryTask(playerPed)
	DeleteObject(prop)
end

function eatmeat()
    local playerPed = PlayerPedId()
    local prop_name = 'P_BREAD_08_AB_SLICE_A'
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_Finger12")

    RequestAnimDict("mech_inventory@clothing@bandana")
    while not HasAnimDictLoaded("mech_inventory@clothing@bandana") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, "mech_inventory@clothing@bandana", "NECK_2_FACE_RH", 8.0, 8.0, 12600, 0, 0, true, 0, false, 0, false)
    AttachEntityToEntity(prop, playerPed, boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
	print("do animation?")
    --exports['progressBars']:startUI(12500, "mining")
    Citizen.Wait(2800)
	--print("delete axe and cancel anim")
    ClearPedSecondaryTask(playerPed)
	DeleteObject(prop)
end


function eatfish()
    local playerPed = PlayerPedId()
    local prop_name = 'P_BREAD_08_AB_SLICE_A'
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_Finger12")

    RequestAnimDict("mech_inventory@clothing@bandana")
    while not HasAnimDictLoaded("mech_inventory@clothing@bandana") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, "mech_inventory@clothing@bandana", "NECK_2_FACE_RH", 8.0, 8.0, 12600, 0, 0, true, 0, false, 0, false)
    AttachEntityToEntity(prop, playerPed, boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
	print("do animation?")
    --exports['progressBars']:startUI(12500, "mining")
    Citizen.Wait(2800)
	--print("delete axe and cancel anim")
    ClearPedSecondaryTask(playerPed)
	DeleteObject(prop)
end
