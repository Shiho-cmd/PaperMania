local bfRGBNr = { 'C24B99', '00FFFF', '12FA05', 'F9393F' }
local bfRGBNg = { 'FFFFFF', 'FFFFFF', 'FFFFFF', 'FFFFFF' }
local bfRGBNb = { '3C1F56', '1542B7', '0A4447', '651038' }

local barThing = 0
local move = {-0.5, 0, 0.5}

local curArrow = 0

function onCreate()
    
    makeLuaSprite("bar", 'ui/healthBarContainer', 0, 0)
    setObjectCamera("bar", 'hud')
    scaleObject("bar", 0.5, 0.5)
    screenCenter("bar", 'x')
    addLuaSprite("bar", false)
end

function onCreatePost()
    
    setObjectOrder("healthBar", 99)
    setObjectOrder("bar", 99)
    setObjectOrder("iconP1", 99)
    setObjectOrder("iconP2", 99)
    setProperty("bar.y", screenHeight)
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
    setProperty("scoreTxt.visible", false)
end

function onSongStart()
    
    doTweenY("hi", "bar", screenHeight - getProperty("bar.height") + 10, 1, "quartOut")
end

function onSpawnNote(id, nd, nt, sus)
    
    if getPropertyFromGroup('notes', id, 'mustPress') == true then
        setPropertyFromGroup('notes', id, 'rgbShader.enabled', false)
        setPropertyFromGroup('notes', id, 'noteSplashData.r', getColorFromHex(bfRGBNr[getPropertyFromGroup('notes', id, 'noteData')+1]))
        setPropertyFromGroup('notes', id, 'noteSplashData.g', getColorFromHex(bfRGBNg[getPropertyFromGroup('notes', id, 'noteData')+1]))
        setPropertyFromGroup('notes', id, 'noteSplashData.b', getColorFromHex(bfRGBNb[getPropertyFromGroup('notes', id, 'noteData')+1]))
    else
        setPropertyFromGroup('notes', id, 'rgbShader.enabled', false)
        setPropertyFromGroup('notes', id, 'visible', false)
    end
end

function onUpdate(elapsed)

    setProperty("bar.angle", move[barThing])
end

function onUpdatePost(e)

    setProperty("iconP1.x", getProperty("bar.x") + 390)
    setProperty("iconP1.y", getProperty("bar.y"))

    setProperty("iconP2.x", getProperty("bar.x"))
    setProperty("iconP2.y", getProperty("bar.y"))

    setProperty("healthBar.y", getProperty("bar.y") + 50)

    for i=0, getProperty('playerStrums.length')-1 do
        setPropertyFromGroup('playerStrums', i, 'rgbShader.enabled', false)        
    end
    
    for i=0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'rgbShader.enabled', false)
        setPropertyFromGroup('opponentStrums', i, 'visible', false)
    end
end

function onBeatHit()
    
    barThing = getRandomInt(1, 3)
end

-- this code here is a little modification of Unbekannt0 fancy note splashes script (https://gamebanana.com/mods/546439)
function goodNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        local strumMember = direction + 4
        makeLuaSprite('yeah'..curArrow, 'noteSkins/yeah', getProperty('game.strumLineNotes.members['..strumMember..'].x') - 30, getProperty('game.strumLineNotes.members['..strumMember..'].y') - 35)

        scaleObject('yeah'..curArrow, 0.3, 0.7, 0.01)
        if direction == 0 then a = 0 c = 'ff00ff' elseif direction == 1 then a = 270 c = '9999ff' elseif direction == 2 then a = 90 c = '00ff00' elseif direction== 3 then a = 180 c = 'ff0000' end
        setProperty('yeah'..curArrow..'.angle', a)
        setObjectCamera('yeah'..curArrow, 'camHUD')
        setProperty('yeah'..curArrow..'.alpha', 0.3)
        doTweenX('yeahXS'..curArrow, 'yeah'..curArrow..'.scale', 1, 0.4, 'quartOut');
        doTweenY('yeahYS'..curArrow, 'yeah'..curArrow..'.scale', 1, 0.4, 'quartOut');
        doTweenAlpha('yeahAplha'..curArrow, 'yeah'..curArrow, 0, 0.4)

        local curBrrow = curArrow - 20
        addLuaSprite('yeah'..curArrow, false)
        removeLuaSprite('yeah'..curBrrow, true)
        curArrow = curArrow + 1
    end
end