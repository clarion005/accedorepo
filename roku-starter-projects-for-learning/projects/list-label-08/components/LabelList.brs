sub init()
    m.labellist=CreateObject("roSGNode","LabelList")  
    m.labellist.id="label-list"
    m.labellist.translation=[100,100]
    m.labellist.itemSize=[100,50]
    m.content=CreateObject("roSGNode","ContentNode")
    m.content.id="label-list-content"
    m.content.role="content"
    addSection()
    addItem("bugs")
    addItem("bunny")
    m.labellist.content = m.content
    m.top.appendChild(m.labellist)
    m.labellist.setFocus(true)
end sub
sub addSection()
    m.section=m.content.createChild("ContentNode")
    m.section.CONTENTTYPE="SECTION"
end sub
sub addItem(itemText as String)
    item=m.section.createChild("ContentNode")
    item.title=itemText
end sub
function onKeyEvent(key as String, press as Boolean) as Boolean 
    handled=false
    if press then
        print "key was pressed"
        playVideo()
    end if
    return handled
end function
sub playVideo()
    m.video=CreateObject("roSGNode","Video")  
    m.video.id="video"
    content=CreateObject("roSGNode","ContentNode")
    content.title="Phil TV Cartoons"
    content.streamformat="mp4"
    content.url="https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/1080/Big_Buck_Bunny_1080_10s_1MB.mp4"
    m.video.content = content
    m.top.appendChild(m.video)
    m.video.setFocus(true)
    m.video.control="play"
    ' timer
    m.timer = CreateObject("roSGNode","Timer")
    m.timer.repeat=true
    m.timer.duration=5
    m.timer.control="start"
    m.timer.ObserveField("fire","changeVideo")
end sub
sub changeVideo()
    print "timer has fired"
    m.video.content.url="https://test-videos.co.uk/vids/jellyfish/mp4/h264/1080/Jellyfish_1080_10s_1MB.mp4"
    m.video.control="play"
end sub