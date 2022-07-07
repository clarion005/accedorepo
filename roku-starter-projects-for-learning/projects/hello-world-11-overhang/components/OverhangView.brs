sub init()
    overhang=CreateObject("roSGNode","Overhang")  
    overhang.id="overhang"
    overhang.backgroundUri="https://wallpaperaccess.com/full/1128988.jpg"
    overhang.title="This is an overhang"
    overhang.titleColor="0xeeeeeeff" 
    overhang.color="0x232323ff"
    overhang.showOptions="true" 
    overhang.optionsText="some options" 
    overhang.optionsAvailable="true"
    m.top.appendChild(overhang)
    overhang.visible=true
    overhang.setFocus(true)
end sub