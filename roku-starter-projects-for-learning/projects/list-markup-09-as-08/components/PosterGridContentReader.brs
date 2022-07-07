sub init()
    ' RUN calls this function which is built into brightscript
    print "poster grid content reader initialising"
    m.top.functionName="getcontent"
end sub
' automatically called 
sub getcontent()
    print "poster grid content reader running"
    content=CreateObject("roSGNode","ContentNode")
    contentxml=CreateObject("roXMLElement")
    data = CreateObject("roUrlTransfer")
    data.setUrl(m.top.contenturi)
    contentxml.parse(data.GetToString())
    print "contentxml is " contentxml 
    print "data is " data
    print "contentxml.getName() " contentxml.getName()
    if (contentxml.getName()="Content") then
        for each item in contentxml.GetNamedElements("item")
            print "data item is " item
            itemcontent=content.CreateChild("ContentNode")
            print "item.getAttributes() " item.getAttributes()
            itemcontent.setFields(item.getAttributes())
            print "item content is " itemcontent 
        end for
    end if
    m.top.content=content
end sub