function main(args as Dynamic) as Boolean
    Screen = createObject("roSGScreen")
    m.Port = createObject("roMessagePort")
    Screen.setMessagePort(m.Port)

    m.Global = Screen.getGlobalNode()
    m.Global.addFields({"stack": []})

    MainScene = Screen.createScene("MainScene")
    MainScene.deeplinkArgs = args
    Screen.show()

    #if runUnitTests
        args.runTests = "true"

        if args.runTests = "true" and type(TestRunner) = "Function" then
            runner = TestRunner()

            runner.setFunctions([
                TestSuite__StringUtils
            ])

            runner.Logger.SetVerbosity(3)
            runner.run()
        end if
    #end if

    while(true)
        msg = wait(0, m.Port)
        msgType = type(msg)

        if msgType = "roSGScreenEvent" then
            if msg.isScreenClosed() then 
                return true
            end if
        end if
    end while
end function
