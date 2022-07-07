sub main()
    ' create TV screen object
    screen = CreateObject("roSGScreen")
    ' create event port to listen to messages
    m.port = CreateObject("roMessagePort")
    print ".. port " m.port 
    screen.setMessagePort(m.port)
    ' attach our xml file to the TV screen object
    scene = screen.CreateScene("HelloWorld")
    ' display the TV screen with our object attached
    screen.show()
    ' listen for any keypad events (this is an "event loop")
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub