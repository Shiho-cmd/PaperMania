luaDebugMode = true

local bucetoes

local inte

function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

function createNPC(tag, path, x, y, scaleX, scaleY, interactable, animated, front, updateHB)

    if not animated then
        makeLuaSprite(tag, path, x, y)
        scaleObject(tag, scaleX, scaleY, updateHB)
        addLuaSprite(tag, front)
        inte = tostring(interactable)..tag
    else
        makeAnimatedLuaSprite(tag, path, x, y)
        scaleObject(tag, scaleX, scaleY, updateHB)
        addLuaSprite(tag, front)
        inte = tostring(interactable)..tag
    end
end

function npcInteract(tag)

    if inte == 'true'..tag then
        return true;
    else
        return false;
    end
end

local leftKey = getModSetting('keyLeft')
local rightKey = getModSetting('keyRight')
local acceptKey = getModSetting('keyAccept')
local runKey = getModSetting('keyRun')

local podePORRA = true

local room = 'otisRoom'

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
local quantoScale = 0.1
local ativado = false
local curTag = 1

local help = 1

local exit

function onStartCountdown()
    
    setProperty("dadGroup.visible", false)
    setProperty("botplayTxt.visible", false)
    return Function_Stop;
end

function onCreate()

    initSaveData('saveData-'..difficultyName, 'PaperMania')

    precacheImage("bg/recepcao/toby")
    precacheImage("bg/recepcao/elevador")
    precacheImage("bg/recepcao/recepbg")
    precacheSound("toby_bark")
    precacheSound("yeahresident")

    debugPrint(getTranslationPhrase('helpTextSplash', '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nPress F1 for help!'), 'FFA500')

    playSound("yeahresident", 0.5, 'bgm', true)

    makeLuaText("bucetas", "", 0, 0.0, 0.0)
    setObjectCamera("bucetas", 'other')
    setTextSize("bucetas", 20)
    setTextAlignment("bucetas", 'left')
    addLuaText("bucetas")

    makeLuaText("penis", getTranslationPhrase('helpText', 'Movement: {1}, {2} / {5}, {6}\n\nRun: {3} / {7}\n\nInteract: {4} / {8}', {leftKey.keyboard, rightKey.keyboard, runKey.keyboard, acceptKey.keyboard, leftKey.gamepad, rightKey.gamepad, runKey.gamepad, acceptKey.gamepad}), 0, 0.0, 0.0)
    setObjectCamera("penis", 'other')
    setTextSize("penis", 40)
    setTextAlignment("penis", 'center')
    screenCenter("penis")
    setProperty("penis.alpha", 0.00001)
    addLuaText("penis")

    makeLuaSprite("back")
    makeGraphic("back", screenWidth, screenHeight, '000000')
    setObjectCamera("back", 'other')
    setProperty("back.alpha", 0.00001)
    addLuaSprite("back", false)

    makeLuaText('save', '', 0, 0, screenHeight - 35)
    setObjectCamera('save', 'other')
    setTextSize('save', 35)
    setProperty('save.alpha', 0.0001)
    addLuaText('save')

    runTimer("ajeitar", 0.2)

    setVar('recepcaoTags', {'bg', 'elevador', 'tober'})
    setVar('otisRoomTags', {'bgOtis', 'otis', 'sofa'})
end

