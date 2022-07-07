sub init()
    m.top.backgroundURI = "pkg:/images/daffy.png"
    example = m.top.findNode("exampleButtonGroup")
    example.buttons = [ "OK", "Cancel" ]
    examplerect = example.boundingRect()
    centerx = (1280 - examplerect.width) / 2
    centery = 720 / 5
    example.translation = [ centerx, centery ]
    m.top.setFocus(true)
  end sub
  function onKeyEvent(key as String, press as Boolean) as Boolean
    m.posterLabel = m.top.findNode("posterLabel")

    if (key = "up") then 
      m.posterLabel.text = "control clicked - up"
      m.posterLabel.font.size+=5
      Print "you clicked up"
    end if
    if (key = "down") then 
      m.posterLabel.text = "control clicked - down"
      m.posterLabel.font.size-=5
      Print "you clicked down"
    end if
    return true
  end function