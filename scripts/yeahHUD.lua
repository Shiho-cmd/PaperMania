function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

local bfRGBNr = { 'C24B99', '00FFFF', '12FA05', 'F9393F' }
local bfRGBNg = { 'FFFFFF', 'FFFFFF', 'FFFFFF', 'FFFFFF' }
local bfRGBNb = { '3C1F56', '1542B7', '0A4447', '651038' }

local barThing = 2
local move = {-0.5, 0, 0.5}
local moveMiddle = {-90 - 0.5, -90, -90 + 0.5}

local curArrow = 0

local hide
local funnyAlpha = healthBarAlpha

local player1 = parseJson('characters/'..boyfriendName..'.json')
local player2 = parseJson('characters/'..dadName..'.json')

--[[local textos = {
    getTranslationPhrase('text1', 'Hi! :3'),
    getTranslationPhrase('text2', 'Funny Text'),
    getTranslationPhrase('text3', 'We don\'t have the budget to make a better pause menu sorry'),
    getTranslationPhrase('text4', 'FNF is mid'),
    getTranslationPhrase('text5', 'I\'m papering my mania till i pause'),
    getTranslationPhrase('text6', 'Also try YeahMan!'),
    getTranslationPhrase('text7', 'Also try Vs Impostor!'),
    getTranslationPhrase('text8', 'Also try FNF Kero!'),
    getTranslationPhrase('text9', 'Also try Hotline 024!'),
    getTranslationPhrase('text10', '{1}? more like trash BOOM B)', {songName}),
    getTranslationPhrase('text11', 'Ma balls itch...'),
    getTranslationPhrase('text12', 'Full of bugs!'),
    getTranslationPhrase('text13', 'Full of glitches!'),
    getTranslationPhrase('text14', 'Trans rights are human rights!'),
}]]

function onCountdownStarted()
    
    setPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0 - 10)
    setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2 + 3)
    setPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3 + 13)
end

function onCreate()
    
    makeLuaSprite("bar", 'ui/healthBarContainer', 0, 0)
    setObjectCamera("bar", 'hud')
    scaleObject("bar", 0.5, 0.5) 
    setProperty("bar.alpha", healthBarAlpha)
    setProperty("bar.visible", not hideHud)
    addLuaSprite("bar", false)

    makeLuaSprite("icon1")
    loadGraphic("icon1", "icons/icon-"..player1.healthicon, 150, 150)
    addAnimation("icon1", "normal", {1}, 0, false)
    addAnimation("icon1", "lose", {0}, 0, false)
    setObjectCamera("icon1", 'hud')
    setProperty("icon1.flipX", true)
    setProperty("icon1.alpha", healthBarAlpha)
    setProperty("icon1.visible", not hideHud)
    scaleObject("icon1", 0.7, 0.7, false)
    addLuaSprite("icon1", false)

    makeLuaSprite("icon2")
    loadGraphic("icon2", "icons/icon-"..player2.healthicon, 150, 150)
    addAnimation("icon2", "normal", {0}, 0, false)
    addAnimation("icon2", "lose", {1}, 0, false)
    setObjectCamera("icon2", 'hud')
    setProperty("icon2.alpha", healthBarAlpha)
    setProperty("icon2.visible", not hideHud)
    scaleObject("icon2", 0.7, 0.7, false)
    addLuaSprite("icon2", false)
end