function onCreatePost()

    if getDataFromSave('saveData-'..difficultyName, 'room', 'recepcao') == 'recepcao' then

        room = 'recepcao'

        bucetoes = parseJson('data/cum/rooms/'..room..'/metadata.json')

        makeLuaSprite("bg", 'bg/recepcao/recepbg', bucetoes.positions[1].bg[1], bucetoes.positions[1].bg[2])
        scaleObject("bg", bucetoes.positions[1].bg[3], bucetoes.positions[1].bg[4])
        addLuaSprite("bg", false)
        
        -- tag, path, x, y, scaleX, scaleY, interactable, animated, front, updateHB
        createNPC('tober', 'characters/overworld/recepcao/toby', bucetoes.positions[1].tober[1], bucetoes.positions[1].tober[2], bucetoes.positions[1].tober[3], bucetoes.positions[1].tober[4], true, true, false, true)
        addAnimationByPrefix("tober", "idle", "idle", 6, true)

        makeAnimatedLuaSprite("elevador", 'bg/elevador', bucetoes.positions[1].eleva[1], bucetoes.positions[1].eleva[2])
        addAnimationByPrefix("elevador", "idle", "loop", 6, true)
        scaleObject("elevador", bucetoes.positions[1].eleva[3], bucetoes.positions[1].eleva[4])
        addLuaSprite("elevador", false)

    elseif getDataFromSave('saveData-'..difficultyName, 'room', 'recepcao') == 'otisRoom' then

        room = 'otisRoom'

        bucetoes = parseJson('data/cum/rooms/otisRoom/metadata.json')

        makeLuaSprite("bgOtis", 'bg/otis/quarto_Otis', bucetoes.positions[1].bg[1], bucetoes.positions[1].bg[2])
        scaleObject("bgOtis", bucetoes.positions[1].bg[3], bucetoes.positions[1].bg[4])
        addLuaSprite("bgOtis", false)
        
        -- tag, path, x, y, scaleX, scaleY, interactable, animated, front, updateHB
        createNPC('otis', 'characters/overworld/otis/otis', bucetoes.positions[1].otis[1], bucetoes.positions[1].otis[2], bucetoes.positions[1].otis[3], bucetoes.positions[1].otis[4], true, true, false, true)
        addAnimationByPrefix("otis", "idle", "idle", 6, true)

        makeLuaSprite("sofa", 'bg/otis/sofa', bucetoes.positions[1].sofa[1], bucetoes.positions[1].sofa[2])
        scaleObject("sofa", bucetoes.positions[1].sofa[3], bucetoes.positions[1].sofa[4])
        setScrollFactor('sofa', 1.3, 1.3)
        addLuaSprite("sofa", true)
    end

    setProperty("boyfriend.x", getDataFromSave('saveData-'..difficultyName, 'bfX', -490))
    setProperty("boyfriend.y", getDataFromSave('saveData-'..difficultyName, 'bfY', 330))
    setProperty("boyfriend.flipX", getDataFromSave('saveData-'..difficultyName, 'bfFlipX', false))
    triggerEvent("Camera Follow Pos", getDataFromSave('saveData-'..difficultyName, 'startCamX', 902.5), getDataFromSave('saveData-'..difficultyName, 'startCamY', 698.82))
end

