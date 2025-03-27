function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local parsed = parseJson('pack.json')
local ogCam = 1
local num = 0.1
local n = 0
local camX = nil
local camY = nil
local b = nil

function onCreate()

    if getModSetting("info") then
        makeLuaText("debug", "", 0, 0.0, 15)
        setTextSize("debug", 20)
        addLuaText("debug")
    end
end

function onCountdownStarted()
    
    if getModSetting("butt") then
        debugPrint([[
                                   butões de debug:
    ] - aumenta a velocidade (se segurar SHIFT irá aumentar menos 0.05 ao invés de 0.1)

    [ - diminui a velocidade (se segurar SHIFT irá diminuir menos 0.05 ao invés de 0.1)

    F5 - reinicia a música

    1 - mostra todos os scripts rodando

    2 - esconde a hud

    4 - sai da música

    5 - liga/desliga o botplay

    I - dá zoom in (se a opção de câmera livre tiver ativada)

    O - dá zoom out (se a opção de câmera livre tiver ativada)

    W, A, S, D - movimenta a câmera (se a opção de câmera livre tiver ativada)

    SETA PRA DIREITA - pula 5 segundos da música (se segurar SHIFT + seta pra direita irá pular constantemente)

    SETA PRA ESQUERDA - volta 5 segundos da música (se segurar SHIFT + seta pra direita irá pular constantemente)

    BACKSPACE - reseta velocidade, zoom e câmera

    ESPAÇO - mostra essa mensagem de instrução novamente
        ]], '00FF00')
    end

    if botPlay then
        b = 1
    else
        b = 2
    end
end

function onUpdate(elapsed)

    camX = getCameraFollowX() -- x da camera
    camY = getCameraFollowY()

    velo = 1
    
    if keyboardPressed("SHIFT") then
        num = 0.05
    else
        num = 0.1
    end

    if keyboardJustPressed("LBRACKET") and getModSetting("butt") then
        setProperty("playbackRate", playbackRate - num)
        debugPrint('velocidade agora está em: '..playbackRate..'x', 'FFA500')
    elseif keyboardJustPressed("RBRACKET") and getModSetting("butt") then
        setProperty("playbackRate", playbackRate + num)
        debugPrint('velocidade agora está em: '..playbackRate..'x', 'FFA500')
    elseif keyboardJustPressed("BACKSPACE") and getModSetting("butt") then
        setProperty("playbackRate", tonumber(velo))
        setProperty("defaultCamZoom", ogCam.defaultZoom)
        triggerEvent("Camera Follow Pos", '', '')
        debugPrint('velocidade, zoom e câmera foram resetados')
    elseif keyboardJustPressed("ONE") and getModSetting("butt") then
        debugPrint(getRunningScripts(), 'FE86A4')
    elseif keyboardJustPressed("TWO") and getModSetting("butt") then
        n = n + 1
    elseif keyboardJustPressed("F5") and getModSetting("butt") then
        stopSound("bgm")
        restartSong(false)
    elseif keyboardJustPressed("FOUR") and getModSetting("butt") then
        exitSong(false)
    elseif keyboardJustPressed("FIVE") and getModSetting("butt") then
        b = b + 1
    elseif keyboardPressed("I") and getModSetting("butt") and getModSetting("livre") then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.01)
    elseif keyboardPressed("O") and getModSetting("butt") and getModSetting("livre") then
        setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.01)
    elseif keyboardPressed("W") and getModSetting("butt") and getModSetting("livre") then
        camY = camY - 10
        triggerEvent("Camera Follow Pos", camX, camY)
    elseif keyboardPressed("A") and getModSetting("butt") and getModSetting("livre") then
        camX = camX - 10
        triggerEvent("Camera Follow Pos", camX, camY)
    elseif keyboardPressed("S") and getModSetting("butt") and getModSetting("livre") then
        camY = camY + 10
        triggerEvent("Camera Follow Pos", camX, camY)
    elseif keyboardPressed("D") and getModSetting("butt") and getModSetting("livre") then
        camX = camX + 10
        triggerEvent("Camera Follow Pos", camX, camY)
    elseif keyboardPressed("RIGHT") and getModSetting("butt") and keyboardPressed("SHIFT") and songName ~= 'cum' then
        setSongPosition(getSongPosition() + 500)
    elseif keyboardPressed("LEFT") and getModSetting("butt") and keyboardPressed("SHIFT") and songName ~= 'cum' then
        setSongPosition(getSongPosition() - 500)
    elseif keyboardJustPressed("RIGHT") and getModSetting("butt") and not keyboardPressed("SHIFT") and songName ~= 'cum' then
        setSongPosition(getSongPosition() + 5000)
    elseif keyboardJustPressed("LEFT") and getModSetting("butt") and not keyboardPressed("SHIFT") and songName ~= 'cum' then
        setSongPosition(getSongPosition() - 5000)
    elseif keyboardJustPressed("SPACE") and getModSetting("butt") then
        debugPrint([[
                                   butões de debug:
    ] - aumenta a velocidade (se segurar SHIFT irá aumentar menos 0.05 ao invés de 0.1)

    [ - diminui a velocidade (se segurar SHIFT irá diminuir menos 0.05 ao invés de 0.1)

    F5 - reinicia a música

    1 - mostra todos os scripts rodando

    2 - esconde a hud

    4 - sai da música

    5 - liga/desliga o botplay

    I - dá zoom in (se a opção de câmera livre tiver ativada)

    O - dá zoom out (se a opção de câmera livre tiver ativada)

    W, A, S, D - movimenta a câmera (se a opção de câmera livre tiver ativada)

    SETA PRA DIREITA - pula 5 segundos da música (se segurar SHIFT + seta pra direita irá pular constantemente)

    SETA PRA ESQUERDA - volta 5 segundos da música (se segurar SHIFT + seta pra direita irá pular constantemente)

    BACKSPACE - reseta velocidade, zoom e câmera

    ESPAÇO - mostra essa mensagem de instrução novamente
        ]], '00FF00')
    end

    if playbackRate < 0.1 then
        setProperty("playbackRate", 0.1)
    elseif n == 0 then
        setProperty("camHUD.visible", true)
    elseif n == 1 then
        setProperty("camHUD.visible", false)
    elseif n > 1 then
        n = 0
    end
    if b % 2 == 0 then
        setProperty("cpuControlled", false)
        setProperty("botplayTxt.visible", false)
    else
        setProperty("cpuControlled", true)
        setProperty("botplayTxt.visible", true)
    end
end

function onUpdatePost(elapsed)
    
    if getModSetting("info") and getModSetting("livre") then
    setTextString("debug", 'curSection: '..curSection.." | curStep: "..curStep..' | curBeat: '..curBeat..' | defaultCamZoom: '..getProperty("defaultCamZoom")..' | cameraX: '..cameraX..' | cameraY: '..cameraY)
    screenCenter("debug", 'x')
    elseif getModSetting("info") and not getModSetting("livre") then
    setTextString("debug", 'curSection: '..curSection.." | curStep: "..curStep..' | curBeat: '..curBeat)
    screenCenter("debug", 'x')
end
end