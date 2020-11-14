data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("RegisterUsableItem:bread")
AddEventHandler("RegisterUsableItem:bread", function(source)
    local _source = source   
    local ItemData = data.getItem(_source, 'bread')
    ItemData.RemoveItem(1)
    TriggerClientEvent("ml_needs:use:bread", source, 15) 
end)

RegisterServerEvent("RegisterUsableItem:water")
AddEventHandler("RegisterUsableItem:water", function(source)
    local _source = source   
    local ItemData = data.getItem(_source, 'water')
    ItemData.RemoveItem(1)
    TriggerClientEvent("ml_needs:use:water", source, 15) 
end)

RegisterServerEvent("RegisterUsableItem:cookedmeat")
AddEventHandler("RegisterUsableItem:cookedmeat", function(source)
    local _source = source   
    local ItemData = data.getItem(_source, 'cookedmeat')
    ItemData.RemoveItem(1)
    TriggerClientEvent("ml_needs:use:meat", source, 15) 
end)

RegisterServerEvent("RegisterUsableItem:cookedfish")
AddEventHandler("RegisterUsableItem:cookedfish", function(source)
    local _source = source   
    local ItemData = data.getItem(_source, 'cookedfish')
    ItemData.RemoveItem(1)
    TriggerClientEvent("ml_needs:use:fish", source, 15) 
end)

RegisterServerEvent('fish:refund')
AddEventHandler('fish:refund', function(item)
    local _item = item
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local ItemData = data.getItem(_source, 'cookedfish')
		ItemData.AddItem(1)
    end)
end)

RegisterServerEvent('meat:refund')
AddEventHandler('meat:refund', function(item)
    local _item = item
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local ItemData = data.getItem(_source, 'cookedmeat')
		ItemData.AddItem(1)
    end)
end)

RegisterServerEvent('water:refund')
AddEventHandler('water:refund', function(item)
    local _item = item
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local ItemData = data.getItem(_source, 'water')
		ItemData.AddItem(1)
    end)
end)

RegisterServerEvent('bread:refund')
AddEventHandler('bread:refund', function(item)
    local _item = item
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local ItemData = data.getItem(_source, 'bread')
		ItemData.AddItem(1)
    end)
end)
