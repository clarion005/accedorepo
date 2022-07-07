Sub Init()
    print chr(10) " ===== inputTask.brs"
    m.port=createobject("romessageport")
    m.top.observeField("transportResponse", m.port)
    m.xfer = createObject("roUrlTransfer")
    m.transportIdList = {}
    m.top.functionName = "listenInput"
End Sub

function ListenInput()
    print chr(10) "ListenInput() listens for voice commands"
    InputObject=createobject("roInput")
    InputObject.setmessageport(m.port)
    #if enableNextCmd
      print "inputTask m.global.version = " m.global.version
      if m.global.version >= "910"
        print "handling input events as m.global.version >= 910"
        InputObject.enableTransportEvents()
      end if
    #end if
    while true
      msg=m.port.waitmessage(500)
      if type(msg)="roInputEvent" then
        print "inputTask INPUT EVENT! m.port = " m.port
        print "inputTask msg = " msg
        print "inputTask msg.isInput() = " msg.isInput()
        if msg.isInput()  
          inputData = msg.getInfo()
          print "inputData = msg.getInfo() = (command, id, type) = " inputData
          ' pass the deeplink to UI
          if inputData.DoesExist("mediaType") and inputData.DoesExist("contentID")
            deeplink = {
                id: inputData.contentID
                mediaType: inputData.mediaType
                type: "deeplink"
            }
            print "got input deeplink= " deeplink
            m.top.inputData = deeplink
          #if enableNextCmd
          else if m.global.version >= "910" and inputData.DoesExist("type") and inputData.type = "transport"
            transport = {
                id: inputData.id
                command: inputData.command
                duration: inputData.duration
                direction: inputData.direction
                type: inputData.type
            }
            print "got transport input= " transport
            m.transportIdList[inputData.id] = {transport: transport}
            print "id list size=" m.transportIdList.count()
            m.top.inputData = transport
          #end if
          end if
        end if
      #if enableNextCmd
      else if type(msg) = "roSGNodeEvent"
        print "message type is roSGNodeEvent"
        if msg.getField() = "transportResponse"            
            response = msg.getData()
            print "transport response= " response
            id = response.id
            job = m.transportIdList[id]
            if job <> invalid
                eventStatus = response.status
                ' Send the response (may need to be after command executed)
                InputObject.EventResponse({id:inputData.id, status: eventStatus})
                m.transportIdList.delete(id)
                print "deleted from list id= " id
            else
                print "id= " id " not found"
            end if
        end if
      #end if
      end if
    end while
end function