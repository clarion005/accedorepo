sub init()
    button = m.top.FindNode("button01")
    button.setFocus(true)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
   print "hi there " key " " press
   return true
end function