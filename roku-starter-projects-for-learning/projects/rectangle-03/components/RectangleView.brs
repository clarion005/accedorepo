sub init()
    rectangle=CreateObject("roSGNode","Rectangle")  
    rectangle.id="rectangle"
    rectangle.width=200
    rectangle.height=400
    rectangle.color="0xcaebea"
    m.top.appendChild(rectangle)
    rectangle.translation=[100,200]
    rectangle.visible=true
    rectangle.setFocus(true)

    ' inner rectangle appended as a child of the parent rectangle
    rectangle2=CreateObject("roSGNode","Rectangle")  
    rectangle2.id="rectangle2"
    rectangle2.width=100
    rectangle2.height=200
    rectangle2.color="0xabdbda"
    rectangle.appendChild(rectangle2)
    rectangle2.translation=[20,20]
    rectangle2.visible=true
    rectangle2.setFocus(true)
end sub