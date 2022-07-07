' ********** Copyright 2020 Roku Corp.  All Rights Reserved. **********

' Note that we need to import this file in MainScene.xml using relative path.

sub ShowGridScreen()
    Print "Showing Grid Screen"
    m.GridScreen = CreateObject("roSGNode", "GridScreen")
    m.GridScreen.ObserveField("rowItemSelected", "OnGridScreenItemSelected")
    ShowScreen(m.GridScreen) ' show GridScreen
end sub

sub OnGridScreenItemSelected(event as Object) ' invoked when GridScreen item is selected
    Print "You are trying to play a video"
    grid = event.GetRoSGNode()
    ' extract the row and column indexes of the item the user selected
    m.selectedIndex = event.GetData()
    Print "Playing video from row " m.selectedIndex[0] " column " m.selectedIndex[1]
    ' the entire row from the RowList will be used by the Video node
    ' sending the whole video row into the next screen
    rowContent = grid.content.GetChild(m.selectedIndex[0])
    print "selected row is " rowContent.TITLE " with " rowContent.getChildCount() " items"
    print rowContent 
    itemIndex = m.selectedIndex[1]
    ShowVideoScreen(rowContent, itemIndex)
end sub