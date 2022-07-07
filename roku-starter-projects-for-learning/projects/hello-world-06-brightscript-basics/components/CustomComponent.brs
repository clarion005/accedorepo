sub init()
    print "initialising custom component"
    label03 = CreateObject("roSGNode","Label")
    label03.color="0x72D7EEFF"
    label03.font.size=40
    label03.translation = [100,300]
    label03.text = "Label 03 in custom component from code"
    ' attach component to m.top which is the root of 'this' object
    m.top.appendChild(label03)
end sub