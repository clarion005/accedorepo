sub init()
    overhang()
    scrollingLabel()
    posterLabel()
    posterGrid()
end sub
sub overhang()
    m.overhang = CreateObject("roSGNode","Overhang")
    m.overhang.backgroundUri = "https://www.calmsage.com/wp-content/uploads/2020/04/calm-desktop-wallpapers-1024x679.jpg"
    m.overhang.title="Phil TV Showing Channel 4"
    m.overhang.visible=true
    m.top.appendChild(m.overhang)
end sub
sub scrollingLabel()
    m.label = CreateObject("roSGNode","ScrollingLabel")
    m.label.text = "Phil TV on Channel 4.  Watch Here For The Latest Christmas Movies And Entertainment"
    m.label.translation = [100,150]
    m.label.font.size=60
    m.label.maxWidth = 1100
    m.label.repeatCount = -1
    m.top.backgroundURI="https://wallpaperaccess.com/full/1128988.jpg"
    m.top.appendChild(m.label)  
end sub
sub posterLabel()
    m.posterlabel=CreateObject("roSGNode","Label")
    m.posterlabel.text=""
    m.posterlabel.translation=[150,630]
    m.posterlabel.font.size=60
    m.top.appendChild(m.posterlabel)
end sub
sub posterGrid()
    m.postergrid = CreateObject("roSGNode","PosterGrid")
    m.postergrid.basePosterSize=[200,150]
    m.postergrid.numColumns=2
    m.postergrid.numRows=2
    m.postergrid.itemspacing=[20,20]
    m.postergrid.translation=[110,250]
    m.contentreader=CreateObject("roSGNode","PosterGridContentReader")
    m.contentreader.contenturi="https://bitbucket.org/philandersonaccedo/phil-data/raw/5e6ccc7ab5caedb57cafa7e7eaf79bf486b5e7ca/poster-grid-data-cartoon-images.xml"
    m.contentreader.observeField("content","showpostergrid")  
    print "get poster grid data"    
    m.contentreader.control="RUN"
    m.postergrid.observeField("itemFocused","onItemFocused") 
    m.postergrid.observeField("itemSelected","onItemSelected") 
    m.postergrid.setFocus(true)
    m.top.appendChild(m.postergrid)
end sub
sub showpostergrid()
    print "displaying postergrid content" m.contentreader.content
    m.postergrid.content = m.contentreader.content
    ' now stop task 
    'm.contentreader.control="STOP"
    'm.contentreader = invalid   
end sub
sub onItemFocused()
    print "this poster item is in focus" m.postergrid.itemFocused
    print "m.posterGrid.focusedChild = " m.postergrid.focusedChild.content
    print "m.contentreader = " m.contentreader
    print "label text is " m.contentreader.dataArray[m.postergrid.itemFocused]
    m.posterlabel.text = m.contentreader.dataArray[m.postergrid.itemFocused]
end sub
sub onItemSelected()
    print "this poster item has been selected" m.postergrid.itemSelected
end sub