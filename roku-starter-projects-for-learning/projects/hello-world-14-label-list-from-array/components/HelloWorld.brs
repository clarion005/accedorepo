sub init()   
    ' background URL
    m.top.backgroundURI="https://lh3.googleusercontent.com/proxy/yvuItOgMIMxJRpKM3rD8FPHymLGlxaPcq_OCBf-LwyOUZZLJlY3v7LxyykjVRTdaGc_NKvKxuqbdgv9yHOSVQfzX7yVs60774keNi555zHmAAg1rradw6A9dD3NzTPo_g3s"

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
    labelList02Label.translation = [550,100]  
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
    addSection()
    addContent("Accedo TV")
    addContent("Movies")
    addContent("Catch Up")
    addContent("Sports")
    addContent("News")
    addContent("Watch Later")
    addSection()
    addContent("More...")
    labelList.content = m.content
    m.top.appendChild(labelList)
    labelList.setFocus(true)
    'm.top.setFocus(true)

    ' label list from array
    labelList03Label = CreateObject("roSGNode","Label")
    labelList03Label.text = "label list from array"
    labelList03Label.translation = [780,100]  
    m.top.appendChild(labelList03Label)

    m.labellist03 = CreateObject("roSGNode","LabelList")
    m.labelList03.itemSize=[200,50]
    m.labelList03.translation = [780,150]
    m.labelList03.focusBitmapUri="https://dummyimage.com/100x20/526ae3/526ae3"
    ' create content for label list
    m.content = CreateObject("roSGNode","ContentNode")
    names = ["Accedo TV", "Movies", "Catch Up", "Sports", "News", "Watch Later"]
    for each name in names 
        item = m.content.createChild("ContentNode")
        item.title=name
    end for
    m.labellist03.content=m.content
    m.top.appendChild(m.labellist03)
    m.labellist03.setFocus(true)
end sub

sub addContent(itemTitle as String)
    item = m.section.createChild("ContentNode")
    item.title=itemTitle
end sub

sub addSection()
    m.section=m.content.createChild("ContentNode")
    m.section.contentType="section"
end sub