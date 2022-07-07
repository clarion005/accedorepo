sub init()
    ' this is the name of the function which gets run when 
    ' the task status changes to RUN
    print "initialising content reader"
    m.top.functionName="getcontent"
end sub
sub getcontent()
    print "getting content"
    content = CreateObject("roSGNode","ContentNode")
    contentxml = CreateObject("roXMLElement")
    data = createObject("roURLTransfer")
    ' setUrl method sets the URL to be used for data transfer
    ' m.top.contenturi is set in `main` using m.contentreader.contenturi="..."
    data.setUrl(m.top.contenturi)
    print "getting data from this url - " m.top.contenturi 
    contentxml.parse(data.GetToString())
    print "contentxml " contentxml 
    print "data.GetToString() " data.GetToString()
    if (contentxml.getName()="Content")
        for each item in contentxml.GetNamedElements("item")
            print "xml item is " item
            itemcontent=content.createChild("ContentNode")
            itemcontent.setFields(item.getAttributes())
            print "item content is " itemcontent 
        end for
    end if
    m.top.content=content
end sub