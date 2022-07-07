sub init()
    print "initialising custom component"
    counter = m.top.counter
    print "interface field has value" counter
    printThis = m.top.printThis
    print "interface function about to be run"
    printThis("printing from inside the custom component")
end sub
function printThis(aTask as String)
    print "inside child interface function"
    print "I am doing this task - " aTask
end function