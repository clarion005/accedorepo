sub init()   

    
    ' background URL
    m.top.backgroundURI="https://t3.ftcdn.net/jpg/04/22/08/36/360_F_422083634_hfVZr5ktn0pxZSU8q400TVkwgNgMeKDC.jpg"

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
    buttonGroup.observeField("buttonSelected","onButtonSelected")
    m.top.appendChild(buttonGroup)
    buttonGroup.setFocus(true)

    ' label list menu
    labelList = CreateObject("roSGNode", "LabelList")
    labelList.id = "label-list-02"
    labelList.translation = [100,100]
    m.content = CreateObject("roSGNode","ContentNode")
    addContent("Movies")
    addContent("Catch Up")
    addContent("Sports")
    addContent("News")
    addContent("Watch Later")
    m.top.appendChild(labelList)
    'labelList.setFocus(true)

    mainmenu()
end sub

sub addContent(itemTitle as String)
    item = m.content.createChild("ContentNode")
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
        else if key = "left" OR key = "right"
            print "left/right key pressed so switching focus between different menus"

        end if
        handled = true
    end if
    return handled
end function


sub mainmenu()
    m.menu=CreateObject("roSGNode","ButtonGroup")
    m.menu.buttons=["Movies","TV Shows","Series","CatchUp","4OD","More..."]
    m.menu.translation=[300,150]
    m.menu.iconUri=""
    m.menu.focusedIconUri=""
    m.menu.observeField("buttonFocused","onButtonFocused")
    m.menu.observeField("buttonSelected","onButtonSelected")
    m.top.appendChild(m.menu)
    m.menu.setFocus(true)
end sub

    
sub onButtonFocused(event)
    print "a button was focused"
    print "button focused event object holds " event
    ' button group holds multiple buttons so extract the button 
    buttonGroup = event.getRoSgNode()
    content = buttonGroup.content 
    index = event.getData()
    print "index of button focused is " index 
    print "event content = " content 
    print "button group is " buttonGroup
    print "focused button is " buttonGroup.focusedChild
    print "focused button text is " buttonGroup.focusedChild.text 
end sub

sub onButtonSelected(event)
    print "a button was selected"
    print "button selected event object holds " event
    ' button group holds multiple buttons so extract the button 
    buttonGroup = event.getRoSgNode()
    content = buttonGroup.content 
    index = event.getData()
    print "index of button selected is " index 
    print "event content = " content 
    print "button group is " buttonGroup
    print "focused button is " buttonGroup.focusedChild
    print "focused button text is " buttonGroup.focusedChild.text 
end sub