function onEvent(eventName, value1, value2, strumTime)
    
    if eventName == 'Change Character' then

        player1 = parseJson('characters/'..boyfriendName..'.json')
        player2 = parseJson('characters/'..dadName..'.json')

        precacheImage("icons/icon-"..player1.healthicon)
        precacheImage("icons/icon-"..player2.healthicon)

        makeLuaSprite("icon1")
        loadGraphic("icon1", "icons/icon-"..player1.healthicon, 150, 150)
        addAnimation("icon1", "normal", {1}, 0, false)
        addAnimation("icon1", "lose", {0}, 0, false)
        setObjectCamera("icon1", 'hud')
        setProperty("icon1.flipX", true)
        setProperty("icon1.alpha", healthBarAlpha)
        setProperty("icon1.visible", hide)
        addLuaSprite("icon1", false)

        makeLuaSprite("icon2")
        loadGraphic("icon2", "icons/icon-"..player2.healthicon, 150, 150)
        addAnimation("icon2", "normal", {0}, 0, false)
        addAnimation("icon2", "lose", {1}, 0, false)
        setProperty("icon2.alpha", healthBarAlpha)
        setProperty("icon2.visible", hide)
        setObjectCamera("icon2", 'hud')
        addLuaSprite("icon2", false)

        addToGroup('uiGroup', 'icon1')
        addToGroup('uiGroup', 'icon2')
    end

    if eventName == 'Move Health Bar' then
        if value1 == 'hide' then
            funnyAlpha = 0
            if downscroll and not middlescroll then
                doTweenY("hi", "bar", -getProperty("bar.height"), 1, "quartOut")
            elseif not downscroll and not middlescroll then
                doTweenY("hi", "bar", screenHeight, 1, "quartOut")
            elseif middlescroll then
                doTweenX("hi", "bar", screenWidth, 1, "quartOut")
            end
        elseif value1 == 'appear' then
            funnyAlpha = healthBarAlpha
            setProperty("icon1.alpha", funnyAlpha)
            setProperty("icon2.alpha", funnyAlpha)
            if downscroll and not middlescroll then
                doTweenY("hi", "bar", -10, 1, "quartOut")
            elseif not downscroll and not middlescroll then
                doTweenY("hi", "bar", screenHeight - getProperty("bar.height") + 10, 1, "quartOut")
            elseif middlescroll then
                doTweenX("hi", "bar", screenWidth - 330, 1, "quartOut")
            end
        end
    end
end

function onCreatePost()
    
    addToGroup('uiGroup', 'bar')
    addToGroup('uiGroup', 'icon1')
    addToGroup('uiGroup', 'icon2')
    setProperty("timeBar.visible", false)
    setProperty("timeTxt.visible", false)
    setProperty("iconP1.visible", false)
    setProperty("iconP2.visible", false)
    setProperty("scoreTxt.visible", false)

    if downscroll and not middlescroll then
        setProperty("bar.flipY", true)
        setProperty("bar.y", -getProperty("bar.height"))
        screenCenter("bar", 'x')
    elseif not downscroll and not middlescroll then
        setProperty("bar.y", screenHeight)
        screenCenter("bar", 'x')
    elseif middlescroll then
        setProperty("bar.angle", -90)
        setProperty("bar.x", screenWidth)
        screenCenter("bar", 'y')
    end
end

function onSpawnNote(id, nd, nt, sus)
    
    if getPropertyFromGroup('notes', id, 'mustPress') == true then
        setPropertyFromGroup('notes', id, 'rgbShader.enabled', false)
        setPropertyFromGroup('notes', id, 'noteSplashData.r', getColorFromHex(bfRGBNr[getPropertyFromGroup('notes', id, 'noteData')+1]))
        setPropertyFromGroup('notes', id, 'noteSplashData.g', getColorFromHex(bfRGBNg[getPropertyFromGroup('notes', id, 'noteData')+1]))
        setPropertyFromGroup('notes', id, 'noteSplashData.b', getColorFromHex(bfRGBNb[getPropertyFromGroup('notes', id, 'noteData')+1]))
    else
        setPropertyFromGroup('notes', id, 'visible', false)
    end
end

function onUpdate(elapsed)

    if not middlescroll then
        setProperty("bar.angle", move[barThing])
    else
        setProperty("bar.angle", moveMiddle[barThing])
    end

    runHaxeCode([[
        comboGroup.cameras = [camGame];

        var playerX:Float = boyfriend.x;
        var playerY:Float = boyfriend.y;

        var offsetX:Float = 700; // How far to the right of the player you want the combo to appear
        var offsetY:Float = 150; // How far above the player you want the combo to appear
    
        comboGroup.x = playerX - offsetX;
        comboGroup.y = playerY - offsetY;
    ]])
end

