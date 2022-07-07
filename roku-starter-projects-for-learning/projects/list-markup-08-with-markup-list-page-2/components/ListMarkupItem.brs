sub init()
    m.itemlabel=m.top.findNode("itemLabel")
end sub
sub showcontent()
    print "showing content"
    m.itemcontent = m.top.itemContent
    print "m.itemcontent = m.top.itemContent = " m.top.itemContent
    m.itemlabel.text=m.itemContent.text
end sub