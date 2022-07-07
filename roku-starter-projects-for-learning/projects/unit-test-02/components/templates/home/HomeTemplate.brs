sub init()
    m.HomeContainer = m.top.findNode("homeContainer")
end sub

sub onPageArgs()
    getPin()
    getFeed()
end sub

' PIN RELATED FUNCTIONALITY

sub getPin()
    m.RegistryTask = createObject("roSGNode", "RegistryTask")
    m.RegistryTask.request = {
        type: "read",
        key: "pin"
    }
    m.RegistryTask.observeField("response", "onPinRecieved")
    m.RegistryTask.control = "run"
end sub

sub onPinRecieved(message as Object)
    response = message.getData()
    m.pin = response

    text = "Enable PIN"
    if not isEmptyString(response) then
        text = "Disable PIN"
    end if

    m.PinButton = m.top.findNode("pinButton")
    m.PinButton.observeField("selected", "onPinButtonSelected")
    m.PinButton.properties = {
        width: 249,
        height: 75,
        color: "#616161",
        focusedColor: "#ECECEC",
        labelColor: "#ECECEC",
        labelFocusedColor: "#000000",
        labelText: text
    }

    m.PinButton.focus = true
end sub

sub onPinButtonSelected()
    m.PinButton.focus = false
    print "pinButton text = " m.PinButton.text
    createPinPadPopup("onPinSet", m.PinButton.text)
end sub

sub onPinSet(message as Object)
    m.HomeContainer.removeChild(m.PinPadPopup)
    m.PinPadPopup = invalid

    closeProps = message.getData()
    pinSuccessfullyEntered = closeProps.pinSuccessfullyEntered

    if pinSuccessfullyEntered then
        getPin()
    else
        m.PinButton.focus = true
    end if
end sub

sub onPinCompared(message as Object)
    m.HomeContainer.removeChild(m.PinPadPopup)
    m.PinPadPopup = invalid

    closeProps = message.getData()
    pinSuccessfullyEntered = closeProps.pinSuccessfullyEntered

    if pinSuccessfullyEntered then
        createPlayer()
    else
        m.FeedGrid.setFocus(true)
    end if
end sub

function getPinPadPopupType(text = "compare" as String)
    pinPadPopupType = text

    if foundInString(text, "Disable") then
        pinPadPopupType = "disable"
    else if foundInString(text, "Enable") then
        pinPadPopupType = "enable"
    end if

    return pinPadPopupType
end function

' GRID RELATED FUNCTIONALITY

sub getFeed()
    m.FeedTask = createObject("roSGNode", "FeedTask")
    m.FeedTask.observeField("response", "onFeedResponse")
    m.FeedTask.control = "run"
end sub

sub onFeedResponse(message as Object)
    response = message.getData()
    responseJson = parseJson(response)

    ContentNode = createObject("roSGNode", "ContentNode")

    for i = 0 to responseJson.count() - 1
        programme = responseJson[i]
        FeedNode = ContentNode.createChild("FeedNode")
        FeedNode.title = programme.title
        FeedNode.type = programme.type
        FeedNode.summary = programme.summary
        FeedNode.imageUri = reformatImageUri(programme.image.href)
        FeedNode.streamUri = programme.stream.href
        FeedNode.expires = programme.expires
        FeedNode.ageRating = programme.ageRating
    end for

    m.FeedGrid = m.top.findNode("feedGrid")
    m.FeedGrid.content = ContentNode
end sub

sub onFeedGridItemSelected()
    itemSelectedIndex = m.FeedGrid.itemSelected
    meta = m.FeedGrid.content.getChild(itemSelectedIndex)

    if meta.ageRating = 18 and not isEmptyString(m.pin) then
        createPinPadPopup("onPinCompared", "compare")
    else
        createPlayer()
    end if
end sub

sub createPlayer()
    StckManager = StackManager()
    itemSelectedIndex = m.FeedGrid.itemSelected
    meta = m.FeedGrid.content.getChild(itemSelectedIndex)

    StckManager.push({
        id: "PlayerTemplate",
        meta: meta
    })
end sub

sub createPinPadPopup(callback as String, pinPadPopupType as String)
    m.PinPadPopup = createObject("roSGNode", "PinPadPopup")
    m.PinPadPopup.type = getPinPadPopupType(pinPadPopupType)
    m.PinPadPopup.observeField("close", callback)
    m.HomeContainer.appendChild(m.PinPadPopup)
    m.PinPadPopup.setFocus(true)
end sub

' KEY EVENT HANDLERS..

function onKeyEvent(key as String, press as Boolean) as Boolean
    handled = false

    if press then
        if key = "right" and m.PinButton.hasFocus() then
            m.PinButton.focus = false
            m.FeedGrid.setFocus(true)
            handled = true
        else if key = "left" and m.FeedGrid.hasFocus() then
            m.PinButton.focus = true
            handled = true
        else if key = "OK" and m.FeedGrid.hasFocus() then
            onFeedGridItemSelected()
            handled = true
        end if
    end if

    return handled
end function

