function onCreate()
    
    makeAnimatedLuaSprite("ah", 'events/ahha')
    addAnimationByIndices("ah", "ah", "ahha", "1,2,3,4,5,6,7,8,0", 24, false)
    setProperty("ah.alpha", 0.00001)
    addLuaSprite("ah", true)

    makeAnimatedLuaSprite("ha", 'events/ahha')
    addAnimationByIndices("ha", "ha", "ahha", "9,10,11,12,13,14,15,16,17", 24, false)
    setProperty("ha.alpha", 0.00001)
    addLuaSprite("ha", true)
end

function onUpdate(elapsed)
    
    setProperty("ah.x", getProperty("boyfriend.x") - 330)
    setProperty("ah.y", getProperty("boyfriend.y") - 100)
    setProperty("ha.x", getProperty("boyfriend.x") - 190)
    setProperty("ha.y", getProperty("boyfriend.y") - 100)
end

function onEvent(name, value1, value2)
	if name == 'ahha' then

        if value1 == 'ah' then
            setProperty("ah.alpha", 1)
            playAnim("ah", "ah", true)
        elseif value1 == 'ha' then
            setProperty("ha.alpha", 1)
            playAnim("ha", "ha", true)
        end
    end
end