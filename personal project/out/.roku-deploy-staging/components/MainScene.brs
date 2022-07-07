sub init()
    print "Hello, world"
end sub

sub doSomething() 
    print m.top.findNode("MainView")
    m.top.findNode("MainView").visible = false
    m.top.findNode("PlayerView").visible = true
    print "Nardo Wick"
end sub

