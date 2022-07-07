sub Main(args)
    screen = CreateObject("roSGScreen")  'Create Screen object
    m.port = CreateObject("roMessagePort")  'Create Message port
    screen.setMessagePort(m.port)  'Set message port to listen to screen

    scene = screen.CreateScene("HomeScene")  'Create HomeScene
    device = CreateObject("roDeviceInfo")
    device.setMessagePort(m.port)
    'device.EnableOptionKeyEvent(true)

    m.global = screen.getGlobalNode()
    print "args= "  formatjson(args)      'pretty print AA'
    deeplink = getDeepLinks(args)
    print "deeplink= "  deeplink
    m.global.addField("deeplink", "assocarray", false)
    m.global.deeplink = deeplink
    m.global.addField("version", "string", false)
    m.global.version = getOSVersion()    ' format OS major + minor, e.g 900 or 910'
    print "m.global.version= "  m.global.version


    screen.show()

    while(true)  'Listens to see if screen is closed
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if msgType = "roDeviceInfoEvent"
            print "devInfoEvent msg.getInfo= "  msg.getInfo()
            print "devInfoEvent msg.getData= "  msg.getData()
        end if
    end while
end sub

Function getDeepLinks(args) as Object
    deeplink = Invalid

    if args.contentid <> Invalid and args.mediaType <> Invalid
        deeplink = {
            id: args.contentId
            type: args.mediaType
        }
    end if

    return deeplink
end Function

Function getOsVersion() as string
  version = createObject("roDeviceInfo").GetVersion()

  major = Mid(version, 3, 1)
  minor = Mid(version, 5, 2)
  'build = Mid(version, 8, 5)

  return major + minor
end Function
