luaDebugMode = true

local moveSound
local soundDelay
local jbo1
local jbo2
local usingSound = false
local canStart = false

local ativaSom = false
local somAtiva = false
local fodase = true
local pintao = true

local chave = getModSetting('keyAccept')

function onStartCountdown()
    
    if not canStart and songName ~= 'cum' then
        return Function_Stop;
    end
end

function onCreate()

    precacheSound("paperOut")
    precacheSound("paperIn")
    precacheSound("walk")
    
    makeAnimatedLuaSprite("trans", 'transition/transition', 0, 0)
    addAnimationByPrefix("trans", "loop", "Loop", 24, true)
    addAnimationByPrefix("trans", "open", "Open", 24, false)
    addAnimationByPrefix("trans", "close", "Close", 24, false)
    scaleObject("trans", 1.2, 1.2)
    setObjectCamera("trans", 'other')
    screenCenter("trans")
    addLuaSprite("trans", true)
    runTimer("start", 0.5)

    makeAnimatedLuaSprite("butao", 'ui/overworld/tooltip', 0, 130)
    addAnimationByPrefix("butao", "loop", chave.keyboard, 69, false)
    scaleObject("butao", 1.5, 1.5)
    setProperty("butao.alpha", 0.0001)
    addLuaSprite("butao", true)
end

function _playTransition(name)

    playAnim("trans", name)
    setProperty("trans.alpha", 1)

    if name == 'close' then
        playSound("paperOut", 1, 'out')
    elseif name == 'open' then
        playSound("paperIn", 1, 'in')
    end
end

function _charMove(obj, anim, facing, velocity, flipX, flipY, offsetX, offsetY)

    if facing == 'right' then
        setProperty(obj..".flipX", flipX)
        addOffset(obj, anim, offsetX, offsetY)
        playAnim(obj, anim)
        setProperty(obj..".x", getProperty(obj..".x") + velocity)
        setProperty("butao.x", getProperty(obj..".x") + 150 + velocity)

    elseif facing == 'left' then
        setProperty(obj..".flipX", flipX)
        addOffset(obj, anim, offsetX, offsetY)
        playAnim(obj, anim)
        setProperty(obj..".x", getProperty(obj..".x") - velocity)
        setProperty("butao.x", getProperty(obj..".x") + 280 - velocity)

    elseif facing == 'down' then
        setProperty(obj..".flipY", flipY)
        addOffset(obj, anim, offsetX, offsetY)
        playAnim(obj, anim)
        setProperty(obj..".y", getProperty(obj..".y") + velocity)

    elseif facing == 'up' then
        setProperty(obj..".flipY", flipY)
        addOffset(obj, anim, offsetX, offsetY)
        playAnim(obj, anim)
        setProperty(obj..".y", getProperty(obj..".y") - velocity)
    end
end

function _keyShit(shit)

    
    if shit == 'in' and pintao then
        pintao = false
        scaleObject("butao", 0.1, 0.1, false)
        doTweenAlpha("butaoAlpha", "butao", 1, 0.3, "linear")
        doTweenX("butaox", "butao.scale", 1.5, 0.3, "quartOut")
        doTweenY("butaoy", "butao.scale", 1.5, 0.3, "quartOut")
    elseif shit == 'out' and not pintao then
        pintao = true
        doTweenAlpha("butaoAlpha", "butao", 0, 0.2, "linear")
        doTweenX("butaox", "butao.scale", 0.1, 0.3, "quartOut")
        doTweenY("butaoy", "butao.scale", 0.1, 0.3, "quartOut")
    end
end

function _changeRoom(remove, add)

    playAnim("trans", "open")
    scriptRemove = remove
    scriptAdd = add
end

function _setCamOffset(obj, x, y, moveCam)

    if moveCam then
        triggerEvent("Camera Follow Pos", getGraphicMidpointX(obj) * x, getGraphicMidpointY(obj) * y)
    elseif not moveCam then
        triggerEvent("Camera Follow Pos", x, y)
    end
end

function _useWalkSound(useIt, sound, delay)

    if useIt then
        runTimer("foda-se", 0.00001)
        usingSound = true
        moveSound = sound
        soundDelay = delay
    else
        usingSound = false
    end
end

function _stopMove(obj, idleAnim)

    playAnim(obj, idleAnim)

    if usingSound then
        stopSound("walk")
        ativaSom = false
        somAtiva = false
        fodase = true
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    
    if tag == 'foda-se' and fodase then
        fodase = false
        ativaSom = true
        runTimer("se-foda", 0.000001)
    elseif tag == 'se-foda' and ativaSom then
        ativaSom = false
        somAtiva = true
        playSound(moveSound, 0.5, 'walk')
        runTimer("walkDelay", soundDelay)
    elseif tag == 'walkDelay' and somAtiva then
        playSound(moveSound, 0.5, 'walk')
        runTimer("walkDelay", soundDelay)
    end

    if tag == 'start' then
        playAnim("trans", "close")
        playSound("paperOut", 1, 'out')
    end
end

function onUpdate(elapsed)
    
    if getProperty('trans.animation.curAnim.name') == 'close' and getProperty('trans.animation.curAnim.finished') and not canStart then
        canStart = true
        startCountdown()
        setProperty("trans.alpha", 0.00001)
    elseif getProperty('trans.animation.curAnim.name') == 'open' and getProperty('trans.animation.curAnim.finished') then
        playAnim("trans", "loop", true)
    elseif getProperty('trans.animation.curAnim.name') == 'close' and getProperty('trans.animation.curAnim.finished') then
        setProperty("trans.alpha", 0.00001)
    end
end

function onCreatePost()
    
    runHaxeCode([[

        createGlobalCallback("setSongPosition", function(time:Int) {PlayState.instance.clearNotesBefore(time); PlayState.instance.setSongTime(time);});

        createGlobalCallback("charMove", function(obj:String, anim:String, facing:String, velocity:Float, flipX:Bool, flipY:Bool, offsetX:Float, offsetY:Float) {parentLua.call("_charMove", [obj, anim, facing, velocity, flipX, flipY, offsetX, offsetY]);});
        createGlobalCallback("setCamOffset", function(obj:String, x:Float, y:Float, moveCam:Bool) {parentLua.call("_setCamOffset", [obj, x, y, moveCam]);});
        createGlobalCallback("useWalkSound", function(useIt:Bool, sound:String, delay:Float) {parentLua.call("_useWalkSound", [useIt, sound, delay]);});
        createGlobalCallback("stopMove", function(obj:String, idleAnim:String) {parentLua.call("_stopMove", [obj, idleAnim]);});
        createGlobalCallback("playTransition", function(name:String) {parentLua.call("_playTransition", [name]);});
        createGlobalCallback("keyShit", function(shit:String) {parentLua.call("_keyShit", [shit]);});
        createGlobalCallback("changeRoom", function(remove:String, add:String) {parentLua.call("_changeRoom", [remove, add]);});
    ]])
end