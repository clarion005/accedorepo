sub Main()
    Print "PanelSet example"
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    print (m.port)
    ' array
    array01 = [1,2,3]
    array01.push(4)
    for each item in array01
        Print item
    end for
    ' tv
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("Rectangle01")
    screen.show()
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub
