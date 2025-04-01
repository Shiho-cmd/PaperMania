canOpenPause = true

local namesEsquer = {1, 3, 5, 7, 9, 11}
local namesDirei = {2, 4, 6, 8, 10, 12}

local options = {
    {'Resume instance 1', 1},
    {'Restart instance 1', 2},
    {'Options instance 1', 3},
    {'Quit instance 1', 4}
}

local curOpt = 1
local podeClicar = false

function onCreate()

    precacheImage('pausemenu/buttons')
    
    playSound('yeahPause', 0, 'pauseMusic', true)

    for i = 1, 12 do
        makeLuaText('SN'..i, songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' ', 0, 0, 0 + i * 60 - 67)
        setObjectCamera('SN'..i, 'other')
        setTextFont('SN'..i, 'Moderniz.otf')
        setTextSize('SN'..i, 60)
        setTextBorder('SN'..i, 0)
        setProperty('SN'..i..'.alpha', 0.000001)
        addLuaText('SN'..i)

        makeLuaText('SNB'..i, songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' '..songName..' ', 0, 0, 0 + i * 60 - 67)
        setObjectCamera('SNB'..i, 'other')
        setTextFont('SNB'..i, 'Moderniz.otf')
        setTextSize('SNB'..i, 60)
        setTextBorder('SNB'..i, 0)
        setProperty('SNB'..i..'.alpha', 0.000001)
        addLuaText('SNB'..i)
    end

    for j = 1, #namesEsquer do
        setProperty('SNB'..namesEsquer[j]..'.x', -getProperty('SN1.width'))
        setProperty('SNB'..namesDirei[j]..'.x', getProperty('SN2.width')) 
    end

    makeLuaSprite('vig', 'pausemenu/vignette')
    setObjectCamera('vig', 'other')
    screenCenter('vig')
    setProperty('vig.alpha', 0.000001)
    addLuaSprite('vig', true)

    makeLuaSprite('album', 'default')
    setObjectCamera('album', 'other')
    scaleObject('album', 0.7, 0.7)
    setProperty('album.angle', 90)
    screenCenter('album', 'y')
    setProperty('album.x', screenWidth)
    addLuaSprite('album', true)

    makeAnimatedLuaSprite("transss", 'transition/transition', 0, 0)
    addAnimationByPrefix("transss", "loop", "Loop", 24, true)
    addAnimationByPrefix("transss", "open", "Open", 24, false)
    addAnimationByPrefix("transss", "close", "Close", 24, false)
    scaleObject("transss", 1.2, 1.2)
    setObjectCamera("transss", 'other')
    screenCenter("transss")
    setProperty('transss.alpha', 0.000001)
    addLuaSprite("transss", true)
end

function onPause()
    
    if canOpenPause then
        openCustomSubstate('yeahPau', true) -- heh pau
        return Function_Stop;
    end
end

