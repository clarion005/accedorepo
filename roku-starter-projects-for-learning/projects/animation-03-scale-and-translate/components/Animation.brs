sub init()
    scaleAnimation = m.top.FindNode("scaleAnimation")
    transAnimation = m.top.FindNode("transAnimation")
    scaleAnimation.control = "start"
    transAnimation.control = "start"
    print "scaleAnimation " scaleAnimation
end sub