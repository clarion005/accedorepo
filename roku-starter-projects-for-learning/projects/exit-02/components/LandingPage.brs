sub init()
    overhang()
    scrolling()
    infolabel()
    mainmenu()
    postergrid()
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
    m.menu.buttons=["Movies","TV Shows","Series","CatchUp","4OD","More...","Exit"]
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
    m.infolabel.text=m.menu.buttons[m.menu.buttonSelected] + " selected"
    if (m.menu.buttons[m.menu.buttonSelected]="Exit")
        print "Exiting app"
        m.top.exitApp = true
    else 
        m.postergrid.setFocus(true)
    end if    
end sub
sub postergrid()
    m.postergrid=CreateObject("roSGNode","PosterGrid")
    m.postergrid.translation=[400,220]
    m.postergrid.basePosterSize=[220,180]
    m.postergrid.numColumns=3
    m.postergrid.numRows=2
    m.postergrid.itemSpacing=[20,20]
    m.contentreader=CreateObject("roSGNode","PosterGridContentReader")
    m.contentreader.contentUri="https://bitbucket.org/philandersonaccedo/phil-data/raw/ec3c39ac1dbd5758ea2a437c96d60647a0de3bd7/postergrid/poster-grid-christmas-movies-3x2.xml"
    ' poster grid is not shown until the content arrives via RUN the async function
    m.contentreader.observeField("content","showpostergrid")
    ' call async function to get data
    m.contentreader.control="RUN"
    m.postergrid.observeField("itemFocused","onPosterItemFocused") 
    m.postergrid.observeField("itemSelected","onPosterItemSelected") 
    m.top.appendChild(m.postergrid)
    print "m.postergrid " m.postergrid 
end sub
sub showpostergrid()
    print "poster content has arrived " m.contentreader.content
    m.postergrid.content=m.contentreader.content
    ' stop content reader to save cpu and memory
    'contentreader.control="STOP"
    'contentreader = invalid
end sub
sub onPosterItemFocused(event)
    'print "poster focused index " m.postergrid.itemFocused
    index = event.GetData()
    poster = event.GetRoSGNode().content.GetChild(event.GetData())
    ' getting data via m.postergrid directly
    print "poster is " m.postergrid.content.GetChild(m.postergrid.itemFocused)
    ' getting data from the event (this method is preferred)
    print "focused poster index" index " row" poster.X " col" poster.Y " """ poster.shortdescriptionline1 """"
    m.infolabel.text=poster.shortdescriptionline1
end sub
sub onPosterItemSelected(event)
    'print "poster item selected with index " m.postergrid.itemSelected
    index = event.GetData()
    poster = event.GetRoSGNode().content.GetChild(event.GetData())
    ' getting data via m.postergrid directly
    print "poster is " m.postergrid.content.GetChild(m.postergrid.itemSelected)
    ' getting data from the event (this method is preferred)
    print "selected poster index" index " row" poster.X " col" poster.Y " """ poster.shortdescriptionline1 """"
    m.infolabel.text=poster.shortdescriptionline1 + " selected"
    m.timer = CreateObject("roSGNode","Timer")
    m.timer.repeat=3
    m.timer.duration=1
    m.counter = 3
    m.timer.control="start"
    m.timer.ObserveField("fire","videoCountdown")
end sub
sub videoCountdown()
    m.infolabel.text = "Your video willl start in " + m.counter.tostr() + " ..."
    if (m.counter>0)
        m.counter = m.counter - 1
    else 
        m.timer.control="stop"
        m.video=CreateObject("roSGNode","Video")
        content = CreateObject("roSGNode","ContentNode")
        content.title = "Let It Snow - 2019 (C) Phil TV Productions Inc."
        content.streamformat="mp4"
        content.url="https://hdvidstatus.com/wp-content/uploads/2018/10/Christmas-Video-Song-Whatsapp-Status-Video-Download.mp4"
        m.video.content=content
        m.top.appendChild(m.video)
        m.video.setFocus(true)
        m.video.control="play"
    end if
end sub