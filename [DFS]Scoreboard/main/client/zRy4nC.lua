--[[

$$$$$$$\                      $$\              $$$$$$\    p              $$\                     
$$  __$$\                     $$ |            $$  __$$\                 $$ |                    
$$ |  $$ | $$$$$$\   $$$$$$$\ $$ |  $$\       $$ /  \__| $$$$$$\   $$$$$$$ | $$$$$$\   $$$$$$$\ 
$$ |  $$ |$$  __$$\ $$  _____|$$ | $$  |      $$ |      $$  __$$\ $$  __$$ |$$  __$$\ $$  _____|
$$ |  $$ |$$$$$$$$ |\$$$$$$\  $$$$$$  /       $$ |      $$ /  $$ |$$ /  $$ |$$$$$$$$ |\$$$$$$\  
$$ |  $$ |$$   ____| \____$$\ $$  _$$<        $$ |  $$\ $$ |  $$ |$$ |  $$ |$$   ____| \____$$\ 
$$$$$$$  |\$$$$$$$\ $$$$$$$  |$$ | \$$\       \$$$$$$  |\$$$$$$  |\$$$$$$$ |\$$$$$$$\ $$$$$$$  |
\_______/  \_______|\_______/ \__|  \__|       \______/  \______/  \_______| \_______|\_______/ 

]] 

-- responsive
local parentWidth, parentHeight = 562 * screenScale, 735 * screenScale;
local parentX, parentY = (screenWidth - parentWidth) / 2, (screenHeight - parentHeight) / 2;

local color = config['gerais']['color']
local nextpage = 0
local interpolate = {0, 0}
local tick = getTickCount()

local function respX (value)
    return parentX + respc (value);
end;

local function respY (value)
    return parentY + respc (value);
end;

local function isCursorOnElement (x, y, width, height)
    return ((cursors[1] >= x and cursors[1] <= x + width) and (cursors[2] >= y and cursors[2] <= y + height))
end;

