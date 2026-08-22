--como usar?
-- dxDrawText(getEditboxValue('Sobrenome', true), 535, 390, 84, 26... -- colocar a editBox na tela

-- createEditbox('Sobrenome', 30, true) -- criar a editBox

-- setEditboxEditing('Sobrenome') -- setar para q possa escrever nela

-- --ver o valor dela:
-- local surname = getEditboxValue('Sobrenome', false)
-- print(surname)


-- codigo 

local edit = {}

function createEditbox(action, length, number)
    if action then
        local editbox = guiCreateEdit(0, 0, 0, 0, '')
        if length then
            guiEditSetMaxLength(editbox, length)
        end
        edit[action] = editbox
    end
end

function removeEditbox(action)
    if action == 'all' then
        for _, v in pairs(edit) do
            if isElement(v) then
                destroyElement(v)
            end
        end
        edit = {}
    else
        if isElement(edit[action]) then
            destroyElement(edit[action])
            edit[action] = nil
        end
    end
end

function setEditboxEditing(action)
    local editbox = edit[action]
    if editbox and guiEditSetCaretIndex(editbox, utfLen(guiGetText(editbox))) then
        guiBringToFront(editbox)
        guiSetInputMode('no_binds_when_editing')
        select = action
    end
end

function getEditboxValue(action, drawing)
    local editbox = edit[action]
    if editbox then
        local edittext = guiGetText(editbox)
        if drawing then
            if select == action then
                return edittext .. '|'
            else
                return edittext == '' and action or edittext
            end
        else
            return edittext
        end
    end
end

function createEditbox(action, length, number)
    if action then
        local editbox = guiCreateEdit(0, 0, 0, 0, '')
        if length then
            guiEditSetMaxLength(editbox, length)
        end
        edit[action] = editbox
    end
end

function removeEditbox(action)
    if action == 'all' then
        for _, v in pairs(edit) do
            if isElement(v) then
                destroyElement(v)
            end
        end
        edit = {}
    else
        if isElement(edit[action]) then
            destroyElement(edit[action])
            edit[action] = nil
        end
    end
end

function setEditboxEditing(action)
    local editbox = edit[action]
    if editbox and guiEditSetCaretIndex(editbox, utfLen(guiGetText(editbox))) then
        guiBringToFront(editbox)
        guiSetInputMode('no_binds_when_editing')
        select = action
    end
end

function getEditboxValue(action, drawing)
    local editbox = edit[action]
    if editbox then
        local edittext = guiGetText(editbox)
        if drawing then
            if select == action then
                return edittext .. '|'
            else
                return edittext == '' and action or edittext
            end
        else
            return edittext
        end
    end
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