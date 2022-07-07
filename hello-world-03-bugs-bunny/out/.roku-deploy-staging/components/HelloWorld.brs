sub init()
    ' style our rectangle 01 label
    label01 = m.top.findNode("label01")
    label01.font.size = 30
    label01.color = "#FFC0CB"  
    ' create second rectangle purely in brightscript
    rectangle02 = CreateObject("roSGNode","Rectangle")
    rectangle02.translation = [350,100]
    rectangle02.width = 300
    rectangle02.height = 300
    rectangle02.color = "#FFFFFF"
    ' attach a label into this rectangle also
    label02 = CreateObject("roSGNode","Label")
    label02.color="#FFA500"
    label02.font.size=30
    label02.translation = [65,300]
    label02.text = "This is Daffy"
    rectangle02.appendChild(label02)
    m.top.appendChild(rectangle02)

    poster=CreateObject("roSGNode","Poster")  
    poster.id="poster"
    poster.uri="https://upload.wikimedia.org/wikipedia/en/thumb/f/f4/Daffy_Duck.svg/1200px-Daffy_Duck.svg.png"
    poster.width=200
    poster.height=300
    poster.translation=[50,0]
    rectangle02.appendChild(poster)
    
    rectangle03 = CreateObject("roSGNode","Rectangle")
    rectangle03.translation = [700,100]
    rectangle03.width = 300
    rectangle03.height = 300
    rectangle03.color = "#FFB6C1"

    label03 = CreateObject("roSGNode", "Label")
    label03.color = "#ff0000"
    label03.font.size = 30
    label03.translation = [65,300]
    label03.text = "This is Porky."
    rectangle03.appendChild(label03)
    m.top.appendChild(rectangle03)
    
    poster03=CreateObject("roSGNode","Poster")  
    poster03.id = "poster03"
    poster03.uri = "https://upload.wikimedia.org/wikipedia/en/thumb/8/88/Porky_Pig.svg/800px-Porky_Pig.svg.png"
    poster03.width=200
    poster03.height=300
    poster03.translation=[40,0]
    rectangle03.appendChild(poster03)

    ' poster is a focusable element
    poster.setFocus(true)
    poster03.setFocus(true)
end sub