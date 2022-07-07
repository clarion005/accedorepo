sub init()
    m.simplelabel=CreateObject("roSGNode","SimpleLabel")
    m.simplelabel.id="simple-label"
    m.simplelabel.text="this is a simple label created automatically with brightscript and has a very long line of text which will wrap"
    m.top.appendChild(m.simplelabel)
    m.simplelabel.translation=[100,100]
    m.simplelabel.visible=true
    
    label=CreateObject("roSGNode","Label")
    label.id="label"
    label.text="this is a label created automatically with brightscript and has a very long line of text which will wrap"
    label.wrap="true"
    label.width=200
    m.top.appendChild(label)
    label.translation=[100,200]
    label.visible=true
end sub