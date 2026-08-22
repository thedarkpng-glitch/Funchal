local screenWidth, screenHeight = guiGetScreenSize()

local myScreenSource
local watermark
local enabled = false

addEventHandler("onClientResourceStart", resourceRoot, function()

    myScreenSource = dxCreateScreenSource(screenWidth, screenHeight)

    -- Carrega a imagem
    watermark = dxCreateTexture("image.png")
end)

function cleanmyscreen()

    if not enabled then
        return
    end

    -- Tela
    if myScreenSource then
        dxUpdateScreenSource(myScreenSource)

        dxDrawImage(
            0,
            0,
            screenWidth,
            screenHeight,
            myScreenSource,
            0, 0, 0,
            tocolor(255, 255, 255, 255),
            true
        )
    end

    -- =====================================================
    -- MARCA D'ÁGUA
    -- =====================================================

    if watermark then

        local originalW, originalH = dxGetMaterialSize(watermark)

        -- Largura desejada
        local imageW = 180

        -- Mantém a proporção original
        local imageH = imageW * (originalH / originalW)

        -- Canto superior direito
        local imageX = screenWidth - imageW - 20
        local imageY = 5

        dxDrawImage(
            imageX,
            imageY,
            imageW,
            imageH,
            watermark,
            0, 0, 0,
            tocolor(255, 255, 255, 230),
            true
        )
    end
end

function tooglecleanmyscreen()

    enabled = not enabled

    if enabled then

        playSound("music.wav")

        addEventHandler(
            "onClientRender",
            root,
            cleanmyscreen
        )

    else

        playSound("music.wav")

        removeEventHandler(
            "onClientRender",
            root,
            cleanmyscreen
        )
    end
end

bindKey("F10", "down", tooglecleanmyscreen)