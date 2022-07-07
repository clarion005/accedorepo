sub init()
    ' this is the name of the function which gets run when task set to RUN
    print "initialising content reader - set `getcontent()` to run when task is run"
    m.top.functionName="getcontent"
end sub
sub getcontent()
    print "getting content"
    content = CreateObject("roSGNode","ContentNode")
    contentxml = CreateObject("roXMLElement")
    data = createObject("roURLTransfer")
    data.SetCertificatesFile("common:/certs/ca-bundle.crt")
    ' setUrl method sets the URL to be used for data transfer
    ' m.top.contenturi is set in `main` using m.contentreader.contenturi="..."
    data.setUrl(m.top.contenturi)
    print "getting data from this url - " m.top.contenturi 
    contentxml.parse(data.GetToString())
    print "contentxml " contentxml 
    print "data.GetToString() " data.GetToString()
    m.dataArray = []
    if (contentxml.getName()="Content")
        for each item in contentxml.GetNamedElements("item")
            print "xml item is " item
            itemcontent=content.createChild("ContentNode")
            itemcontent.setFields(item.getAttributes())
            print "item content is " itemcontent 
            print "url is " itemcontent.hdgridposterurl 
            print "text is " itemcontent.shortdescriptionline1 
            print "row is " itemcontent.x
            print "col is " itemcontent.y
            m.dataArray.push(itemcontent.shortdescriptionline1)
        end for
    end if
    m.top.content=content 
    m.top.dataArray = m.dataArray
    print "data array holds "
    for each item in m.dataArray
        print item
    end for
end sub