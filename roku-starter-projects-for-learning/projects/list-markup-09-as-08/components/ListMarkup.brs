sub init()
    ' this label was created in xml
    m.label=m.top.findNode("label")
    ' add a label dynamically
    m.label2 = CreateObject("roSGNode","Label")
    m.label2.text = "this is another label"
    m.label2.translation = [0,100]
    m.top.backgroundURI="https://wallpaperaccess.com/full/1128988.jpg"
    m.top.appendChild(m.label2)
    m.top.translation=[100,100]
    ' now lets add a label list
    m.labellist = CreateObject("roSGNode","LabelList")
    m.labellist.translation = [0,200]
    ' create content for label list
    m.content = CreateObject("roSGNode","ContentNode")
    m.section = m.content.createChild("ContentNode")
    m.section.CONTENTTYPE="SECTION"
    m.names = ["bugs","bunny","lion","king","freddy","flintstone","more...."]
    m.labellist.observeField("itemFocused","onLabelListItemFocused")
    m.labellist.observeField("itemSelected","onLabelListItemSelected")
    for each name in m.names 
        item = m.section.createChild("ContentNode")
        item.title=name
    end for
    m.labellist.content=m.content
    m.top.appendChild(m.labellist)

    ' create poster data
    m.posterUrls=[]
    m.posterUrls.push("https://i.pinimg.com/originals/9d/3e/5e/9d3e5e7c1c13ff2dcbf7c1f4e03a0c56.jpg")
    m.posterUrls.push("https://images-na.ssl-images-amazon.com/images/I/5101NtSnx0L._AC_.jpg")
    m.posterUrls.push("https://upload.wikimedia.org/wikipedia/en/9/9d/Disney_The_Lion_King_2019.jpg")
    m.posterUrls.push("https://akns-images.eonline.com/eol_images/Entire_Site/20181022/rs_1024x1517-181122145541-1024.the-lion-king-poster.112218.jpg")
    m.posterUrls.push("https://img.favpng.com/24/9/8/wilma-flintstone-fred-flintstone-barney-rubble-betty-rubble-pebbles-flinstone-png-favpng-CNTySikFph7ys6DT5Ak7u8vxa_t.jpg")
    m.posterUrls.push("https://i.pinimg.com/originals/d1/94/7c/d1947cea4b97cd7ef308f23c6570a585.png")
    m.posterUrls.push("https://www.fpgltd.co.uk/wp-content/uploads/2017/09/FPG-Channel4.jpg")
    ' create poster item
    m.poster = CreateObject("roSGNode","Poster")
    m.poster.translation=[500,0]
    m.poster.uri=m.posterUrls[0]
    m.poster.width=250
    m.poster.height=350
    m.top.appendChild(m.poster)

    ' create video item
    m.video = CreateObject("roSGNode","Video")
    m.videoContent = CreateObject("roSGNode","ContentNode")
    m.videoContent.url = "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4"
    m.videoContent.title = "Phil TV Videos"
    m.videoContent.streamformat = "mp4"
    m.video.content = m.videoContent 
    m.video.visible = false

    m.labellist.setFocus(true)
end sub
sub onLabelListItemFocused()    
    m.itemIndex = m.labellist.itemFocused
    print "index of item focused is " m.itemIndex
    ' must not be the last item as that has no url 
    m.poster.uri = m.posterUrls[m.itemIndex]
end sub
sub onLabelListItemSelected()
    print "item selected"
    print "index of item selected is " m.itemIndex
    ' must not be the last item as that has no url 
    if (m.itemIndex <> m.names.count()-1) then
        m.top.appendChild(m.video)
        m.video.visible=true
        m.top.translation=[0,0]
        m.video.setFocus(true)
        m.video.control="play"
    else
        print "moving to more ... next screen"

        ' hide everything else
        m.video.visible=false
        m.label.visible=false
        m.label2.visible=false 
        m.labellist.visible=false 
        m.poster.visible=false

        ' overhang
        m.overhang = CreateObject("roSGNode","Overhang")
        m.overhang.backgroundUri = "https://www.calmsage.com/wp-content/uploads/2020/04/calm-desktop-wallpapers-1024x679.jpg"
        m.overhang.title="Phil TV Showing Channel 4"
        m.overhang.visible=true
        m.top.translation=[0,0]
        m.top.appendChild(m.overhang)

        ' now add a markup list!!!
        m.listmarkup = CreateObject("roSGNode","MarkupList")
        m.listmarkup.translation = [150,150]
        ' this needs an xml file
        m.listmarkup.itemComponentName="ListMarkupItem"
        ' this also needs an xml file
        m.listmarkup.content=CreateObject("roSGNode","ListMarkupContent")
        'm.listmarkup.itemSize=[100,100]
        'm.listmarkup.itemSpacing=[0,10]
        m.top.appendChild(m.listmarkup)

        ' also create a poster grid
        m.postergrid = CreateObject("roSGNode","PosterGrid")
        m.postergrid.basePosterSize=[200,200]
        m.postergrid.numColumns=2
        m.postergrid.numRows=2
        m.postergrid.itemspacing=[20,20]
        m.postergrid.translation=[400,100]
        ' triggers init function in brs file
        print "about to create the content reader for poster data"
        m.contentreader=CreateObject("roSGNode","PosterGridContentReader")
        m.contentreader.contenturi="http://www.sdktestinglab.com/Tutorial/content/rendergridps.xml"

        ' this listens for any change in content
        m.contentreader.ObserveField("content","showpostergrid")
        
        print "starting the background task fetch poster url data"
        m.contentreader.control="RUN"
        m.listmarkup.setFocus(true)

    end if
end sub
sub showpostergrid()
    print "about to show poster grid"
    print "m.contentreader " m.contentreader 
    print "m.contentreader.content" m.contentreader.content
    m.postergrid.content = m.contentreader.content
    print "m.postergrid " m.postergrid
    print "m.postergrid.content " m.postergrid.content 
    ' now stop task 
    m.contentreader.control="STOP"
    m.contentreader = invalid   
end sub
function onKeyEvent(key as String,press as Boolean) as boolean
    handled = false
    if (press) then 
        print "handling key press"
        handled = true
    end if
    return handled
end function