sub Main()
    print "in showChannelSGScreen"
    'Indicate this is a Roku SceneGraph application'
    'Creates screen'
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)

    'Create a scene and load /components/helloworld.xml'
    scene = screen.CreateScene("MainScene")
    screen.show()

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        end if
    end while
end sub

' sub Main2()
'     print "in showChannelSGScreen"
'     'Indicate this is a Roku SceneGraph application'
'     'Creates Poster node'
'     poster = CreateObject("roSGNode", "Poster")
'     m.port = CreateObject("roMessagePort")
'     poster.setMessagePort(m.port)

'     'Create a scene and load /components/helloworld.xml'
'     'Creates a Poster'
'     poster = poster.CreateScene("MainScene")
'     poster.show()

'     while(true)
'         msg = wait(0, m.port)
'         msgType = type(msg)
'         if msgType = "roSGScreenEvent"
'             if msg.isScreenClosed() then return
'         end if
'     end while
' end sub