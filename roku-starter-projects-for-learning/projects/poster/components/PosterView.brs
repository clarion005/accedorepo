sub init()
    poster=CreateObject("roSGNode","Poster")  
    poster.id="poster"
    poster.uri="https://vignette.wikia.nocookie.net/cartoon-characters8569/images/2/2b/Bugs_Bunny.png"
    poster.width=200
    m.top.appendChild(poster)
    poster.translation=[100,200]
    poster.visible=true
    poster.setFocus(true)
end sub