sub init()
    print chr(10) chr(10) "== in the component =="
    print "m.global in the component " m.global

    print "in the component, 'm' is the same as 'getGlobalAA()'"
    m.testValue = "this is a test value"

    gaa = GetGlobalAA()
    print "getGlobalAA() in the component " gaa
    print "gaa.testValue = " gaa.testValue
    print "m.testValue = " m.testValue
end sub