function onUpdate(elapsed)

    if keyboardJustPressed("F1") then
        help = help + 1
    end

    if help > 2 then
        help = 1
    end

    if help == 2 then
        podePORRA = false
        doTweenAlpha("pinto", "penis", 1, 0.3, "linear")
        doTweenAlpha("bucetudo", "back", 0.5, 0.3, "linear")
    elseif help == 1 then
        podePORRA = true
        doTweenAlpha("pinto", "penis", 0.00001, 0.1, "linear")
        doTweenAlpha("bucetudo", "back", 0.00001, 0.1, "linear")
    end

    if keyboardPressed(runKey.keyboard) or anyGamepadPressed(runKey.gamepad) then
        velo = 12
        veloSom = 0.2
        moveAnim = 'run'
    else
        velo = 6
        veloSom = 0.31
        moveAnim = 'walk'
    end

    if podePORRA then

        if room == 'recepcao' then

            if getProperty("boyfriend.x") <= bucetoes.hitboxes[1].cam[1] then
                enableCam = false
                camX = bucetoes.hitboxes[1].cam[3]
                camY = 698.82
            elseif getProperty("boyfriend.x") >= bucetoes.hitboxes[1].cam[2] then
                enableCam = false
                camX = bucetoes.hitboxes[1].cam[4]
                camY = 698.82
            else
                enableCam = true
                camX = 1
                camY = 0.76
            end
        
            if getProperty("boyfriend.x") <= bucetoes.hitboxes[1].conners[1] then
                stopMove('boyfriend', 'idle')
                moveLeft = false
            elseif getProperty("boyfriend.x") >= bucetoes.hitboxes[1].conners[2] then
                stopMove('boyfriend', 'idle')
                moveRight = false
            else
                moveLeft = true
                moveRight = true
            end
    
            if getProperty("boyfriend.x") >= bucetoes.hitboxes[1].conners[2] then
                keyShit('in')
    
                if keyboardJustPressed(acceptKey.keyboard) and npcInteract('tober') and podePORRA then
                    playSound("toby_bark", 1, 'bark')
                    setSoundPitch('bark', getRandomFloat(1.3, 0.7))
                end
            elseif getProperty("boyfriend.x") >= bucetoes.hitboxes[1].eleva[1] and getProperty("boyfriend.x") < bucetoes.hitboxes[1].eleva[2] then
                keyShit('in')
    
                if keyboardJustPressed(acceptKey.keyboard) and podePORRA then
                    podePORRA = false
                    playAnim("trans", 'open')
                    setProperty("trans.alpha", 1)
                    playSound("paperIn", 1, 'inOtis')
                    soundFadeOut('bgm', 0.3, 0)
                    playMusic('breakfast', 0, true)
                    soundFadeIn(_, 0.3, 0, 1)    
                end
            else
                keyShit('out')
            end
    
        elseif room == 'otisRoom' then
            
            if getProperty("boyfriend.x") <= bucetoes.hitboxes[1].cam[1] then
                enableCam = false
                camX = bucetoes.hitboxes[1].cam[3]
                camY = 698.82
            elseif getProperty("boyfriend.x") >= bucetoes.hitboxes[1].cam[2] then
                enableCam = false
                camX = bucetoes.hitboxes[1].cam[4]
                camY = 698.82
            else
                enableCam = true
                camX = 1
                camY = 0.76
            end
        
            if getProperty("boyfriend.x") <= bucetoes.hitboxes[1].conners[1] then
                stopMove('boyfriend', 'idle')
                moveLeft = false
            elseif getProperty("boyfriend.x") >= bucetoes.hitboxes[1].conners[2] then
                stopMove('boyfriend', 'idle')
                moveRight = false
            else
                moveLeft = true
                moveRight = true
            end
    
            if getProperty("boyfriend.x") >= bucetoes.hitboxes[1].otis[1] and getProperty("boyfriend.x") < bucetoes.hitboxes[1].otis[2] then
                keyShit('in')
            else
                keyShit('out')
            end
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
        elseif keyJustPressed('back') then
            podePORRA = false
            exit = true
            setDataFromSave('saveData-'..difficultyName, 'bfX', getProperty("boyfriend.x"))
            setDataFromSave('saveData-'..difficultyName, 'bfY', getProperty("boyfriend.y"))
            setDataFromSave('saveData-'..difficultyName, 'bfFlipX', getProperty("boyfriend.flipX"))
            setDataFromSave('saveData-'..difficultyName, 'startCamX', getCameraFollowX())
            setDataFromSave('saveData-'..difficultyName, 'startCamY', getCameraFollowY())
            setDataFromSave('saveData-'..difficultyName, 'room', 'recepcao')
            removeLuaScript("scripts/callbacks")
            stopSound("out")
            stopSound("bgm")
            stopSound("walk")
            stopSound("bark")
            playAnim("trans", 'open')
            setProperty("trans.alpha", 1)
            playSound("paperIn", 1, 'in')
        elseif keyboardPressed("CONTROL") and keyboardJustPressed("S") then
            setTextString('save', getTranslationPhrase('saving', 'Saving {2}...', {'ARQUIVO '..string.gsub(difficultyName, "file", ""), 'FILE '..string.gsub(difficultyName, "file", "")}))
            setTextColor('save', 'FFFFFF')
            doTweenAlpha('sex', 'save', 1, 0.5, 'linear')
            playAnim("trans", 'open')
            setProperty("trans.alpha", 1)
            playSound("paperIn", 1, 'in')
            soundFadeOut('bgm', 0.3, 0)
            playMusic('breakfast', 0, true)
            soundFadeIn(_, 0.3, 0, 1)
        end
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

    if curTag > #getVar(room..'Tags') then
        curTag = 1
    elseif curTag < 1 then
        curTag = #getVar(room..'Tags')
    end

    if keyboardJustPressed("J") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".x", getProperty(getVar(room..'Tags')[curTag]..".x") - quanto)
    elseif keyboardJustPressed("L") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".x", getProperty(getVar(room..'Tags')[curTag]..".x") + quanto)
    elseif keyboardJustPressed("I") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".y", getProperty(getVar(room..'Tags')[curTag]..".y") - quanto)
    elseif keyboardJustPressed("K") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".y", getProperty(getVar(room..'Tags')[curTag]..".y") + quanto)

    elseif keyboardPressed("J") and keyboardPressed("ALT") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".x", getProperty(getVar(room..'Tags')[curTag]..".x") - quanto)
    elseif keyboardPressed("L") and keyboardPressed("ALT") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".x", getProperty(getVar(room..'Tags')[curTag]..".x") + quanto)
    elseif keyboardPressed("I") and keyboardPressed("ALT") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".y", getProperty(getVar(room..'Tags')[curTag]..".y") - quanto)
    elseif keyboardPressed("K") and keyboardPressed("ALT") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".y", getProperty(getVar(room..'Tags')[curTag]..".y") + quanto)

    elseif keyboardJustPressed("PLUS") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".scale.x", getProperty(getVar(room..'Tags')[curTag]..".scale.x") + quantoScale)
        setProperty(getVar(room..'Tags')[curTag]..".scale.y", getProperty(getVar(room..'Tags')[curTag]..".scale.y") + quantoScale)
        updateHitbox(getVar(room..'Tags')[curTag])
    elseif keyboardJustPressed("MINUS") and ativado then
        setProperty(getVar(room..'Tags')[curTag]..".scale.x", getProperty(getVar(room..'Tags')[curTag]..".scale.x") - quantoScale)
        setProperty(getVar(room..'Tags')[curTag]..".scale.y", getProperty(getVar(room..'Tags')[curTag]..".scale.y") - quantoScale)
        updateHitbox(getVar(room..'Tags')[curTag])

    elseif keyboardJustPressed("R") and ativado then
        setProperty("bg.x", bucetoes.bg[1])
        setProperty("bg.y", bucetoes.bg[2])
        scaleObject("bg", bucetoes.bg[3], bucetoes.bg[4])
        setProperty("elevador.x", bucetoes.eleva[1])
        setProperty("elevador.y", bucetoes.eleva[2])
        setProperty("tober.x", bucetoes.tober[1])
        setProperty("tober.y", bucetoes.tober[2])
    end

    if keyboardPressed("CONTROL") then
        quanto = 10
        quantoScale = 0.1
    else
        quanto = 1
        quantoScale = 0.01
    end

    if ativado then
        setTextString("bucetas", "Debug info:\nEdit mode: "..string.upper(tostring(ativado))..'\nObj selecionado: '..string.upper(getVar(room..'Tags')[curTag])..'\nObj X: '..getProperty(getVar(room..'Tags')[curTag]..".x")..'\nObj Y: '..getProperty(getVar(room..'Tags')[curTag]..".y")..'\nObj Scale: '..getProperty(getVar(room..'Tags')[curTag]..".scale.x")..'\n\nPlayer info:\nBF X: '..getProperty("boyfriend.x")..'\nBF Y: '..getProperty("boyfriend.y")..'\n\nCamera info:\nCam X: '..getCameraFollowX()..'\nCam Y: '..getCameraFollowY())
        screenCenter("bucetas", 'y')
    else
        setTextString("bucetas", '')
    end
