sub Main(args)
    print chr(10) "===== main.brs - starting app"
    screen = CreateObject("roSGScreen")  
    m.port = CreateObject("roMessagePort")
    print "message port = " m.port
    screen.setMessagePort(m.port)  

    scene = screen.CreateScene("HomeScene") 
    device = CreateObject("roDeviceInfo")
    device.setMessagePort(m.port)
    device.EnableOptionKeyEvent(true)

    screen.show()

    while(true)  
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if msgType = "roDeviceInfoEvent"
            print "devInfoEvent msg.getInfo = " msg.getInfo()
            print "devInfoEvent msg.getData = " msg.getData()
        end if
    end while
end sub