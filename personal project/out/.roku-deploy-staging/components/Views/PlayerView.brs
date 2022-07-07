sub init()
    videocontent = createObject("RoSGNode", "ContentNode")
    videocontent.title = "Example Video"
    videocontent.streamformat = "mp4"
    videocontent.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    video = m.top.findNode("exampleVideo")
    video.content = videocontent
    video.setFocus(true)
    video.control = "play"
  end sub