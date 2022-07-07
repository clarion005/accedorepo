Sub init()
    print chr(10) "===== HomeScene.brs"
    m.RowList = m.top.findNode("RowList")
    m.Title = m.top.findNode("Title")
    m.Description = m.top.findNode("Description")
    'm.Poster = m.top.findNode("Poster")
    m.RowList.setFocus(true)
    m.LoadTask = CreateObject("roSGNode", "FeedParser")  'Create XML parsing node task

    m.LoadTask.observeField("content", "rowListContentChanged")
    m.LoadTask.observeField("mediaIndex","indexloaded")
    m.LoadTask.control = "RUN"  'Run the task node

    m.InputTask=createObject("roSgNode","inputTask")
    m.InputTask.observefield("inputData","handleInputEvent")
    m.InputTask.control="RUN"

    m.RowList.observeField("rowItemFocused", "changeContent")

    m.Video = m.top.findNode("Video")
    m.Video.observeField("state", "onVideoStateChanged")
    m.Video.observeField("position", "onVideoPositionChanged")
    m.VideoContent = createObject("roSGNode", "ContentNode")
    m.RowList.observeField("rowItemSelected", "playVideo")

    ' so we can use next video in playlist'
    m.Video.contentIsPlaylist = true
End Sub

sub indexloaded(msg as Object)
    if type(msg) = "roSGNodeEvent" and msg.getField() = "mediaIndex"
        m.mediaIndex = msg.getData()
        print "m.mediaIndex= "  m.mediaIndex
    end 
end sub

Function handleTransport(evt as Object) as String
  print chr(10) "HomeScene.handleTransport()"
  ret = "unhandled"
  print "is video visible? " m.Video
    if validateTransportControl(evt) and m.Video.visible = true
      ret = "success"
      cmd = evt.command
      if cmd = "next"
        ' skip to next content in playlist'
        m.Video.control = "skipcontent"
      else
        ' any transport control command other than next is handled in firmware'
        ' so unhandled means 'unhandled in our code' not 'unhandled in the app' because
        ' the app still has the event handled but by RokuOS and not by our explicit coding
        ret = "unhandled"
      end if
  else
    ret = "error.no-media"
  end if
  return ret
end Function


sub handleInputEvent(msg)
    print "in handleInputEvent()"
    print "HomeScene.handleInputEvent() message event = " msg 
    print "HomeScene.handleInputEvent() type(msg) = " type(msg)
    print "HomeScene.handleInputEvent() msg.getField() = " msg.getField()
    if type(msg) = "roSGNodeEvent" and msg.getField() = "inputData"
        print "HomeScene.handleInputEvent() message data = " msg.getData()
        inputData = msg.getData()
        if inputData <> invalid
          print "HomeScene.handleInputEvent() messasge data type = " inputData.type
          if inputData.type = "deeplink"
            handleDeepLink(inputData)
            #if enableNextCmd
            print "manifest 'next' command is enabled for voice control"
            else
              print "handling event but event is not deep link so call handleTransport()"
              ret = handleTransport(inputData)
              m.InputTask.transportResponse = {id: inputData.id, status: ret}
              print "HomeScene inputTask.transportResponse = " m.inputTask.transportResponse
            #end if
          end if
        end if
    end if
end sub

function validateDeepLink(deeplink as Object) as Boolean
  mediatypes={movie:"movie",episode:"episode",season:"season",series:"series"}
  if deeplink <> Invalid
      print "mediaType = "  deeplink.mediaType
      print "contentId = "  deeplink.id
      print "content= "  m.mediaIndex[deeplink.id]
      if deeplink.mediaType <> invalid then
        if mediatypes[deeplink.mediaType]<> invalid
          if m.mediaIndex[deeplink.id] <> invalid
            if m.mediaIndex[deeplink.id].url <> invalid
              return true
            else
                print "invalid deep link url"
            end if
          else
            print "bad deep link contentId"
          end if
        else
          print "unknown media type"
        end if
      else
        print "deeplink.type string is invalid"
      end if
  end if
  return false
end function

function validateTransportControl(transport as Object) as Boolean
  print "HomeScene.validateTransportControl() always returns TRUE !"
  print "transport object holds" transport
  return true
end function

Sub rowListContentChanged(msg as Object)
    if type(msg) = "roSGNodeEvent" and msg.getField() = "content"
        m.RowList.content = msg.getData()
    end if
end Sub

Sub changeContent()  'Changes info to be displayed on the overhang
    contentItem = m.RowList.content.getChild(m.RowList.rowItemFocused[0]).getChild(m.RowList.rowItemFocused[1])
    'contentItem is a variable that points to (rowItemFocused[0]) which is the row, and rowItemFocused[1] which is the item index in the row

    m.top.backgroundUri = contentItem.HDPOSTERURL  'Sets Scene background to the image of the focused item
    'm.Poster.uri = contentItem.HDPOSTERURL  'Sets overhang image to the image of the focused item
    m.Title.text = contentItem.TITLE  'Sets overhang title to the title of the focused item
    m.Description.text = contentItem.DESCRIPTION  'Sets overhang description to the description of the focused item
    print "row = " m.RowList.rowItemFocused[0] " col " m.RowList.rowItemFocused[1]
End Sub

Sub playVideo(url = invalid)
    print "url= "  url
    if type(url) = "roSGNodeEvent"   ' passed from observe callback'
        m.videoContent = m.RowList.content.getChild(m.RowList.rowItemFocused[0])
        'rowItemFocused[0] is the row and rowItemFocused[1] is the item index in the row
    else
        m.videoContent.url = url
    end if

    m.videoContent.streamFormat = "mp4"
    keepPlaying = false

    m.Video.content = m.videoContent

    m.Video.visible = "true"
    m.Video.control = "play"
    column = m.RowList.rowItemFocused[1]
    ' avoid double loading bar if it is first item'
    if column > 0
      m.video.nextContentIndex = column
      m.Video.control = "skipcontent"
    end if

    m.Video.setFocus(true)

    m.vector2danimation = m.top.FindNode("moveOverhangPanelUp")
    m.vector2danimation.repeat = false
    m.vector2danimation.control = "start"
End Sub

Function returnToUIPage()
    print "m.Video.pauseBufferStart= "  m.Video.pauseBufferStart
    m.Video.visible = "false" 'Hide video
    m.Video.control = "stop"  'Stop video from playing
    m.RowList.setFocus(true)

    m.vector2danimation = m.top.FindNode("moveOverhangPanelDown")
    m.vector2danimation.repeat = false
    m.vector2danimation.control = "start"
end Function

Function onVideoStateChanged(msg as Object)
  print chr(10) "HomeScene onVideoStateChanged()"
  if type(msg) = "roSGNodeEvent" and msg.getField() = "state"
      state = msg.getData()
      print tab(4) "onVideoStateChanged() state= "  state
      if state = "finished"
          returnToUIPage()
      end if
  end if
end Function

Function onVideoPositionChanged(msg as Object)
  if type(msg) = "roSGNodeEvent" and msg.getField() = "position"
      position = msg.getData()
      print "HomeScene onVideoPositionChanged() position" position " contentIndex" m.video.contentIndex " nextcontentindex " m.video.nextcontentindex  
  end if
end Function

Function onKeyEvent(key as String, press as Boolean) as Boolean  'Maps back button to leave video
    if press
      print "pressed key="  key
        if key = "back"  'If the back button is pressed
            if m.Video.visible
                returnToUIPage()
                return true
            else
                return false
            end if
        end if
    end if
end Function
