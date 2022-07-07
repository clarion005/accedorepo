sub init()
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