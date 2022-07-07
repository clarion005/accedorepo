sub init()
    m.top.functionName = "getFeed"
end sub

sub getFeed()
    urlTransfer = createObject("roUrlTransfer")
    urlTransfer.setUrl("http://c4.arm.accedo.tv/develop/matt/we/feed.json")
    m.top.response = urlTransfer.getToString()
end sub