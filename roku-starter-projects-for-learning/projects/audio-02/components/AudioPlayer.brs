sub init()
    ' background image as audio node does not render
    m.top.backgroundURI="https://wallpaperaccess.com/full/1128988.jpg"
    audio=CreateObject("roSGNode","Audio")  
    audio.id="audio"
    ' content
    audiocontent=CreateObject("roSGNode","ContentNode")
    audiocontent.url="https://cdn.pixabay.com/download/audio/2020/11/10/audio_547ebbf828.mp3"
    audio.content = audiocontent
    m.top.appendChild(audio)
    audio.control="play"
    m.top.setFocus(true)
end sub