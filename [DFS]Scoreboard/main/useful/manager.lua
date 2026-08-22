screenWidth, screenHeight = guiGetScreenSize ();
screenScale = math.min (math.max (0.65, (screenHeight / 1080)), 1.5);

cursors = {0, 0}

function respc (value)
    return value * screenScale;
end;

_dxDrawText = dxDrawText
function dxDrawText (label, x, y, width, height, ...)
    return _dxDrawText (label, x, y, x + width, y + height, ...)
end

elements = {}

elements.fonts = {}
elements.images = {}
elements.svgs = {}


_dxCreateFont = dxCreateFont
function dxCreateFont (archive, size, ...)
    if elements.fonts[archive] and elements.fonts[archive][size] then
        return elements.fonts[archive][size]
    end

    if not elements.fonts[archive] then
        elements.fonts[archive] = {}
    end

    elements.fonts[archive][size] = _dxCreateFont (archive, respc (size) * (72 / 96))
    return elements.fonts[archive][size]
end

_dxDrawImage = dxDrawImage
function dxDrawImage (x, y, width, height, archive, ...)
    if isElement (archive) then
        _dxDrawImage (x, y, width, height, archive, ...)

        return true
    end

    local archive = (archive:find (':') and archive or 'assets/ui/' .. archive)

    if elements.images[archive] then
        return _dxDrawImage (x, y, width, height, elements.images[archive], ...)
    end

    elements.images[archive] = dxCreateTexture (archive, 'argb', true, 'clamp')
    
    return _dxDrawImage (x, y, width, height, elements.images[archive], ...)
end

function dxDrawImageSpacing (x, y, width, height, space, archive, ...)
    local padding = space * 2;

    return dxDrawImage (x - space, y - space, width + padding, height + padding, archive, ...)
end


svg = {
	['bg'] = svgCreate(125, 40, 
		[[
            <svg width="125" height="55" viewBox="0 0 125 55" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M0 15C0 6.71573 6.71573 0 15 0H110C118.284 0 125 6.71573 125 15V40C125 48.2843 118.284 55 110 55H15C6.71573 55 0 48.2843 0 40V15Z" fill="white"/>
            </svg>                     
		]]
	),

}

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