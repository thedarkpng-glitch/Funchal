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

function printResourceName()
    if config['gerais']['mensagem'] then
        local resourceName = getResourceName(getThisResource())
        outputDebugString("* [Exclusivo] - DeskCodes: O sistema "..resourceName.." foi iniciado com sucesso. Caso encontre algum bug, entre em contato com zryang ♡", 4, 173, 146, 255)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), printResourceName)


-- {acl = 'Admin', file = 'banner.png'}

setTimer(function()
    for _, player in ipairs(getElementsByType('player')) do
        for i, v in ipairs(config['cards']) do 
            if aclGetGroup(v.acl) then
                if isObjectInACLGroup('user.'..getAccountName(getPlayerAccount(player)), aclGetGroup(v.acl)) then
                    setElementData(player, 'CARD', v.file)
                    break
                else
                    setElementData(player, 'CARD', 'Nenhum')
                end
            else
                outputDebugString("* A acl '"..v.acl.."' não está criada.", 4, 173, 146, 255)
            end
        end 
    end
end, 1000, 0)


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