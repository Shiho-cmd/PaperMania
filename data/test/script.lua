function onCreatePost()
    
    startVideo("willGo", false, true, false, true)
    setObjectCamera("videoCutscene", 'game')
    setObjectOrder("videoCutscene", 0)
end

function onSongStart()
    
    startVideo("willGo", false, true, false, true)
    if not flashingLights then
        setProperty("videoCutscene.color", getColorFromHex("282828"))
        setProperty("videoCutscene.alpha", 0.3)
    end
    setObjectCamera("videoCutscene", 'game')
    setScrollFactor("videoCutscene", 1, 1)
    setObjectOrder("videoCutscene", 2)
end

function onPause()
    
    callMethod("videoCutscene.pause")
end

function onResume()
    
    callMethod("videoCutscene.resume")
end