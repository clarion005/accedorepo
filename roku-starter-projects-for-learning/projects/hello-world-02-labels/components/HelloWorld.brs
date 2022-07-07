sub init()
    ' identify node
    label01 = m.top.findNode("label01")
    'Set the font size
    label01.font.size=60
    'Set the color to light blue
    label01.color="0x72D7EEFF"
    label01.text = label01.text + " .. and some more"
    
    ' create object completely from scratch in Brightscript
    ' roSGNode = Roku Scenegraph (XML) Node of type Label
    label02 = CreateObject("roSGNode","Label")
    label02.color="0x72D7EEFF"
    label02.font.size=60
    label02.translation = [100,370]
    label02.text = "Label generated in Brightscript"
    ' attach component to m.top which is the root of 'this' object
    m.top.appendChild(label02)

    simpleLabel02 = CreateObject("roSGNode","SimpleLabel")
    simpleLabel02.translation = [100,550]
    simpleLabel02.text = "SimpleLabel generated in Brightscript"
    simpleLabel02.color = "0x1457BF" 
    simpleLabel02.size = 30
    m.top.appendChild(simpleLabel02)
end sub