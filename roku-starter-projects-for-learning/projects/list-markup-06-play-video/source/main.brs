sub main()
    print "in showChannelSGScreen"
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("ListAndGrid")
    screen.show()
    scene.observeField("exitApp", m.port)
    scene.observeField("nextScreen",m.port)
    scene.setFocus(true)

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)

        if msgType = "roSGScreenEvent" then
            if msg.isScreenClosed() then
                return
            end if
        else if msgType = "roSGNodeEvent" then
            field = msg.getField()
            if field = "nextScreen" then
                print "moving to next screen"
                print "field is " field
                print "data is " msg.getData()
                if (msg.getData()="list") then
                    print "next screen will be the list screen"
                    'GetScene2(screen)
                end if
            end if
            if field = "exitApp" then
                return
            end if
        end if
    end while
end sub

