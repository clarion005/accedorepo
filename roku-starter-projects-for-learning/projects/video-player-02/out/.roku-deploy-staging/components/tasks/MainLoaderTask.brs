sub Init()
    ' set the name of the function in the Task node component to be executed when the state field changes to RUN
    ' in our case this method executed after the following cmd: m.contentTask.control = "run"(see Init method in MainScene)
    m.top.functionName = "GetContent"
end sub

sub GetContent()
    Print "getting content from api"
    ' request the content feed from the API.
    xfer = CreateObject("roURLTransfer")
    xfer.SetCertificatesFile("common:/certs/ca-bundle.crt")
    xfer.SetURL("https://bitbucket.org/philanderson888/phil-data/raw/c977e5544c0cdf63bd1d88d2b0906cf85eb7c851/data.json")
    ' this line actually executes the logic to get the data and set it to a string
    rsp = xfer.GetToString()

    ' set the arrays to be displayed as null
    rootChildren = [] ' one item is one row of data
    
    ' parse the feed and build a tree of ContentNodes to populate the GridView.
    Print "parsing JSON"
    json = ParseJson(rsp)
    ' json must be valid
    if json <> invalid
        Print "json is valid"
        ' one category is one row
        for each category in json
            Print " "
            Print "looking up json data for category " category
            value = json.Lookup(category)
            ' if this is an array (but not a series) then parse the array
            ' and put the items into a row
            ' individual items go into the row.children as an array of items
            ' where each item pushed to the array as 'itemData'
            ' so we end up with a row of items filled with data
            ' and we have one row of items per category present in the json file
            ' category => row => itemData
            ' finally we push the whole row to the rootChildren array
            if Type(value) = "roArray" ' if parsed key value having other objects in it
                Print "data type returned is an array"
                if category <> "series" ' ignore series for this phase
                    Print "creating a new row object"
                    row = {}
                    row.title = category
                    row.children = []
                    Print "now parsing each array item to create our row items"
                    for each item in value ' parse items and push them to row
                        itemData = GetItemData(item)
                        row.children.Push(itemData)
                    end for
                    rootChildren.Push(row)
                    Print "adding new row " category " with " row.children.Count() " items"
                end if
            end if
        end for
        ' set up a root ContentNode to represent rowList on the GridScreen
        Print "creating a contentNode filled with data from our array of rows with child video details"
        contentNode = CreateObject("roSGNode", "ContentNode")
        Print "updating the content node data node to have the newly found rows of data in it"
        contentNode.Update({
            children: rootChildren
        }, true)
        ' populate content field with root content node.
        ' Observer(see OnMainContentLoaded in MainScene.brs) is invoked at that moment
        Print "pushing our new video content node to 'm.top' to replace existing node"
        m.top.content = contentNode
    end if
end sub

' this maps the fields obtained from the json object to those in our local item
function GetItemData(video as Object) as Object
    item = {}
    ' populate some standard content metadata fields to be displayed on the GridScreen
    ' https://developer.roku.com/docs/developer-program/getting-started/architecture/content-metadata.md
    if video.longDescription <> invalid
        item.description = video.longDescription
    else
        item.description = video.shortDescription
    end if
    print "video id and title is " video.id " " video.title
    item.hdPosterURL = video.thumbnail
    item.title = video.title
    item.releaseDate = video.releaseDate
    item.id = video.id
    if video.content <> invalid
        ' populate length of content to be displayed on the GridScreen
        item.length = video.content.duration
        ' populate meta-data for playback
        item.url = video.content.videos[0].url
        item.streamFormat = video.content.videos[0].videoType
    end if
    return item
end function
