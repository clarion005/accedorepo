sub init()
    poster=CreateObject("roSGNode","Poster")  
    poster.id="poster"
    poster.uri="https://vignette.wikia.nocookie.net/cartoon-characters8569/images/2/2b/Bugs_Bunny.png"
    poster.width=200
    m.top.appendChild(poster)
    poster.translation=[500,150]
    poster.visible=true
    poster.setFocus(true)

    buttonGroup = CreateObject("roSGNode", "ButtonGroup")
    buttonGroup.id = "exampleButtonGroup"
    buttonGroup.buttons = ["OK", "Cancel", "Forward", "Back"]
    buttonGroup.translation = [100,400]
    m.top.appendChild(buttonGroup)
    buttonGroup.visible = true
    buttonGroup.setFocus(true)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    if not press then 
        print "you clicked " key
    end if
    return true
 end function