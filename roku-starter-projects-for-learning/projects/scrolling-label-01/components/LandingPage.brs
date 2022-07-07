sub init()
    m.overhang = CreateObject("roSGNode","Overhang")
    m.overhang.backgroundUri = "https://www.calmsage.com/wp-content/uploads/2020/04/calm-desktop-wallpapers-1024x679.jpg"
    m.overhang.title="Phil TV Showing Channel 4"
    m.overhang.visible=true
    m.top.appendChild(m.overhang)

    m.label = CreateObject("roSGNode","ScrollingLabel")
    m.label.text = "Phil TV on Channel 4.  Watch Here For The Latest Christmas Movies And Entertainment"
    m.label.translation = [100,150]
    m.label.font.size=60
    m.label.maxWidth = 1100
    m.top.backgroundURI="https://wallpaperaccess.com/full/1128988.jpg"
    m.top.appendChild(m.label)

    m.top.setFocus(true)
end sub