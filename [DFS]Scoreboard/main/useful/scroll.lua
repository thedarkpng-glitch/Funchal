-- createScroll ('veiculos', {x = parentX, y = parentY, width = 5, height = 314, size = 48}, {background = {20, 20, 20, 255}, using = {128, 91, 166, 255}, scroll = {255, 255, 255, 255}}, false, function () return true end, 1, config['gerais']['color'], 1, false)
-- nextpage = getScroll ('veiculos')  

local screen = Vector2 (guiGetScreenSize ()) 

local function isCursorOnElement (x, y, width, height)
    return ((cursors[1] >= x and cursors[1] <= x + width) and (cursors[2] >= y and cursors[2] <= y + height))
end;

if isCursorShowing () then
    local c = {getCursorPosition ()};
    
    cursors = {c[1] * screenWidth, c[2] * screenHeight};
end;


local scrollbar = {
    total = 0;
    using = false;
    active = false;
    actual = false;
    events = false;
    elements = { };
}

-- draw's scroll's
function drawScroll ()
    if scrollbar.events and scrollbar.total < 1 then
        removeEventHandler ('onClientRender', getRootElement (), drawScroll)
        removeEventHandler ('onClientClick', getRootElement (), clickScroll)
        
        unbindKey ('mouse_wheel_up', 'down', updateScroll)
        unbindKey ('mouse_wheel_down', 'down', updateScroll)
        
        scrollbar.events = false
        
        return true
    end
    
    local active
    local actual
    
    for id, data in pairs (scrollbar.elements) do
        local x, y, width, height, size = data.position.x, data.position.y, data.position.width, data.position.height, data.position.size
        local postGUI = data.postGUI
        
        if size >= height then
            data.position.size = math.max ((height / (#data.values - data.visible)), 5)
        end
        
        local total = (y + height - size)
        
        if not data.position.offset then
            data.position.offset = y
        end
        
        local haveAnimation = (data.animation and type (data.animation) == 'table')
        
        if haveAnimation then
            data.animation.alpha = interpolateBetween (data.animation.start, 0, 0, data.animation.final, 0, 0, (getTickCount () - data.animation.tick) / data.animation.time, 'Linear')
        end
        
        if data.using and isCursorShowing () then
            local cursor = Vector2 (getCursorPosition ())

            local cursory = (cursor.y * screen.y)
            
            local actual = math.ceil ((data.position.offset - y) * ((#data.values - data.visible) / data.update) / (height - size)) * data.update
            
            data.position.offset = (cursory <= y and y or cursory >= total and total or cursory)
            data.actual = (data.position.offset <= y and 0 or actual >= (#data.values - data.visible) and (#data.values - data.visible) or actual)
        end
        
        if isCursorOnElement (x, data.position.offset, width, data.position.size) then
            actual = id
        end
        
        if data.condition and data.condition () then
            active = id
        end
        
        if scrollbar.active ~= active then
            scrollbar.active = active
        end
        
        if scrollbar.actual ~= actual then
            scrollbar.actual = actual
        end
        
        local pos = interpolate(data.position.offset, data.position.offset + data.update, 0.080, "AnimScroll")
        
        --dxDrawRectangle (x, y, width, height, tocolor (data.coloration.background[1], data.coloration.background[2], data.coloration.background[3], (haveAnimation and (data.coloration.background[4] * data.animation.alpha) or data.coloration.background[4])), postGUI)
        --dxDrawRectangle (x, pos, width, data.position.size, ((actual == id or data.using) and tocolor (data.coloration.using[1], data.coloration.using[2], data.coloration.using[3], (haveAnimation and (data.coloration.using[4] * data.animation.alpha) or data.coloration.using[4])) or tocolor (data.coloration.scroll[1], data.coloration.scroll[2], data.coloration.scroll[3], (haveAnimation and (data.coloration.scroll[4] * data.animation.alpha) or data.coloration.scroll[4]))), postGUI)
        
        drawRect( x, y, width, height, 2, tocolor (data.coloration.background[1], data.coloration.background[2], data.coloration.background[3], (haveAnimation and (data.coloration.background[4] * data.animation.alpha) or data.coloration.background[4])), "", "", false)
        drawRect( x, pos, width, data.position.size, 2, ((actual == id or data.using) and tocolor (data.coloration.using[1], data.coloration.using[2], data.coloration.using[3], (haveAnimation and (data.coloration.using[4] * data.animation.alpha) or data.coloration.using[4])) or tocolor (data.coloration.scroll[1], data.coloration.scroll[2], data.coloration.scroll[3], (haveAnimation and (data.coloration.scroll[4] * data.animation.alpha) or data.coloration.scroll[4]))), "", "", false)
        
    end
    
    return true
end

-- click's scroll's
function clickScroll (button, state)
    if not scrollbar.events or scrollbar.total < 1 then
        return false
    end
    
    if button ~= 'left' then
        return false
    end
    
    if state == 'up' then
        if not scrollbar.using then
            return false
        end
        
        scrollbar.elements[scrollbar.using].using = false
        scrollbar.using = false
        
        return true
    end
    
    if state == 'down' then
        if not scrollbar.actual then
            return false
        end
        
        if #scrollbar.elements[scrollbar.actual].values <= scrollbar.elements[scrollbar.actual].visible then
            return false
        end
        
        scrollbar.elements[scrollbar.actual].using = true
        scrollbar.using = scrollbar.actual
        
        return true
    end
    
    return false
end

-- update's scroll's
function updateScroll (button)
    local id = scrollbar.active
    
    if not id then
        return false
    end
    
    local data = scrollbar.elements[id]
    
    if not data then
        return false
    end
    
    if #data.values <= data.visible then
        return false
    end
    
    if button == 'mouse_wheel_up' then
        if data.actual <= 0 then
            return false
        end
        
        data.actual = data.actual - data.update
        
        setScroll (id)
        
        return true
    end
    
    if button == 'mouse_wheel_down' then
        if data.actual >= (#data.values - data.visible) then
            return false
        end
        
        data.actual = data.actual + data.update
        
        setScroll (id)
        
        return true
    end
    
    return false
end

-- event's scroll's
function createScroll (id, position, coloration, animation, condition, update, values, visible, postGUI)
    if not id then
        return false
    end
    
    if scrollbar.elements[id] then
        return false
    end
    
    scrollbar.elements[id] = {
        using = false;
        actual = 0;
        update = update;
        values = values;
        visible = visible;
        postGUI = postGUI;
        position = position;
        animation = animation;
        condition = condition;
        coloration = coloration;
    }
    
    scrollbar.total = scrollbar.total + 1
    
    if scrollbar.total ~= 0 and not scrollbar.events then
        addEventHandler ('onClientRender', getRootElement (), drawScroll)
        addEventHandler ('onClientClick', getRootElement (), clickScroll)
        
        bindKey ('mouse_wheel_up', 'down', updateScroll)
        bindKey ('mouse_wheel_down', 'down', updateScroll)
        
        scrollbar.events = true
    end
    
    return true
end

function destroyScroll (id)
    if not scrollbar.events or scrollbar.total < 1 then
        return false
    end
    
    if id then
        if not scrollbar.elements[id] then
            return false
        end
        
        scrollbar.elements[id] = nil
        scrollbar.total = scrollbar.total - 1
        
        if scrollbar.using == id then
            scrollbar.using = false
        end
        
        if scrollbar.total < 1 and scrollbar.events then
            removeEventHandler ('onClientRender', getRootElement (), drawScroll)
            removeEventHandler ('onClientClick', getRootElement (), clickScroll)
            
            unbindKey ('mouse_wheel_up', 'down', updateScroll)
            unbindKey ('mouse_wheel_down', 'down', updateScroll)
            
            scrollbar.events = false
        end
        
        return true
    end
    
    scrollbar.total = 0
    
    scrollbar.using = false
    scrollbar.active = false
    scrollbar.actual = false
    
    scrollbar.elements = { }
    
    if scrollbar.total < 1 and scrollbar.events then
        removeEventHandler ('onClientRender', getRootElement (), drawScroll)
        removeEventHandler ('onClientClick', getRootElement (), clickScroll)
        
        unbindKey ('mouse_wheel_up', 'down', updateScroll)
        unbindKey ('mouse_wheel_down', 'down', updateScroll)
        
        scrollbar.events = false
    end
    
    return true
end

function getScroll (id)
    if not scrollbar.events or scrollbar.total < 1 then
        return 0
    end
    
    if not id then
        return 0
    end
    
    if not scrollbar.elements[id] then
        return 0
    end
    
    return scrollbar.elements[id].actual
end

function setScroll (id, value)
    if not scrollbar.events or scrollbar.total < 1 then
        return false
    end
    
    if not id then
        return false
    end
    
    if not scrollbar.elements[id] then
        return false
    end
    
    local data = scrollbar.elements[id]
    
    if value then
        data.actual = (value <= 0 and 0 or value >= (#data.values - data.visible) and (#data.values - data.visible) or value)
    end
    
    local offset = (data.actual <= 0 and data.position.y or ((data.position.y + ((data.position.height - data.position.size) / (#data.values - data.visible)) * data.actual) >= (data.position.y + data.position.height - data.position.size) and (data.position.y + data.position.height - data.position.size) or (data.position.y + ((data.position.height - data.position.size) / (#data.values - data.visible)) * data.actual)))
    
    data.position.offset = offset
    
    return true
end

function animScroll (id, start, final, tick)
    if not scrollbar.events or scrollbar.total < 1 then
        return false
    end
    
    if id then
        if not scrollbar.elements[id] then
            return false
        end
        
        if not scrollbar.elements[id].animation or type (scrollbar.elements[id].animation) ~= 'table' then
            return false
        end
        
        scrollbar.elements[id].animation.start, scrollbar.elements[id].animation.final = start, final
        scrollbar.elements[id].animation.tick = (not tick and getTickCount () or tick)
        
        return true
    end
    
    for id, data in pairs (scrollbar.elements) do
        if data.animation and type (data.animation) == 'table' then
            data.animation.start, data.animation.final = start, final
            data.animation.tick = (not tick and getTickCount () or tick)
        end
    end
    
    return true
end

function setScrollValues (id, values)
    if not scrollbar.events or scrollbar.total < 1 then
        return false
    end
    
    if not scrollbar.elements[id] then
        return false
    end
    
    scrollbar.elements[id].values = values
    
    return true
end

function lerp (a, b, t)
    return a + (b - a) * t
end

local interpolates = { }
function interpolate (start, finish, time, index)
    if not (interpolates[index]) then
        interpolates[index] = start
    end
    
    interpolates[index] = lerp (interpolates[index], finish, time)
    return interpolates[index]
end


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