function onCustomSubstateCreate(name)
    
    if name == 'yeahPau' then
        for gaySex = 1, #options do
            makeAnimatedLuaSprite('the'..gaySex, 'pausemenu/buttons', -408, 0 + gaySex * 150 - 70)
            addAnimationByPrefix('the1', 'resume', options[1][1], 5, true)
            addAnimationByPrefix('the2', 'restart', options[2][1], 5, true)
            addAnimationByPrefix('the3', 'options', options[3][1], 5, true)
            addAnimationByPrefix('the4', 'quit', options[4][1], 5, true)
            setObjectCamera('the'..gaySex, 'other')
            addLuaSprite('the'..gaySex, true)
        end

        podeClicar = true

        insertToCustomSubstate('the1')
        insertToCustomSubstate('the2')
        insertToCustomSubstate('the3')
        insertToCustomSubstate('the4')
        insertToCustomSubstate('transss')

        playSound('pauseopen', 1)

        setProperty('album.alpha', 1)
        setProperty('album.x', screenWidth)

        soundFadeIn('pauseMusic', 1, 0, 0.5)
        doTweenAlpha('bgFadeIn', 'leEpicBlocoPreto', 0.5, 0.3, 'linear')

        doTweenAlpha('vikers', 'vig', 1, 0.3, 'linear')

        doTweenX('funnyAlbum', 'album', getProperty('album.width') + 110, 1, 'quartOut')
        doTweenAngle('albumFunny', 'album', 10, 1, 'quartOut')

        doTweenX('opts', 'the1', 30, 1, 'quartOut')
        doTweenX('optss', 'the2', 30, 1, 'quartOut')
        doTweenX('optsss', 'the3', 30, 1, 'quartOut')
        doTweenX('optssss', 'the4', 30, 1, 'quartOut')

        doTweenAlpha('esquer1', 'SN1', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer2', 'SN2', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer3', 'SN3', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer4', 'SN4', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer5', 'SN5', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer6', 'SN6', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer7', 'SN7', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer8', 'SN8', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer9', 'SN9', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer10', 'SN10', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer11', 'SN11', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer12', 'SN12', 0.15, 0.3, 'linear')

        doTweenAlpha('esquer69', 'SNB1', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer22', 'SNB2', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer33', 'SNB3', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer44', 'SNB4', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer55', 'SNB5', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer66', 'SNB6', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer77', 'SNB7', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer88', 'SNB8', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer99', 'SNB9', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer1010', 'SNB10', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer1111', 'SNB11', 0.15, 0.3, 'linear')
        doTweenAlpha('esquer1212', 'SNB12', 0.15, 0.3, 'linear')
    end
end

function onCustomSubstateUpdate(name, elapsed)
    
    if name == 'yeahPau' then

        if podeClicar then
            if keyJustPressed('ui_down') then
                playSound('scrollMenu', 1)
                curOpt = curOpt + 1
            elseif keyJustPressed('ui_up') then
                playSound('scrollMenu', 1)
                curOpt = curOpt - 1
            end
            
            if keyJustPressed('accept') and curOpt == 1 then
                podeClicar = false
                playSound('scrollMenu', 1)
                cancelTween('bgFadeIn')
                doTweenAlpha('bgFadeOut', 'leEpicBlocoPreto', 0.000001, 0.3, 'linear')
                soundFadeCancel('pauseMusic')
                setSoundVolume('pauseMusic', 0)

                doTweenAlpha('vikers', 'vig', 0.000001, 0.3, 'linear')

                doTweenY('funnyAlbum', 'album', getProperty('album.y') + 30, 0.3, 'quartOut')
                doTweenAlpha('albumFunny', 'album', 0.000001, 0.3, 'quartOut')

                doTweenY('opts', 'the1', getProperty('the1.y') + 30, 0.3, 'quartOut')
                doTweenAlpha('osduhuheehfh', 'the1', 0.000001, 0.3, 'quartOut')
                doTweenX('optss', 'the2', -408, 0.3, 'quartOut')
                doTweenX('optsss', 'the3', -408, 0.3, 'quartOut')
                doTweenX('optssss', 'the4', -408, 0.3, 'quartOut')

                doTweenAlpha('esquer1', 'SN1', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer2', 'SN2', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer3', 'SN3', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer4', 'SN4', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer5', 'SN5', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer6', 'SN6', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer7', 'SN7', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer8', 'SN8', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer9', 'SN9', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer10', 'SN10', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer11', 'SN11', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer12', 'SN12', 0.000001, 0.3, 'linear')
                
                doTweenAlpha('esquer69', 'SNB1', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer22', 'SNB2', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer33', 'SNB3', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer44', 'SNB4', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer55', 'SNB5', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer66', 'SNB6', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer77', 'SNB7', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer88', 'SNB8', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer99', 'SNB9', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer1010', 'SNB10', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer1111', 'SNB11', 0.000001, 0.3, 'linear')
                doTweenAlpha('esquer1212', 'SNB12', 0.000001, 0.3, 'linear')

            elseif keyJustPressed('accept') and curOpt == 2 then
                podeClicar = false
                playSound('scrollMenu', 1)
                restartSong(false)

            elseif keyJustPressed('accept') and curOpt == 3 then
                playSound('getOut', 1)

            elseif keyJustPressed('accept') and curOpt == 4 then
                podeClicar = false
                playSound('scrollMenu', 1)
                exitSong(false)
            end

            for sayGex = 1, #options do
                if options[sayGex][2] == curOpt then
                    scaleObject('the'..curOpt, 1, 1, false)
                    setProperty('the'..curOpt..'.alpha', 1)
                else
                    scaleObject('the'..sayGex, 0.8, 0.8, false)
                    setProperty('the'..sayGex..'.alpha', 0.2)
                end
            end
        end

        if curOpt > #options then
            curOpt = 1
        elseif curOpt < 1 then
            curOpt = #options
        end

        for i = 1, #namesEsquer do
            setProperty('SN'..namesEsquer[i]..'.x', getProperty('SN'..namesEsquer[i]..'.x') + 0.1)
            setProperty('SNB'..namesEsquer[i]..'.x', getProperty('SNB'..namesEsquer[i]..'.x') + 0.1)

            setProperty('SN'..namesDirei[i]..'.x', getProperty('SN'..namesDirei[i]..'.x') - 0.1)
            setProperty('SNB'..namesDirei[i]..'.x', getProperty('SNB'..namesDirei[i]..'.x') - 0.1)

            if getProperty('SN'..namesEsquer[i]..'.x') >= getProperty('SN1.width') then
                setProperty('SN'..namesEsquer[i]..'.x', -getProperty('SN1.width'))
            elseif getProperty('SNB'..namesEsquer[i]..'.x') >= getProperty('SNB1.width') then
                setProperty('SNB'..namesEsquer[i]..'.x', -getProperty('SNB1.width'))

            elseif getProperty('SN'..namesDirei[i]..'.x') <= -getProperty('SN2.width') then
                setProperty('SN'..namesDirei[i]..'.x', getProperty('SN2.width'))
            elseif getProperty('SNB'..namesDirei[i]..'.x') <= -getProperty('SNB2.width') then
                setProperty('SNB'..namesDirei[i]..'.x', getProperty('SNB2.width'))
            end
        end
    end
end

function onTweenCompleted(tag, vars)
    
    if tag == 'bgFadeOut' then
        closeCustomSubstate()
    end
end

function onCustomSubstateDestroy(name)
    
    if name == 'yeahPau' then
        removeLuaScript('the1')
        removeLuaScript('the2')
        removeLuaScript('the3')
        removeLuaScript('the4')

        setProperty('album.angle', 90)
        screenCenter('album', 'y')
    end
end