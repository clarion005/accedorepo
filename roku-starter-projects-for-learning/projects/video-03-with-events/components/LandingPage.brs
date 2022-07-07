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
    buttonText = m.menu.buttons[m.menu.buttonSelected]
    print "Item selected - index " m.menu.buttonSelected " with text """ buttonText """"
    m.infolabel.text= buttonText + " selected"
    if (buttonText="Series")
       print "creating a markup list" 
       markuplist()
    else if (buttonText="Exit")
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
    m.infolabel.text = "Your video starts in " + m.counter.tostr() + " ..."
    if (m.counter>0)
        m.counter = m.counter - 1
    else 
        m.timer.control="stop"
        m.video=CreateObject("roSGNode","Video")
        content = CreateObject("roSGNode","ContentNode")
        content.title = "Let It Snow - 2019 (C) Phil TV Productions Inc."
        content.streamformat="mp4"
        content.url="https://hdvidstatus.com/wp-content/uploads/2018/10/Christmas-Video-Song-Whatsapp-Status-Video-Download.mp4"


        content.streamformat = "dash"
        encodingType =  "PlayReadyLicenseAcquisitionUrl"
        content.url = "http://cdn.live.dash.c4assets.com/v2/iso-dash-sp/e4/manifest.mpd"
        content.encodingKey = "https://ais.channel4.com/licence/simulcast/pr?token=WUtxYVlWdkrQS6cVlISb-tn-Bk7mJN6wkwk7_IJZYPTd0CEqJ9_9KJOhS_SKOfTqvqsENZFjvp2CQk5a7btJsurf22ZtPLx5"



        m.video.content=content
        m.video.ObserveField("control","onVideoChangeControl")
        m.video.ObserveField("state","onVideoChangeState")
        m.top.appendChild(m.video)
        m.video.setFocus(true)
        m.video.control="play"
    end if
end sub
sub markuplist()
    ' hide postergrid and replace with markup list
    m.postergrid.visible=false
    m.markuplist = CreateObject("roSGNode","MarkupList")
    m.markuplist.translation=m.postergrid.translation
    m.markuplist.numRows=2
    m.markuplist.numColumns=3    
    m.markuplist.drawFocusFeedback=true
    m.markuplist.currFocusFeedbackOpacity=0.0
    m.markuplist.itemComponentName="ListMarkupItem"
    m.markuplist.itemSize=m.postergrid.basePosterSize
    m.markuplist.itemSpacing=m.postergrid.itemSpacing
    m.markupcontentreader=CreateObject("roSGNode","MarkupContentReader")
    m.markupcontentreader.contentUri="https://bitbucket.org/philandersonaccedo/phil-data/raw/2110e99845b1be1fef826f57daa4f1797ae64a60/markupgrid/markup-grid-series-3x2.xml"
    m.markupcontentreader.observeField("itemcontent","showmarkupgrid")
    m.markupcontentreader.control="RUN"
    m.markuplist.ObserveField("itemFocused","onMarkupItemFocused")
    m.markuplist.ObserveField("itemSelected","onMarkupItemSelected")
    m.top.appendChild(m.markuplist)
    m.markuplist.setFocus(true)
end sub
sub showmarkupgrid()
    print "markup content has arrived " m.markupcontentreader.content
    m.markuplist.content=m.markupcontentreader.content
    ' stop content reader to save cpu and memory
    'm.markupcontentreader.control="STOP"
    'm.markupcontentreader = invalid
end sub
sub onMarkupItemFocused(event)
    print "Markup Item Has Received The Focus"
    index = event.GetData()
    print "index is " index 
    print "content is " event.GetRoSGNode()
    'content = event.GetRoSGNode().content.GetChild(index)
    'print "content is " content
    'm.infolabel.text = content.text
end sub
sub onMarkupItemSelected(event)
    print "Markup item has been selected"
    index = event.GetData()
    content = event.GetRoSGNode().content.GetChild(index)
    print "index is " index 
    print "content is " content
    m.infolabel.text = content.text + " selected "
    m.timer = CreateObject("roSGNode","Timer")
    m.timer.repeat = 3
    m.timer.duration = 1
    m.counter = 3
    m.timer.control="start"
    m.timer.ObserveField("fire","videoCountdown")
end sub
sub onVideoChangeControl()
    print "Video has changed control to " m.video.control
end sub
sub onVideoChangeState()
    print "Video has changed state to " m.video.state
    if (m.video.state = "finished")
        print "video has finished playing"
    end if 
end sub