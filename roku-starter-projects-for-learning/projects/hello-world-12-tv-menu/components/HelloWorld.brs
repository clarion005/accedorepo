sub init()   
    ' background URL
    m.top.backgroundURI="https://dka575ofm4ao0.cloudfront.net/pages-transactional_logos/retina/7516/UArysLzQwa7hdwDcdPok"

    ' overhang
    overhang = CreateObject("roSGNode","Overhang")
    ' remove the built-in Roku logo
    overhang.logoUri = " "
    overhang.backgroundUri="https://dka575ofm4ao0.cloudfront.net/pages-transactional_logos/retina/7516/UArysLzQwa7hdwDcdPok"
    overhang.color="0x232323ff"
    m.top.appendChild(overhang)
    overhang.setFocus(true)
    
    buttonGroup = CreateObject("roSGNode", "ButtonGroup")
    buttonGroup.id = "exampleButtonGroup"
    buttonGroup.buttons = ["Accedo TV", "Movies", "Catch Up", "Sports", "News", "Watch Later"]
    buttonGroup.translation = [100,150]
    buttonGroup.iconUri=""
    buttonGroup.focusedIconUri=""
    m.top.appendChild(buttonGroup)
    buttonGroup.setFocus(true)
end sub

