sub init()
end sub
sub showcontent()
    itemcontent = m.top.itemContent
    print "markup list content has text " itemcontent.text
    m.poster=CreateObject("roSGNode","Poster")
    m.poster.uri=itemcontent.HDPosterUrl
    m.poster.width=220
    m.poster.height=180
    m.label=CreateObject("roSGNode","Label")
    m.label.text=itemcontent.text
    m.label.visible=false
    m.top.appendChild(m.label)
    m.top.appendChild(m.poster)
end sub