end

function onSoundFinished(tag)
    
    if tag == 'in' and exit then
        exitSong(false)
    elseif tag == 'in' and not exit then
        setDataFromSave('saveData-'..difficultyName, 'bfX', getProperty("boyfriend.x"))
        setDataFromSave('saveData-'..difficultyName, 'bfY', getProperty("boyfriend.y"))
        setDataFromSave('saveData-'..difficultyName, 'bfFlipX', getProperty("boyfriend.flipX"))
        setDataFromSave('saveData-'..difficultyName, 'startCamX', getCameraFollowX())
        setDataFromSave('saveData-'..difficultyName, 'startCamY', getCameraFollowY())
        setDataFromSave('saveData-'..difficultyName, 'room', room)
        flushSaveData('saveData-'..difficultyName)
        setTextString('save', getTranslationPhrase('saved', 'Saved {2} successfully!', {'ARQUIVO '..string.gsub(difficultyName, "file", ""), 'FILE '..string.gsub(difficultyName, "file", "")}))
        setTextColor('save', '00FF00')
        doTweenAlpha('sex', 'save', 0.0001, 0.5, 'linear')
        playAnim("trans", 'close')
        playSound("paperOut", 1, 'out')
        soundFadeOut(_, 0.3, 0)
        soundFadeIn('bgm', 0.3, 0, 0.5)
        playSound('confirmMenu', 1)
    elseif tag == 'inOtis' then

        removeLuaSprite('bg')
        removeLuaSprite('elevador')
        removeLuaSprite('tober')

        room = 'otisRoom'

        bucetoes = parseJson('data/cum/rooms/otisRoom/metadata.json')

        setProperty('boyfriend.x', bucetoes.defaultPos[1])
        setProperty('cameraSpeed', 9999999999)
        setCamOffset('boyfriend', bucetoes.defaultPos[2], bucetoes.defaultPos[3], false)
        setProperty('boyfriend.flipX', false)

        makeLuaSprite("bgOtis", 'bg/otis/quarto_Otis', bucetoes.positions[1].bg[1], bucetoes.positions[1].bg[2])
        scaleObject("bgOtis", bucetoes.positions[1].bg[3], bucetoes.positions[1].bg[4])
        addLuaSprite("bgOtis", false)
        
        -- tag, path, x, y, scaleX, scaleY, interactable, animated, front, updateHB
        createNPC('otis', 'characters/overworld/otis/otis', bucetoes.positions[1].otis[1], bucetoes.positions[1].otis[2], bucetoes.positions[1].otis[3], bucetoes.positions[1].otis[4], true, true, false, true)
        addAnimationByPrefix("otis", "idle", "idle", 6, true)

        makeLuaSprite("sofa", 'bg/otis/sofa', bucetoes.positions[1].sofa[1], bucetoes.positions[1].sofa[2])
        scaleObject("sofa", bucetoes.positions[1].sofa[3], bucetoes.positions[1].sofa[4])
        setScrollFactor('sofa', 1.3, 1.3)
        addLuaSprite("sofa", true)

        runTimer('doneLoading', 0.5)

    elseif tag == 'out' then
        podePORRA = true
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'ajeitar' then
        setProperty("cameraSpeed", 1)
    elseif tag == 'doneLoading' then
        podePORRA = true
        playAnim("trans", 'close')
        playSound("paperOut", 1, 'out')
        soundFadeOut(_, 0.3, 0)
        soundFadeIn('bgm', 0.3, 0, 0.5)
        setProperty('cameraSpeed', 1)
    end
end

function onDestroy()
    
    flushSaveData('saveData-'..difficultyName)
end