local function instanceRender ()
    local alpha = interpolateBetween(interpolate[1], 0, 0, interpolate[2], 0, 0, ((getTickCount() - tick) / 500), 'Linear')
    if isCursorShowing () then
        local c = {getCursorPosition ()};
        cursors = {c[1] * screenWidth, c[2] * screenHeight};
    end;
    
    dxDrawImage(parentX, parentY, parentWidth, parentHeight, 'fundo.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    
    dxDrawImage(respX(37), respY(36), respc(24), respc(24), 'person.png', 0, 0, 0, tocolor (color[1], color[2], color[3], alpha))
    dxDrawText('Scoreboard', respX(73), respY(38), respc(78), respc(20), tocolor(200, 200, 200, 255), 1.0, setFont('medium', 17), "left", "center")
    dxDrawText('Veja as informações dos cidadãos de nossa cidade', respX(37), respY(64), respc(346), respc(20), tocolor(100, 100, 100, alpha), 1.0, setFont('medium', 15), "left", "center")
    
    dxDrawImage(respX(399), respY(29), respc(125), respc(55), 'bg1.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    
    dxDrawImageSection(respX(399), respY(29), respc(125) / 100 * ((#getElementsByType("player") / (100 or 100)) * 100), respc(55), 0, 0, respc(125) / 100 * ((#getElementsByType("player") / (100 or 100)) * 100), respc(55), svg['bg'], 0, 0, 0, tocolor(color[1], color[2], color[3], alpha))
    dxDrawText('Jogadores', respX(399), respY(36), respc(125), respc(20), tocolor(90, 90, 90, alpha), 1.0, setFont('medium', 17), "center", "center")
    dxDrawText(''..#getElementsByType("player")..'/100', respX(399), respY(58), respc(125), respc(20), tocolor(145, 145, 145, alpha), 1.0, setFont('medium', 17), "center", "center")
    dxDrawImage(respX(37), respY(102), respc(487), respc(73), 'bg2.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    
    dxDrawText('Suas informações', respX(107), respY(118), respc(122), respc(20), tocolor(100, 100, 100, alpha), 1.0, setFont('medium', 15), "left", "center")
    dxDrawText(''..getPlayerName(localPlayer)..' #'..(getElementData(localPlayer, 'ID') or 'N/A')..'', respX(107), respY(140), respc(78), respc(20), tocolor(200, 200, 200, alpha), 1.0, setFont('medium', 17), "left", "center")
    dxDrawImage(respX(55), respY(121), respc(36), respc(36), 'rectangle.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    dxDrawImage(respX(64), respY(130), respc(18), respc(18), 'person.png', 0, 0, 0, tocolor (color[1], color[2], color[3], alpha))
    
    dxDrawText('Dinheiro', respX(316), respY(118), respc(122), respc(20), tocolor(100, 100, 100, 255), 1.0, setFont('medium', 15), "left", "center")
    dxDrawText(''..formatNumber(getPlayerMoney(localPlayer))..' R$', respX(316), respY(140), respc(78), respc(20), tocolor(200, 200, 200, alpha), 1.0, setFont('medium', 17), "left", "center")
    dxDrawImage(respX(264), respY(121), respc(36), respc(36), 'rectangle.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    dxDrawImage(respX(273), respY(130), respc(18), respc(18), 'ion_wallet.png', 0, 0, 0, tocolor (color[1], color[2], color[3], alpha))
    dxDrawText(''..getPlayerPing ( localPlayer )..' ms', respX(447), respY(102), respc(50), respc(73), tocolor(100, 100, 100, alpha), 1.0, setFont('medium', 15), "right", "center")
    
    dxDrawText('Policiais', respX(89), respY(199), respc(59), respc(20), tocolor(100, 100, 100, alpha), 1.0, setFont('medium', 17), "left", "center")
    dxDrawText((getElementData(localPlayer, 'Police') or 0), respX(89), respY(218), respc(78), respc(20), tocolor(200, 200, 200, 255), 1.0, setFont('medium', 17), "left", "center")
    dxDrawImage(respX(37), respY(199), respc(36), respc(36), 'rectangle.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    dxDrawImage(respX(45), respY(209), respc(19), respc(19), 'ic_round-local-police.png', 0, 0, 0, tocolor (125, 125, 125, alpha))
    
    dxDrawText('Médico', respX(214), respY(199), respc(59), respc(20), tocolor(100, 100, 100, alpha), 1.0, setFont('medium', 17), "left", "center")
    dxDrawText((getElementData(localPlayer, 'Samu') or 0), respX(214), respY(218), respc(78), respc(20), tocolor(200, 200, 200, 255), 1.0, setFont('medium', 17), "left", "center")
    dxDrawImage(respX(168), respY(199), respc(36), respc(36), 'rectangle.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    dxDrawImage(respX(176), respY(209), respc(19), respc(19), 'ion_medical.png', 0, 0, 0, tocolor (125, 125, 125, alpha))
    
    dxDrawText('Mecanicos', respX(336), respY(199), respc(59), respc(20), tocolor(100, 100, 100, alpha), 1.0, setFont('medium', 17), "left", "center")
    dxDrawText((getElementData(localPlayer, 'Mec') or 0), respX(336), respY(218), respc(78), respc(20), tocolor(200, 200, 200, alpha), 1.0, setFont('medium', 17), "left", "center")
    dxDrawImage(respX(290), respY(199), respc(36), respc(36), 'rectangle.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    dxDrawImage(respX(298), respY(209), respc(19), respc(19), 'ph_wrench-fill.png', 0, 0, 0, tocolor (125, 125, 125, alpha))
    
    dxDrawText('Staffs', respX(482), respY(199), respc(59), respc(20), tocolor(100, 100, 100, alpha), 1.0, setFont('medium', 17), "left", "center")
    dxDrawText((getElementData(localPlayer, 'Staff') or 0), respX(482), respY(218), respc(78), respc(20), tocolor(200, 200, 200, alpha), 1.0, setFont('medium', 17), "left", "center")
    dxDrawImage(respX(436), respY(199), respc(36), respc(36), 'rectangle.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    dxDrawImage(respX(444), respY(209), respc(19), respc(19), 'bxs_shield.png', 0, 0, 0, tocolor (125, 125, 125, alpha))
    
    local PesquisarPlayer = (getEditboxValue('Pesquisar', false) or '')
    nextpage = getScroll ('scroll')

    line = 0
    for i, v in ipairs(getElementsByType("player")) do
        if (i > nextpage and line < 4) then
            line = line + 1
            local distancia = respc(80 + 12)
            local playerName = getPlayerName(v)
            local id = getElementData(v, "ID") or "N/A"
            local card = getElementData(v, 'CARD') or 'Nenhum'
            if (string.find(playerName, PesquisarPlayer, 1, true)) then

            dxDrawImage(respX(37), respY(271) - distancia + line * distancia, respc(487), respc(80), 'cards/'..card..'.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
            dxDrawText(''..playerName..' #'..id..'', respX(112), respY(271) - distancia + line * distancia, respc(487), respc(80), tocolor(145, 145, 145, alpha), 1.0, setFont('medium', 17), "left", "center")
            dxDrawText(''..getPlayerPing (v)..' ms', respX(448), respY(271) - distancia + line * distancia, respc(51), respc(80), tocolor(145, 145, 145, alpha), 1.0, setFont('medium', 17), "right", "center")
            dxDrawImage(respX(60), respY(293) - distancia + line * distancia, respc(36), respc(36), 'circle.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
            dxDrawImage(respX(69), respY(302) - distancia + line * distancia, respc(18), respc(18), 'person2.png', 0, 0, 0, tocolor (125, 125, 125, alpha))
            
            end
        end
    end
    
    dxDrawImage(respX(37), respY(647), respc(263), respc(59), 'pesquisar.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    dxDrawImage(respX(65), respY(669), respc(15), respc(15), 'fa6-solid_magnifying-glass.png', 0, 0, 0, tocolor(color[1], color[2], color[3], alpha))
    dxDrawText(getEditboxValue('Pesquisar', true), respX(37), respY(649), respc(263), respc(59), tocolor(100, 100, 100, alpha), 1.0, setFont('medium', 17), "center", "center")
    
    dxDrawImage(respX(311), respY(647), respc(217), respc(59), 'discord.png', 0, 0, 0, tocolor (255, 255, 255, alpha))
    dxDrawText('Copiar Discord', respX(311), respY(649), respc(217), respc(59), isCursorOnElement(respX(311), respY(647), respc(217), respc(59)) and tocolor(color[1], color[2], color[3], alpha) or tocolor(100, 100, 100, alpha), 1.0, setFont('medium', 17), "center", "center")
end;


addEventHandler("onClientClick", root, function(_, state)
    if activeEvent('onClientRender', root, instanceRender) then 
        if state == 'down' then
            if isCursorOnElement( respX(37), respY(649), respc(263), respc(59)) then 
                setEditboxEditing('Pesquisar')
            elseif isCursorOnElement(respX(311), respY(649), respc(217), respc(59)) then 
                setClipboard('https://discord.gg/u9ZeT9e2Tg')
                notify.client('Discord copiado com sucesso!', 'success');
            end
        end
    end
end) 

bindKey('tab', 'down', 
function()
    if not activeEvent('onClientRender', root, instanceRender) then 
        addEventHandler('onClientRender', root, instanceRender)
        tick = getTickCount()
        interpolate = {0, 255}
        showCursor(true)
        createEditbox('Pesquisar', 15, false)
        createScroll ('scroll', {x = respX(532), y = respY(271), width = respc(4), height = respc(356), size = 48}, {background = {255, 255, 255, 10}, using = {128, 91, 166, 255}, scroll = {128, 91, 166, 255}}, false, function () return true end, 1, getElementsByType("player"), 4, false)

    else 
        showCursor(false)
        tick = getTickCount()
        interpolate = {255, 0}
        destroyScroll ('scroll')
        setTimer ( function()
            removeEditbox('all')
            removeEventHandler('onClientRender', root, instanceRender)
        end, 500, 1 )
    end
end)


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