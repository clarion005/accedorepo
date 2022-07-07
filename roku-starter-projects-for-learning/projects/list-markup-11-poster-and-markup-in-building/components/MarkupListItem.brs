sub init()
    m.label = m.top.findNode("item-label")
end sub
sub showcontent()
    ' get data from task then pass into item content node
    print "getting data"
    m.itemcontent = m.top.itemcontent
    print "m.top.itemcontent" m.top.itemcontent 
    ' pass data into text label
    m.label.text = m.itemcontent.text
end sub