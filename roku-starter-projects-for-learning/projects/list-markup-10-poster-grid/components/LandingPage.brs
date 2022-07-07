sub init()
    m.overhang = CreateObject("roSGNode","Overhang")
    m.overhang.backgroundUri = "https://www.calmsage.com/wp-content/uploads/2020/04/calm-desktop-wallpapers-1024x679.jpg"
    m.overhang.title="Phil TV Showing Channel 4"
    m.overhang.visible=false
    m.top.appendChild(m.overhang)

    m.label = CreateObject("roSGNode","ScrollingLabel")
    m.label.text = "Phil TV on Channel 4.  Watch Here For The Latest Christmas Movies And Entertainment"
    m.label.translation = [100,150]
    m.label.font.size=60
    m.label.maxWidth = 1100
    m.label.repeatCount = -1
    m.top.backgroundURI="https://wallpaperaccess.com/full/1128988.jpg"
    m.top.appendChild(m.label)

    ' also create a poster grid
    'm.postergrid = m.top.findNode("poster-grid")
    
    m.postergrid = CreateObject("roSGNode","PosterGrid")
    m.postergrid.basePosterSize=[150,150]
    m.postergrid.numColumns=2
    m.postergrid.numRows=2
    m.postergrid.itemspacing=[20,20]
    m.postergrid.translation=[250,200]
    m.top.appendChild(m.postergrid)
    print "create content reader"
    m.contentreader=CreateObject("roSGNode","PosterGridContentReader")
    m.contentreader.contenturi="http://www.sdktestinglab.com/Tutorial/content/rendergridps.xml"

    ' this listens for any change in content
    m.contentreader.observeField("content","showpostergrid")
    
    print "calling RUN from main thread which will start background content reader task"
    m.contentreader.control="RUN"
    m.postergrid.setFocus(true)
end sub

sub showpostergrid()
    print "rendering poster with data"
    print "m.contentreader " m.contentreader 
    print "m.contentreader.content" m.contentreader.content
    m.postergrid.content = m.contentreader.content
    print "m.postergrid " m.postergrid
    print "m.postergrid.content " m.postergrid.content 
    ' now stop task 
    'm.contentreader.control="STOP"
    'm.contentreader = invalid   
end sub