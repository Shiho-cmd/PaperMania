function onCreate()
    
    startVideo("willGo", false, true, false, false)
end

function onSongStart()
    
    startVideo("willGo", false, true, false, true)
    setProperty("videoCutscene.y", -300)
    setObjectCamera("videoCutscene", 'game')
    setScrollFactor("videoCutscene", 1, 1)
    setObjectOrder("videoCutscene", 2)
end