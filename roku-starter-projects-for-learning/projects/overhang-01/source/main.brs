sub Main()
    print "debugging showChannelSGScreen"
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    print (m.port)
    ' set tv
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("OverhangExample")
    screen.show()
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

function ConstructMyObject()
    obj = {
        Set       : function(x) : m.Value = x : end function
        Get       : function() : return m.Value : end function
        Value     : 0
    }
    return obj
end function