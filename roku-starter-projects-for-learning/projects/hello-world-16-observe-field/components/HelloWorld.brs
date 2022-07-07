sub init()   
    ' background URL
    m.top.backgroundURI="https://lh3.googleusercontent.com/proxy/yvuItOgMIMxJRpKM3rD8FPHymLGlxaPcq_OCBf-LwyOUZZLJlY3v7LxyykjVRTdaGc_NKvKxuqbdgv9yHOSVQfzX7yVs60774keNi555zHmAAg1rradw6A9dD3NzTPo_g3s"

    ' overhang
    overhang = CreateObject("roSGNode","Overhang")
    ' remove the built-in Roku logo
    overhang.logoUri = " "
    overhang.backgroundUri="https://dka575ofm4ao0.cloudfront.net/pages-transactional_logos/retina/7516/UArysLzQwa7hdwDcdPok"
    overhang.color="0x232323ff"
    m.top.appendChild(overhang)
    
    ' button menu
    buttonGroup = CreateObject("roSGNode", "ButtonGroup")
    buttonGroup.id = "exampleButtonGroup"
    buttonGroup.buttons = ["Accedo TV", "Movies", "Catch Up", "Sports", "News", "Watch Later"]
    buttonGroup.translation = [100,150]
    buttonGroup.iconUri=""
    buttonGroup.focusedIconUri=""
    m.top.appendChild(buttonGroup)
    buttonGroup.setFocus(true)

    ' label list menu
    labelList = CreateObject("roSGNode", "LabelList")
    labelList.id = "label-list-02"
    labelList.translation = [100,100]
    m.content = CreateObject("roSGNode","ContentNode")
    addContent("Accedo TV")
    addContent("Movies")
    addContent("Catch Up")
    addContent("Sports")
    addContent("News")
    addContent("Watch Later")
    addSection()
    m.top.appendChild(labelList)
    addSection()
    addSectionContent("More...")
end sub

sub addContent(itemTitle as String)
    item = m.content.createChild("ContentNode")
    item.title=itemTitle
end sub

sub addSection()
    m.section=m.content.createChild("ContentNode")
    m.section.contentType="Section"
end sub

sub addSectionContent(itemTitle as string)
    item = m.section.createChild("ContentNode")
    item.title=itemTitle
end sub

function onKeyEvent(key as string, press as boolean) as boolean 
    handled = false
    ' press relates to TRUE when key is pressed IN and FALSE when released
    print "handling a key event - key pressed was " key " and key presed in was " press
    if (press) then
        print "a key was pressed"
        if (key = "OK")
            print "OK key was pressed"
        end if
        handled = true
    end if
    return handled
end function