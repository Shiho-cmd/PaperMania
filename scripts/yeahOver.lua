local veloCoiso = false
local numVaiAcaba = false
local podeClicar = false

function onCreate()
    
    makeLuaSprite('leEpicBlocoPreto')
    makeGraphic('leEpicBlocoPreto', screenWidth, screenHeight, '000000')
    setObjectCamera('leEpicBlocoPreto', 'other')
    setProperty('leEpicBlocoPreto.alpha', 0.000001)
    addLuaSprite('leEpicBlocoPreto', true)

    makeAnimatedLuaSprite('itsYeahOver', 'gameover/yeah-gameover')
    addAnimationByPrefix('itsYeahOver', 'loop', 'yeah', 5, true)
    setObjectCamera('itsYeahOver', 'other')
    screenCenter('itsYeahOver')
    setProperty('itsYeahOver.alpha', 0.000001)
    addLuaSprite('itsYeahOver', true)
end

function onUpdate(elapsed)

    if veloCoiso then
        numVaiAcaba = true
        setOnLuas('canOpenPause', false)
        callMethod('KillNotes')
        setProperty('playbackRate', playbackRate - 0.01)
        setProperty('leEpicBlocoPreto.alpha', getProperty('leEpicBlocoPreto.alpha') + 0.01)
    end

    if playbackRate <= 0.095 then
        veloCoiso = false
        setProperty('playbackRate', 1)
        setProperty('leEpicBlocoPreto.alpha', 1)
        openCustomSubstate('yeah...', true)
    end
end

function onGameOver()
    
    veloCoiso = true
    return Function_Stop;
end

function onPause()
    
    if veloCoiso then
        return Function_Stop;
    end
end

function onEndSong()
    
    if numVaiAcaba then
        return Function_Stop;
    end
end

function onCustomSubstateCreate(name)
    
    if name == 'yeah...' then
        podeClicar = true
        playSound('ymDeath', 1, 'dead')
        insertToCustomSubstate('itsYeahOver')
        insertToCustomSubstate('trans')
        doTweenAlpha('...haey', 'itsYeahOver', 1, 1, 'linear')
    end
end

function onCustomSubstateUpdate(name, elapsed)

    if name == 'yeah...' then
        if keyJustPressed('accept') and podeClicar then
            podeClicar = false
            stopSound('dead')
            playAnim("trans", 'open')
            setProperty("trans.alpha", 1)
            playSound("paperIn", 1, 'innn')
        elseif keyJustPressed('back') and podeClicar then
            podeClicar = false
            stopSound('dead')
            playAnim("trans", 'open')
            setProperty("trans.alpha", 1)
            playSound("paperIn", 1, 'innnn')
        end
    end
end

function onSoundFinished(tag)
    
    if tag == 'innn' then
        restartSong(true)
    elseif tag == 'innnn' then
        exitSong(true)
    end
end