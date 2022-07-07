sub main()

    print chr(10) chr(10) "== in main.brs =="

    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("Global")

    gaa = GetGlobalAA()
    print "m = getGlobalAA() in main.brs " gaa 
    
    m.global=screen.getGlobalNode()
    m.global.AddFields({"phil":true})
    print "m.global in main " m.global

    gaa = GetGlobalAA()
    print "m = getGlobalAA() in main.brs " gaa 

    
    screen.show()
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub