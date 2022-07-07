sub init()
    'm.top.backgroundUri="https://img.freepik.com/free-photo/hand-painted-watercolor-background-with-sky-clouds-shape_24972-1095.jpg?size=626&ext=jpg"

    m.label=CreateObject("roSGNode","Label")
    m.label.text = "Here is a label"
    m.label.translation=[100,200]
    m.label.font.size=50
    m.label.color="0xff0000"
    m.top.appendChild(m.label)
end sub