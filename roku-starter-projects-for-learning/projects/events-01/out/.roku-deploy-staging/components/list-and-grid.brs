sub init()
    print "initialising main screen"
    m.list=m.top.findNode("markup-list")
    m.list.content=CreateObject("roSGNode","MarkupListContent")
    m.list.translation="[50,50]"
    m.list.observeField("itemSelected","onMarkupListItemSelected")
    buttongroup = m.top.findNode("button-group")
    buttongroup.buttons = [ "To List", "To Grid", "Exit App" ]
    buttongroup.translation = [300,50]
    buttongroup.ObserveField("buttonSelected","checkWhichButtonSelected")
    m.top.setFocus(true)
end sub
function checkWhichButtonSelected(event)
    print "a button was selected"
    print event
    button = event.GetRoSGNode()
    content = button.content 
    index = event.GetData()
    print "index of button selected is" index
    print "content of event is " content
    print "button of event is " button
    print "focused child button is " button.focusedChild
    print "text of focused child is " button.focusedChild.text
    if (button.focusedChild.text = "Exit App") then
        m.top.exitApp = true
    else if (button.focusedChild.text = "To List") then
        grid = m.top.findNode("markup-list")
        grid.setFocus(true)
    else if (button.focusedChild.text = "To Grid") then
        print "next screen is to be the grid"
        grid = m.top.findNode("markup-list")
        grid.setFocus(true)
    end if
end function
function onMarkupListItemSelected()
    print "a markup list item was selected"
    itemIndex = m.list.itemSelected 
    print "item index selected is " itemIndex
    m.list.content.getChild(itemIndex)
end function
function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if (press) then
        if (key="replay") then
            m.top.exitApp = true
        end if
        if (key = "right") then
            buttongroup = m.top.findNode("button-group")
            buttongroup.setFocus(true)
        end if
        handled = true
    end if
    return handled
end function