sub init()
    overhang()
    scrolling()
    infolabel()
    mainmenu()
end sub
sub overhang()
    m.top.backgroundUri = "https://i.ytimg.com/vi/TncbUgoUSFw/maxresdefault.jpg"
    m.overhang = CreateObject("roSGNode","Overhang")
    m.overhang.title="Phil Christmas TV On Channel 4"
    m.overhang.visible=true
    m.top.appendChild(m.overhang)
end sub
sub scrolling()
    m.label = CreateObject("roSGNode","ScrollingLabel")
    m.label.text = "Channel 4 Showing Phil TV . . . Christmas Entertainment, Movies And Lots, Lots More !!!!  Stay Tuned For Your Favourite Shows !!!!"
    m.label.translation = [100,150]
    m.label.font.size=50
    m.label.maxWidth = 1100
    m.label.repeatCount = -1
    m.top.appendChild(m.label)     
end sub
sub infolabel()
    m.infolabel=CreateObject("roSGNode","Label")
    m.infolabel.text="Here is some information"
    m.infolabel.translation=[150,630]
    m.infolabel.font.size=60
    m.top.appendChild(m.infolabel)
end sub
sub mainmenu()
    m.menu=CreateObject("roSGNode","ButtonGroup")
    m.menu.buttons=["Movies","TV Shows","Series","CatchUp","4OD","More..."]
    m.menu.translation=[100,230]
    m.menu.iconUri=""
    m.menu.focusedIconUri=""
    m.menu.observeField("buttonFocused","onButtonFocused")
    m.menu.observeField("buttonSelected","onButtonSelected")
    m.top.appendChild(m.menu)
    m.menu.setFocus(true)
end sub
sub onButtonFocused()
    print "Item focused - index " m.menu.buttonFocused " is in focus with text """ m.menu.buttons[m.menu.buttonFocused] """"
    m.infolabel.text=m.menu.buttons[m.menu.buttonFocused]
end sub
sub onButtonSelected()
    print "Item selected - index " m.menu.buttonSelected " with text """ m.menu.buttons[m.menu.buttonSelected] """"
    m.infolabel.text=m.menu.buttons[m.menu.buttonFocused]
end sub