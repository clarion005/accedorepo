sub init()
    m.label=CreateObject("roSGNode","Label")
    m.label.text = "Select the right dialog option"
    m.label.translation=[100,400]
    m.label.font.size=50
    m.label.color="0xdddddd"
    m.top.appendChild(m.label)

    m.buttongroup = CreateObject("roSGNode","ButtonGroup")
    m.buttongroup.buttons = ["Start here","Open Dialog Box","Finish Here"]
    m.buttongroup.translation=[100,150]
    m.buttongroup.observeField("buttonFocused","onButtonFocused")
    m.buttongroup.observeField("buttonSelected","onButtonSelected")
    m.top.appendChild(m.buttongroup)
    m.buttongroup.setFocus(true)


end sub
sub onButtonFocused(event)
    index = m.buttongroup.buttonFocused
    buttonText = event.GetRoSGNode().buttons[index]
    print "button focused with index " index " and text " buttonText
end sub
sub onButtonSelected(event)
    index = m.buttongroup.buttonSelected
    buttonText = event.GetRoSGNode().buttons[index]
    print "button selected with index " index " and text " buttonText
    if (index = 0)
        m.label.text="try another option"
    else if (index = 1)
        displayDialog()
    else if (index = 2)
        m.label.text="you have finished"
    end if
end sub
function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false
    if (press) then
        if (key="ok") then
            print "ok key hit"
            handled = true
        end if
    end if
    return handled
end function
sub displayDialog()
    ' create dialog but do not display yet
    m.dialog=CreateObject("roSGNode","Dialog")
    m.dialog.title="This is a dialog"
    m.dialog.message="This is a message about the dialog"
    m.dialog.bulletText=["one","two","three"]
    m.dialog.buttons=["choose option 1","or option 2","exit"]
    m.dialog.optionsDialog = true 
    m.dialog.observeField("buttonFocused","onDialogFocused")
    m.dialog.observeField("buttonSelected","onDialogSelected")
    m.dialog.close=false
    m.top.dialog = m.Dialog
    m.dialog.setFocus(true)
end sub
sub onDialogFocused()
    print "a button was focused with index " m.dialog.buttonFocused
end sub
sub onDialogSelected(event)
    index = m.dialog.buttonSelected
    dialog = event.GetRoSGNode()
    buttonText = dialog.buttons[index]
    print "dialog data is " dialog
    print "button " index " was selected with text '" buttonText  "'"
    if (index = 0)
        m.label.text="You Chose Option 1"
        m.dialog.close=true
    else if (index = 1)
        m.label.text="You Chose Option 2"
        m.dialog.close=true
    ' just being smart here but in real life would not do this!
    ' should either do all index or all values, not mix them!
    else if (buttonText = "exit")
        print "exit dialog"
        m.label.text="You Did Not Choose An Option"
        m.dialog.close=true
    end if
end sub