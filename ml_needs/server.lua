data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("RegisterUsableItem:bread")
AddEventHandler("RegisterUsableItem:bread", function(source)
    local _source = source   
    data.delItem(_source, "bread", 1)
    TriggerClientEvent("ml_needs:use:bread", source, 15) 
end)

RegisterServerEvent("RegisterUsableItem:water")
AddEventHandler("RegisterUsableItem:water", function(source)
    local _source = source   
    data.delItem(_source, "water", 1)
    TriggerClientEvent("ml_needs:use:water", source, 15) 
end)

RegisterServerEvent("RegisterUsableItem:cookedmeat")
AddEventHandler("RegisterUsableItem:cookedmeat", function(source)
    local _source = source   
    data.delItem(_source, "cookedmeat", 1)
    TriggerClientEvent("ml_needs:use:meat", source, 15) 
end)

RegisterServerEvent("RegisterUsableItem:cookedfish")
AddEventHandler("RegisterUsableItem:cookedfish", function(source)
    local _source = source   
    data.delItem(_source, "cookedfish", 1)
    TriggerClientEvent("ml_needs:use:fish", source, 15) 
end)

RegisterServerEvent('fish:refund')
AddEventHandler('fish:refund', function(item)
    local _item = item
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        data.addItem(source,"cookedfish", 1)
    end)
end)

RegisterServerEvent('meat:refund')
AddEventHandler('meat:refund', function(item)
    local _item = item
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        data.addItem(source,"cookedmeat", 1)
    end)
end)

RegisterServerEvent('water:refund')
AddEventHandler('water:refund', function(item)
    local _item = item
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        data.addItem(source,"water", 1)
    end)
end)

RegisterServerEvent('bread:refund')
AddEventHandler('bread:refund', function(item)
    local _item = item
    local _source = source
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        data.addItem(source,"bread", 1)
    end)
end)