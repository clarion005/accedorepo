sub init()
    overhang=CreateObject("roSGNode","Overhang")  
    overhang.id="overhang"
    overhang.backgroundUri="https://wallpaperaccess.com/full/1128988.jpg"
    overhang.title="This is an overhang"
    m.top.appendChild(overhang)
    overhang.visible=true
    overhang.setFocus(true)
end sub