function onUpdatePost(e)

    setProperty("healthBar.y", getProperty("bar.y") + 43)
    setProperty("healthBar.x", getMidpointX("bar") - 208)
    setProperty("healthBar.scale.x", 0.51)

    if getHealth() >= 0.2 then
        playAnim("icon1", "lose", true)
    else
        playAnim("icon1", "normal", true)
    end
    
    if getHealth() > 1.8 then
        playAnim("icon2", "lose", true)
    else
        playAnim("icon2", "normal", true)
    end

    if downscroll and not middlescroll then
        setProperty("icon1.x", getProperty("bar.x") + 373)
        setProperty("icon1.y", getProperty("bar.y") - 10)
        setProperty("icon2.x", getProperty("bar.x") + 23)
        setProperty("icon2.y", getProperty("bar.y") - 10)
    elseif not downscroll and not middlescroll then
        setProperty("icon1.x", getProperty("bar.x") + 373)
        setProperty("icon1.y", getProperty("bar.y") - 15)
        setProperty("icon2.x", getProperty("bar.x") + 23)
        setProperty("icon2.y", getProperty("bar.y") - 15)
    elseif middlescroll then
        setProperty("healthBar.angle", -90)
        setProperty("healthBar.x", getMidpointX("bar") - 208)
        setProperty("icon2.flipX", true)
        setProperty("icon1.x", getProperty("bar.x") + 200)
        setProperty("icon1.y", getProperty("bar.y") - 210)
        setProperty("icon2.x", getProperty("bar.x")+ 200)
        setProperty("icon2.y", getProperty("bar.y") + 180)
    end

    for i=0, getProperty('playerStrums.length')-1 do
        setPropertyFromGroup('playerStrums', i, 'rgbShader.enabled', false)
    end
    
    for i=0, getProperty('opponentStrums.length')-1 do
        setPropertyFromGroup('opponentStrums', i, 'visible', false)
    end
end

function onBeatHit()
    
    barThing = getRandomInt(1, 3)

    scaleObject("icon1", 0.9, 0.9, false)
    doTweenX("huh", "icon1.scale", 0.7, 0.6, "quadOut")
    doTweenY("hu", "icon1.scale", 0.7, 0.6, "quadOut")
    
    scaleObject("icon2", 0.9, 0.9, false)
    doTweenX("uhu", "icon2.scale", 0.7, 0.6, "quadOut")
    doTweenY("uh", "icon2.scale", 0.7, 0.6, "quadOut")
end

function onTweenCompleted(tag, vars)
    
    if tag == 'hi' then
        setProperty("icon1.alpha", funnyAlpha)
        setProperty("icon2.alpha", funnyAlpha)
    end
end

-- this code here is a little modification of Unbekannt0 fancy note splashes script (https://gamebanana.com/mods/546439)
function goodNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote and splashAlpha ~= 0 then
        local strumMember = direction + 4
        makeLuaSprite('yeah'..curArrow, 'noteSkins/yeah', getProperty('game.strumLineNotes.members['..strumMember..'].x') - 30, getProperty('game.strumLineNotes.members['..strumMember..'].y') - 35)

        scaleObject('yeah'..curArrow, 0.3, 0.7, 0.01)
        if direction == 0 then a = 0 c = 'ff00ff' elseif direction == 1 then a = 270 c = '9999ff' elseif direction == 2 then a = 90 c = '00ff00' elseif direction== 3 then a = 180 c = 'ff0000' end
        local randomAngle = {a - 5, a + 5}
        local aRandom = getRandomInt(1, 2)
        setProperty('yeah'..curArrow..'.angle', a)
        setObjectCamera('yeah'..curArrow, 'camHUD')
        setProperty('yeah'..curArrow..'.alpha', 0.3)
        setBlendMode('yeah'..curArrow, 'add')
        setProperty('yeah'..curArrow..'.color', getColorFromHex(c))
        setObjectOrder('yeah'..curArrow, 99)
        doTweenX('yeahXS'..curArrow, 'yeah'..curArrow..'.scale', 1, 0.4, 'quartOut');
        doTweenY('yeahYS'..curArrow, 'yeah'..curArrow..'.scale', 1, 0.4, 'quartOut');
        doTweenAlpha('yeahAplha'..curArrow, 'yeah'..curArrow, 0, 0.4)
        doTweenAngle('yeahAngle', 'yeah'..curArrow, randomAngle[aRandom], 0.4, 'quartOut')

        local curBrrow = curArrow - 20
        addLuaSprite('yeah'..curArrow, false)
        removeLuaSprite('yeah'..curBrrow, true)
        curArrow = curArrow + 1
    end
end