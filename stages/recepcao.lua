luaDebugMode = true

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local leftKey = getModSetting('keyLeft')
local rightKey = getModSetting('keyRight')
local acceptKey = getModSetting('keyAccept')
local runKey = getModSetting('keyRun')

local clicavel = false

local pintoes = parseJson('data/recepcao/dicks.json')
local bucetoes = parseJson('data/recepcao/pussy.json')

local enableCam = false
local camX = 1
local camY = 0.76
local veloSom = 0.31
local velo = 6
local moveAnim = 'walk'
local moveLeft = true
local moveRight = true

local bct = 1
local quanto = 1
local ativado = false
local curTag = 1
local tags = {'bg', 'elevador'}
local maxTagNum = 2

function onStartCountdown()
    
    setProperty("dadGroup.visible", false)
    setProperty("botplayTxt.visible", false)
    triggerEvent("Camera Follow Pos", pintoes.camera_offset[1], pintoes.camera_offset[2])
    return Function_Stop;
end

function onCreate()

    if not isRunning("mods/PaperMania/scripts/disabled/callbacks.lua") then
        addLuaScript("scripts/disabled/callbacks")
    end

    playMusic("yeahresident", 0, true)
	
    setCharacterX("boyfriend", pintoes.spawn[1])
    setCharacterY("boyfriend", pintoes.spawn[2])

    makeLuaSprite("bg", 'bg/recepcao/recepbg', bucetoes.bg[1], bucetoes.bg[2])
    scaleObject("bg", 1.95, 1.95)
    addLuaSprite("bg", false)

    makeAnimatedLuaSprite("elevador", 'bg/recepcao/elevador', bucetoes.eleva[1], bucetoes.eleva[2])
    addAnimationByPrefix("elevador", "idle", "loop", 5, true)
    scaleObject("elevador", 3, 3)
    addLuaSprite("elevador", false)

    makeLuaText("bucetas", "", 0, 0.0, 0.0)
    setObjectCamera("bucetas", 'other')
    setTextSize("bucetas", 20)
    setTextAlignment("bucetas", 'left')
    addLuaText("bucetas")
    runTimer("ajeitar", 0.2)
end

