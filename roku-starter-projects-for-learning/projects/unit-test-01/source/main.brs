sub main()
    print "unit-test-01 main()"
    ' create TV screen object
    screen = CreateObject("roSGScreen")
    ' create event port to listen to messages
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    ' attach our xml file to the TV screen object
    scene = screen.CreateScene("UnitTest")
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

' ********** Copyright 2017 Roku Corp.  All Rights Reserved. **********

'Channel entry point
sub RunUserInterface(args)
    print "running application"
    if args.RunTests = "true" and type(TestRunner) = "Function" then
        print "running test runner"
        Runner = TestRunner()

        Runner.SetFunctions([
            TestSuite__Main
        ])

        Runner.Logger.SetVerbosity(3)
        Runner.Logger.SetEcho(false)
        Runner.Logger.SetJUnit(false)
        Runner.SetFailFast(true)
        print "runner.run()"
        Runner.Run()
    end if
end sub

Function GetApiArray()
    print "getApiArray()"
    url = CreateObject("roUrlTransfer")
    'External resource
    url.SetUrl("http://api.delvenetworks.com/rest/organizations/59021fabe3b645968e382ac726cd6c7b/channels/1cfd09ab38e54f48be8498e0249f5c83/media.rss")
    rsp = url.GetToString()

    'Utility function for XML parsing.
    'Based on native Bright Script XML parser.
    responseXML = Utils_ParseXML(rsp)
    If responseXML <> invalid then
        responseXML   = responseXML.GetChildElements()
        responseArray = responseXML.GetChildElements()
    End if

    'The result will be roArray object.
    result = []

    if responseArray <> invalid AND GetInterface(responseArray, "ifArray") <> invalid then 
        'Work with parsed XML and add to roArray some data.
        for each xmlItem in responseArray
            if xmlItem.getName() = "item"
                itemAA = xmlItem.GetChildElements()
                if itemAA <> invalid
                    item = {}
                    for each xmlItem in itemAA
                        if xmlItem.getName() = "media:content"
                            item.stream = {url : xmlItem.getAttributes().url}
                            item.url = xmlItem.getAttributes().url
                            item.streamFormat = "mp4"
                            mediaContent = xmlItem.GetChildElements()
                            for each mediaContentItem in mediaContent
                                if mediaContentItem.getName() = "media:thumbnail"
                                    item.HDPosterUrl = mediaContentItem.getattributes().url
                                    item.hdBackgroundImageUrl = mediaContentItem.getattributes().url
                                end if
                            end for
                        else
                            item[xmlItem.getName()] = xmlItem.getText()
                        end if
                    end for
                    result.push(item)
                end if
            end if
        end for
    end if
    return result
End Function

'----------------------------------------------------------------
' Prepends a prefix to every entry in Assoc Array
'
' @return An Assoc Array with new values if all values are Strings
' or invalid if one or more value is not String.
'----------------------------------------------------------------
Function AddPrefixToAAItems(AssocArray as Object) as Object
    prefix = "prefix__"

    for each key in AssocArray
        'Get current item
        item = AssocArray[key]

        'Check if current item is string
        if GetInterface(item, "ifString") <> invalid then
            'Prepend a prefix to current item
            item = prefix + item
        else
            'Return invalid if item is not string
            return invalid
        end if
    end for

    return AssocArray
End Function