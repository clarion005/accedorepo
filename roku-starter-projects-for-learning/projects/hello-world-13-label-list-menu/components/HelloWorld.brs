sub init()   
    ' background URL
    m.top.backgroundURI="https://t3.ftcdn.net/jpg/04/22/08/36/360_F_422083634_hfVZr5ktn0pxZSU8q400TVkwgNgMeKDC.jpg"

    ' overhang
    overhang = CreateObject("roSGNode","Overhang")
    ' blank image
    overhang.logoUri = "https://dummyimage.com/1x1/000/fff.png"
    overhang.backgroundUri="https://dka575ofm4ao0.cloudfront.net/pages-transactional_logos/retina/7516/UArysLzQwa7hdwDcdPok"
    overhang.color="0x232323ff"
    m.top.appendChild(overhang)
    
    ' button menu
    buttonLabel = CreateObject("roSGNode","Label")
    buttonLabel.text = "button list"
    buttonLabel.translation = [130,100]  
    m.top.appendChild(buttonLabel)

    buttonGroup = CreateObject("roSGNode", "ButtonGroup")
    buttonGroup.id = "exampleButtonGroup"
    buttonGroup.buttons = ["Accedo TV", "Movies", "Catch Up", "Sports", "News", "Watch Later"]
    buttonGroup.translation = [50,150]
    buttonGroup.iconUri="https://icons.iconarchive.com/icons/iconsmind/outline/24/Eci-Icon-icon.png"
    buttonGroup.focusedIconUri="https://icons.iconarchive.com/icons/iconsmind/outline/48/Eci-Icon-icon.png"
    'buttonGroup.setFocus(true)
    m.top.appendChild(buttonGroup)

    ' label list menu
    labelList02Label = CreateObject("roSGNode","Label")
    labelList02Label.text = "label list in code"
    labelList02Label.translation = [530,100]  
    m.top.appendChild(labelList02Label)

    labelList = CreateObject("roSGNode", "LabelList")
    labelList.id = "label-list-02"
    labelList.itemSize=[200,50]
    labelList.translation = [550,150]
    labelList.font = "font:MediumSystemFont"
    labelList.focusedFont = "font:MediumSystemFont"
    labelList.focusedColor="0xffffff"
    labelList.focusedFont.size = labelList.font.size+5
    labelList.focusBitmapUri="https://dummyimage.com/100x20/526ae3/526ae3"
    m.content = CreateObject("roSGNode","ContentNode")
    addContent("Accedo TV")
    addContent("Movies")
    addContent("Catch Up")
    addContent("Sports")
    addContent("News")
    addContent("Watch Later Later Later")
    addSection()
    labelList.content = m.content
    m.top.appendChild(labelList)
    labelList.setFocus(true)
    'm.top.setFocus(true)
end sub

sub addContent(itemTitle as String)
    item = m.content.createChild("ContentNode")
    item.title=itemTitle
end sub

sub addSection()
    m.section=m.content.createChild("ContentNode")
    m.section.contentType="section"
end sub