Sub Init()
    print chr(10) " ===== FeedParser.brs"
    m.top.functionName = "loadContent"
End Sub

Function ParseXML(str As String) As dynamic  'Takes in the content feed as a string
    print chr(10) "parseXML()"
    if str = invalid return invalid  'if the response is invalid, return invalid
    xml = CreateObject("roXMLElement")  '
    if not xml.Parse(str)  return invalid  'if the string cannot be parse, return invalid
    return xml  'returns parsed XML if not invalid
End Function


Function GetContentFeed()  'This function retrieves and parses the feed and stores the content item in a ContentNode
    print chr(10) "GetContentFeed()"
    url = CreateObject("roUrlTransfer")  'component used to transfer data to/from remote servers
    url.SetUrl("https://devtools.web.roku.com/samples/sample_content.rss")
    url.SetCertificatesFile("common:/certs/ca-bundle.crt")
    rsp = url.GetToString()  'convert response into a string

    responseXML = ParseXML(rsp)  'Roku includes its own XML parsing method

    if responseXML <> invalid then 'Fall back in case Roku's built in XML parse method fails
        responseXML = responseXML.GetChildElements()  'Access content inside Feed
        responseArray = responseXML.GetChildElements()
    End if

    'manually parse feed if ParseXML() is invalid
    result = []  'Store all results inside an array. Each element respresents a row inside our RowList stored as an Associative Array (line 63)
    mediaindex={}
    for each xmlItem in responseArray  'For loop to grab contents inside each item in XML feed
        if xmlItem.getName() = "item"  'Each individual channel content is stored inside the XML header named <item>
            itemAA = xmlItem.getChildElements()  'Get the child elements of item
            if itemAA <> invalid  'Fall bak in case invalid is returned
                item = {}  'Creates an associative array for each row
                for each xmlItem in itemAA  ' Goes thru all contents of itemAA
                    item[xmlItem.getName()] = xmlItem.getText()
                    if xmlItem.getName() = "media:content"  'Checks to find <media:content> header
                        item.stream = {url: xmlItem.url}  ' Assigns all content inside <media:content> to the item AA
                        item.url = xmlItem.getAttributes().url
                        item.streamFormat = "mp4"


                        mediaContent = xmlItem.GetChildElements()
                        for each mediaContentItem in mediaContent  'Looks through meiaContent to find poster image for each piece of content
                            if mediaContentItem.getName() = "media:thumbnail"
                                item.HDPosterURL = mediaContentItem.getattributes().url  'Assign image to item AA
                                item.HDBackgroundImageUrl = mediaContentItem.getattributes().url
                            end if
                        end for

                    else if xmlitem.getname()="guid"
                      item.guid=xmlitem.getText()
                    end if
                end for
                result.push(item)  'Pushes each AA into the Array
                mediaindex[item.guid] = item
                ''print "mediaindex= "  mediaindex
            end if
        end if
    end for
    return  {contentarray:result:index:mediaindex} 'Returns the array
End Function


Function ParseXMLContent(list As Object)  'Formats content into content nodes so they can be passed into the RowList
    print chr(10) "ParseXMLContent()"
    RowItems = createObject("RoSGNode","ContentNode")
    'Content node format for RowList: ContentNode(RowList content) --<Children>-> ContentNodes for each row --<Children>-> ContentNodes for each item in the row)
    for each rowAA in list
        row = createObject("RoSGNode","ContentNode")
        row.Title = rowAA.Title
        for each itemAA in rowAA.ContentList
            item = createObject("RoSGNode","ContentNode")
            'Don't do item.SetFields(itemAA), as it doesn't cast streamFormat to proper value
            loopCounter = 0
            for each key in itemAA
                loopCounter++
                if loopCounter >= 2 exit for
                print key " : " itemAA[key]
            end for 
    	    item.setFields(itemAA)
            row.appendChild(item)
        end for
        RowItems.appendChild(row)
    end for
    return RowItems
End Function

Function SelectTo(array as Object, num=25 as Integer, start=0 as Integer) as Object  'This method copies an array up to the defined number 'num' (default 25)
    result = []
    for i = start to array.count()-1
        result.push(array[i])
        if result.Count() >= num
            exit for
        end if
    end for
    return result
End Function

Sub loadContent()
  print chr(10) "inputTask loadContent()"
  bundle=GetContentFeed()
  ' loop counters just limit the amount of data printed to the console eg after 2 or 3 loops, not infinitely
  loopCounter = 0
  for each item in bundle
    loopCounter++
    if loopCounter >= 3 exit for
    print item " : " bundle[item]
    if type(bundle[item])="roAssociativeArray"
        print chr(10) "{"
        innerArray = bundle[item]
        loopCounter2 = 0
        for each innerItem in innerArray
            loopCounter2++
            if loopCounter2 >= 3 exit for
            print tab(4) innerItem " : " innerArray[innerItem] 
            if type(innerArray[innerItem]) = "roAssociativeArray"
                print chr(10) "{"
                innerArray2 = innerArray[innerItem]
                loopCounter3 = 0
                for each item2 in innerArray2.Items()
                    loopCounter++
                    if loopCounter3 >= 3 
                        exit for
                    end if
                    print tab(8) item2.key " : " item2.value
                    if item2.key = "stream"
                        print tab(12) "printing stream items"
                        stream = item2.value
                        loopCounter4 = 0
                        for each streamItem in stream
                            loopCounter4++
                            if loopCounter4 >= 3 exit for
                            print tab(12) streamItem " : " stream[streamItem]
                            if streamItem = "url" and stream[streamItem].count() > 0
                                print tab(12) "printing list of XML items of length " 
                                counter5 = 0
                                for each xmlItem in stream[streamItem]
                                    counter5++
                                    if counter5 >=3 exit for
                                    print tab(16) xmlItem
                                end for 
                                print tab(12) "end of xml list"
                            end if
                        end for
                    end if
                end for 
            end if
        end for
    end if
  end for
    oneRow = bundle.contentArray
    'stop
    list = [
       'first row in the grid with 3 items across
       {
           Title:"Row One ..."
           ContentList: SelectTo(oneRow, 3)
       }
       'second row in the grid with 5 items across
       {
           Title:"Row Two"
           ContentList: SelectTo(oneRow, 4, 3)
       }
       'third row in the grid with 5 items across
       {
           Title:"Row Three"
           ContentList: SelectTo(oneRow, 4, 7)
       }
       'fourth row in the grid with remaining 2 items
       {
           Title:"Row Four"
           ContentList: SelectTo(oneRow, 5, 11)
       }
    ]
    m.top.content = ParseXMLContent(list)
    sleep(1000)
    m.top.mediaIndex=bundle.index
    ''print "m.top.mediaIndex= "  m.top.mediaIndex
End Sub
