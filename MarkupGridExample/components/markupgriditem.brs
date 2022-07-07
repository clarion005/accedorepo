sub init()
    m.top.id = "markupgriditem"
    m.itemposter = m.top.findNode("itemPoster") 
    m.itemmask = m.top.findNode("itemMask")
    m.focuslabel = m.top.findNode("focusLabel")
  end sub
  sub showcontent()
    itemcontent = m.top.itemContent
    m.itemposter.uri = itemcontent.hdgridposterurl
  end sub
  sub showfocus()
    scale = 1 + (m.top.focusPercent * 0.08)
    m.itemposter.scale = [scale, scale]
    m.itemmask.opacity = 0.75 - (m.top.focusPercent * 0.75)
  end sub