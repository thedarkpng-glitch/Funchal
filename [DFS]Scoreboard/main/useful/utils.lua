local fonts = { }

setFont = function(font, size)
    if (not fonts[font]) then
        fonts[font] = { }
    end
    if (not fonts[font][size]) then
        fonts[font][size] = dxCreateFont('assets/fonts/'..font..'.ttf', size, false, 'cleartype') or 'default-bold'
    end
    
    return fonts[font][size]
end

local buttons = {}

function drawRect(x, y, width, height, radius, color, colorStroke, sizeStroke, postGUI)
    colorStroke = tostring(colorStroke)
    sizeStroke = tostring(sizeStroke)
    
    if (not buttons[radius]) then
        local raw = string.format([[
        <svg width='%s' height='%s' fill='none' xmlns='http://www.w3.org/2000/svg'>
        <mask id='path_inside' fill='#FFFFFF' >
        <rect width='%s' height='%s' rx='%s' />
        </mask>
        <rect opacity='1' width='%s' height='%s' rx='%s' fill='#FFFFFF' stroke='%s' stroke-width='%s' mask='url(#path_inside)'/>
        </svg>
        ]], width, height, width, height, radius, width, height, radius, colorStroke, sizeStroke)
        buttons[radius] = svgCreate(width, height, raw)
    end
    if (buttons[radius]) then -- Se já existir um botão com o mesmo Radius, reaproveitaremos o mesmo, para não criar outro.
        dxDrawImage(x, y, width, height, buttons[radius], 0, 0, 0, color, postGUI)
    end
end

activeEvent = function ( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end

function formatNumber(number, sep)
	assert(type(tonumber(number))=="number", "Bad argument @'formatNumber' [Expected number at argument 1 got "..type(number).."]")
	assert(not sep or type(sep)=="string", "Bad argument @'formatNumber' [Expected string at argument 2 got "..type(sep).."]")
	local money = number
	for i = 1, tostring(money):len()/3 do
		money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1"..sep.."%2")
	end
	return money
end

function formatNumber(number)
	return string.gsub(number, '^(-?%d+)(%d%d%d)', '%1.%2')
end

removeHex = 
function(str) 
    return str:gsub("#%x%x%x%x%x%x", "") 
end 

--local vehicle, model, dimension, interior = getVehicleProx(player, 4.0, 'vehicle')

-- getVehicleProx = function(player, dist, type_action)
--     if player and dist and type_action then
--         for i, v in ipairs(getElementsByType(type_action)) do
--             local x, y, z = getElementPosition(v)
--             local ax, ay, az = getElementPosition(player)
--             if getDistanceBetweenPoints3D(x, y, z, ax, ay, az) <= tonumber(dist) then
--                 return v, getElementModel(v), getElementDimension(v), getElementInterior(v)
--             end
--         end
--     end
--     return false
-- end


-- getAclPlayer = 
-- function(player,acl)
--     if aclGetGroup ( acl ) then
--         if isObjectInACLGroup("user." ..getAccountName(getPlayerAccount(player)), aclGetGroup(acl)) then
--             return true
--         end
--     else
--         outputDebugString ( "O Sistema não identificou a acl "..acl..", por favor crie a acl informada!", 3,5,162,238 ) 
--     end
--     return false
-- end

-- resultAcls = 
-- function(player,acl)
--     result = 0
--     for i, players in ipairs (getElementsByType("player")) do
--         if not aclGetGroup ( acl ) then 
--             outputDebugString ( "O Sistema não identificou a acl "..acl..", por favor crie a acl informada!", 3,5,162,238 ) 
--             return
--         end
--         tableacl = aclGroupListObjects(aclGetGroup(acl))
--         for i, v in ipairs(tableacl) do
--             result = i
--         end
--     end
--     return result
-- end


--[[
 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
 ███╗   ███╗████████╗ █████╗    ███████╗ █████╗     ███╗   ███╗ ██████╗ ██████╗ ███████╗█
 ████╗ ████║╚══██╔══╝██╔══██╗██╗██╔════╝██╔══██╗    ████╗ ████║██╔═══██╗██╔══██╗██╔════╝█
 ██╔████╔██║   ██║   ███████║╚═╝███████╗███████║    ██╔████╔██║██║   ██║██║  ██║███████╗█
 ██║╚██╔╝██║   ██║   ██╔══██║██╗╚════██║██╔══██║    ██║╚██╔╝██║██║   ██║██║  ██║╚════██║█
 ██║ ╚═╝ ██║   ██║   ██║  ██║╚═╝███████║██║  ██║    ██║ ╚═╝ ██║╚██████╔╝██████╔╝███████║█
 █╚═╝     ╚═╝   ╚═╝   ╚═╝  ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝ ╚═════╝ ╚═════╝ ╚══════█
 █                                                                                      █
 █                ┌───────────────────────────────────────────────────┐                 █
 █                ┤MAIS DE 1000 MODS DESCOMPILADOS COM DOWNLOAD DIRETO┤                 █
 █                └───────────────────────────────────────────────────┘                 █
 █                   ┌─────────────────────────────────────────────┐                    █
 █                   ┤ A MAIOR COMUNIDADE DE MODS DO MTA BRASIL 🥇 ┤                    █
 █                   └─────────────────────────────────────────────┘                    █
 █                          ┌───────────────────────────────┐                           █
 █                          ┤  LINK DE CONVITE PERMANENTE:  ┤                           █
 █                          ┤ https://discord.gg/KXV2GHtJtg ┤                           █
 █                          ┤ https://discord.gg/KXV2GHtJtg ┤                           █
 █                          ┤ https://discord.gg/KXV2GHtJtg	┤                           █
 █                          └───────────────────────────────┘                           █
 █ ┌────────────────────────────────────────┐                                           █
 ├≡┤ Canais que postamos mods todos os dias │                                           █
 █ └────────────────────────────────────────┘                                           █
 █ ┤ Veiculos-Low-Poly                                                                  █
 █ ┤ Armas-Exclusivas                                                                   █
 █ ┤ Skins-Exclusivas                                                                   █
 █ ┤ Concessionárias                                                                    █
 █ ┤ Modelagens                                                                         █
 █ ┤ Sons-Armas                                                                         █
 █ ┤ Exclusivos - Mods Exclusivos                                                       █
 █ ┤ Interiores                                                                         █
 █ ┤ Animações                                                                          █
 █ ┤ Resources                                                                          █
 █ ┤ ls-full-br - Uma conversão de mapas para deixar los santos brasileira              █
 █ ┤ Calçadas                                                                           █
 █ ┤ Mapas                                                                              █
 █ ┤ Radar                                                                              █
 █ ┤ Huds                                                                               █
 █                                                                                      █
 ██▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄██
 ]]