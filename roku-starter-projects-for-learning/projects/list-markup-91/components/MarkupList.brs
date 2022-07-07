sub init()
    m.list=CreateObject("roSGNode","MarkupList")  
    m.list.id="list"    
    m.list.translation=[200,200]
    m.list.itemComponentName="PosterItem"
    m.list.content=CreateObject("roSGNode","ContentNode")
    addItem("https://i.pinimg.com/originals/9d/3e/5e/9d3e5e7c1c13ff2dcbf7c1f4e03a0c56.jpg")
    addItem("https://images-na.ssl-images-amazon.com/images/I/5101NtSnx0L._AC_.jpg")
    addItem("https://dynamicmedia.zuza.com/zz/m/original_/8/f/8f10ad63-55ae-452d-8f09-3e7e931788d6/B822048321Z.1_20150728071014_000_G1G1H6QSV.3_Gallery.jpg")
    addItem("https://i.ytimg.com/vi/u1MvKUDYq68/maxresdefault.jpg")
    addItem("https://upload.wikimedia.org/wikipedia/en/thumb/1/17/Bugs_Bunny.svg/1200px-Bugs_Bunny.svg.png")
    m.top.appendChild(m.list)
    m.list.visible=true
    m.list.setFocus(true)
    m.list.observeField("itemSelected","onItemSelected")
end sub
sub addItem(uri as String)
    item=CreateObject("roSGNode","ContentNode")
    item.uri=uri
    m.list.content.appendChild(item)
end sub