function onUpdate(elapsed)

    if keyboardPressed(runKey.keyboard) or anyGamepadPressed(runKey.gamepad) then
        velo = 12
        veloSom = 0.2
        moveAnim = 'run'
    else
        velo = 6
        veloSom = 0.31
        moveAnim = 'walk'
    end

    if getProperty("boyfriend.x") <= 530 then
        enableCam = false
        camX = 908.5
        camY = 698.82
    elseif getProperty("boyfriend.x") >= 3812 then
        enableCam = false
        camX = 4190.5
        camY = 698.82
    else
        enableCam = true
        camX = 1
        camY = 0.76
    end

    if getProperty("boyfriend.x") <= -508 then
        stopMove('boyfriend', 'idle')
        moveLeft = false
    elseif getProperty("boyfriend.x") >= 4946 then
        stopMove('boyfriend', 'idle')
        moveRight = false
    else
        moveLeft = true
        moveRight = true
    end

    if keyboardPressed(rightKey.keyboard) and moveRight or anyGamepadPressed(rightKey.gamepad) and moveRight then
        charMove('boyfriend', moveAnim, 'right', velo, false, false, 0, 0)
        setCamOffset('boyfriend', camX, camY, enableCam)
        useWalkSound(true, 'walk', veloSom)
    elseif keyboardReleased(rightKey.keyboard) or anyGamepadReleased(rightKey.gamepad) then
        stopMove('boyfriend', 'idle')

    elseif keyboardPressed(leftKey.keyboard) and moveLeft or anyGamepadPressed(leftKey.gamepad) and moveLeft then
        charMove('boyfriend', moveAnim, 'left', velo, true, false, 60, 0)
        setCamOffset('boyfriend', camX, camY, enableCam)
        useWalkSound(true, 'walk', veloSom)
    elseif keyboardReleased(leftKey.keyboard) or anyGamepadReleased(leftKey.gamepad) then
        stopMove('boyfriend', 'idle')
    end

    if keyJustPressed('back') then
        exitSong(false)
    end

    if getProperty("boyfriend.x") >= 4192 then
        keyShit('in')
    else
        keyShit('out')
    end

    if keyboardJustPressed("Q") then
        bct = bct + 1
    elseif keyboardJustPressed("W") then
        curTag = curTag - 1
    elseif keyboardJustPressed("E") then
        curTag = curTag + 1
    end
    
    if bct == 2 then
        ativado = true
    elseif bct == 1 then
        ativado = false
    elseif bct > 2 then
        bct = 1
    end

    if curTag > maxTagNum then
        curTag = 1
    elseif curTag < 1 then
        curTag = maxTagNum
    end

    if keyboardJustPressed("J") and ativado then
        setProperty(tags[curTag]..".x", getProperty(tags[curTag]..".x") - quanto)
    elseif keyboardJustPressed("L") and ativado then
        setProperty(tags[curTag]..".x", getProperty(tags[curTag]..".x") + quanto)
    elseif keyboardJustPressed("I") and ativado then
        setProperty(tags[curTag]..".y", getProperty(tags[curTag]..".y") - quanto)
    elseif keyboardJustPressed("K") and ativado then
        setProperty(tags[curTag]..".y", getProperty(tags[curTag]..".y") + quanto)

    elseif keyboardPressed("J") and keyboardPressed("ALT") and ativado then
        setProperty(tags[curTag]..".x", getProperty(tags[curTag]..".x") - quanto)
    elseif keyboardPressed("L") and keyboardPressed("ALT") and ativado then
        setProperty(tags[curTag]..".x", getProperty(tags[curTag]..".x") + quanto)
    elseif keyboardPressed("I") and keyboardPressed("ALT") and ativado then
        setProperty(tags[curTag]..".y", getProperty(tags[curTag]..".y") - quanto)
    elseif keyboardPressed("K") and keyboardPressed("ALT") and ativado then
        setProperty(tags[curTag]..".y", getProperty(tags[curTag]..".y") + quanto)

    elseif keyboardJustPressed("R") and ativado then
        setProperty("bg.x", bucetoes.bg[1])
        setProperty("bg.y", bucetoes.bg[2])
        setProperty("elevador.x", bucetoes.eleva[1])
        setProperty("elevador.y", bucetoes.eleva[2])
    elseif keyboardPressed("CONTROL") and keyboardJustPressed("S") and ativado then
        saveFile('mods/PaperMania/data/recepcao/pussy.json', '{\n    "bg": ['..getProperty("bg.x")..', '..getProperty("bg.y")..'],\n    "eleva": ['..getProperty("elevador.x")..', '..getProperty("elevador.y")..']\n}', true)
        debugPrint('                                                               Arquivo salvo', '00ff00')
    end

    if keyboardPressed("CONTROL") then
        quanto = 10
    else
        quanto = 1
    end

    if ativado then
        setTextString("bucetas", "Debug info:\nEdit mode: "..string.upper(tostring(ativado))..'\nObj selecionado: '..string.upper(tags[curTag])..'\nObj X: '..getProperty(tags[curTag]..".x")..'\nObj Y: '..getProperty(tags[curTag]..".y")..'\n\nPlayer info:\nBF X: '..getProperty("boyfriend.x")..'\nBF Y: '..getProperty("boyfriend.y")..'\n\nCamera info:\nCam X: '..getCameraFollowX()..'\nCam Y: '..getCameraFollowY())
        screenCenter("bucetas", 'y')
    else
        setTextString("bucetas", '')
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'ajeitar' then
        setProperty("cameraSpeed", 1)
    end
end