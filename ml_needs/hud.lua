function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end
oxygenTank = 25.0
local HudStage = 1
opacity = 0
fadein = false

local opacityBars = 0 
local Addition = 0.0

function getThirst()
	return exports["ml_needs"]:ml_thirst()
end
function getHunger()
	return exports["ml_needs"]:ml_hunger()
end
function getStress()
	return exports["ml_needs"]:ml_stress()
end

-- TODO: Cleanup this code
Citizen.CreateThread(function()
	while true do Citizen.Wait(0)
		


		local health = GetEntityHealth(GetPlayerPed(-1)) - 100
		--if health < 1 then health = 100 end
		local varSet = 0.06938 * (health / 100)
		
		--drawRct(0.016, 0.97, 0.06938,0.01,188,188,188,80)

		--drawRct(0.016, 0.97, varSet,0.01,55,185,55,177)

		-- armor = GetPedArmour(GetPlayerPed(-1))
		-- if armor > 100.0 then armor = 100.0 end
		-- local varSet = 0.06938 * (armor / 100)
		-- drawRct(0.0865, 0.97, 0.06938,0.01,188,188,188,80)
		-- drawRct(0.0865, 0.97, varSet,0.01,115,115,255,177)

		
		varSet = 0.05848 * (getHunger() / 100)
		--drawRct(0.016, 0.983, 0.0268,0.01,188,188,188,80) -- 0.016
		drawRct(0.025, 0.977, 0.05848,0.015,0,0,0,255)
		drawRct(0.025, 0.977, varSet,0.015,215,33,33,80)
		drawText("HUNGER", 0.045, 0.976,  1, false, 0.2, false) --  draw text on needs ;D

		varSet = 0.05848 * (getThirst() / 100)
		--drawRct(0.044, 0.983, 0.027,0.01,188,188,188,80)
		drawRct(0.090, 0.977, 0.05848,0.015,0,0,0,255)
		drawRct(0.090, 0.977, varSet,0.015,215,33,33,80) 
		drawText("THIRST", 0.1087, 0.976,  1, false, 0.2, false) -- draw text on needs ;D
		
		--stress
		--varSet = 0.02038 * (getStress() / 100)
		--drawRct(0.1352, 0.983, 0.02038, 0.01, 188, 188, 188, 80)
		--drawRct(0.1352, 0.983, varSet,0.01, 230, 255, 0, 177)
		
	end
end)

function drawText(text, x, y, font, color, scale, center, shadow, alignRight)

    local str = CreateVarString(10, "LITERAL_STRING", text)

    if color then
        SetTextColor(color.r, color.g, color.b, color.a)
    else
        SetTextColor(255, 255, 255, 255)
    end

    SetTextFontForCurrentCommand(font)
    SetTextScale(scale, scale)

    if shadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end

    if center then
        SetTextCentre(center)
    elseif alignRight then
        --DisplayText(menus[currentMenu].x, menus[currentMenu].x + menus[currentMenu].width - buttonTextXOffset)
    end

    DisplayText(str, x, y)

end

local function drawTitle()
	if menus[currentMenu] then
		local x = menus[currentMenu].x + menus[currentMenu].width / 2
		local y = menus[currentMenu].y + titleHeight / 2

        HasStreamedTextureDictLoaded("menu_textures")
        DrawSprite("menu_textures", "translate_bg_1a", 0.20, 0.2, 0.35, 0.35, 0.8, 000, 2, 2, 200, 1)
        DrawSprite("menu_textures", "translate_bg_1a", 0.20, 0.1, 0.30, 0.1, 0.1, 100, 1, 1, 150, 0)
		drawText(menus[currentMenu].title, x, y - titleHeight / 2 + titleYOffset, menus[currentMenu].titleFont, menus[currentMenu].titleColor, titleScale, true)
	end
end


local function drawSubTitle()
	if menus[currentMenu] then
		local x = menus[currentMenu].x + menus[currentMenu].width / 2
		local y = menus[currentMenu].y + titleHeight + buttonHeight / 2

		local subTitleColor = { r = menus[currentMenu].titleBackgroundColor.r, g = menus[currentMenu].titleBackgroundColor.g, b = menus[currentMenu].titleBackgroundColor.b, a = 255 }

		drawRect(x, y, menus[currentMenu].width, buttonHeight, menus[currentMenu].subTitleBackgroundColor)
		drawText(menus[currentMenu].subTitle, menus[currentMenu].x + buttonTextXOffset, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false)

		if optionCount > menus[currentMenu].maxOptionCount then
			drawText(tostring(menus[currentMenu].currentOption)..' / '..tostring(optionCount), menus[currentMenu].x-0.05 + menus[currentMenu].width, y - buttonHeight / 2 + buttonTextYOffset, buttonFont, subTitleColor, buttonScale, false, false, true)
		end
	end
end
