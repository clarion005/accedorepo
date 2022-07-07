sub init()
    m.top.functionName="getcontent"
end sub
sub getcontent()
    print "getting markup content"
    content = CreateObject("roSGNode","ContentNode")
    contentxml = CreateObject("roXMLElement")
    data = CreateObject("roURLTransfer")
    data.SetCertificatesFile("common:/certs/ca-bundle.crt")
    ' set field `m.contentreader.contenturi`
    data.setUrl(m.top.contenturi)
    print "fetching data from uri " m.top.contenturi 
    contentxml.parse(data.getToString())
    print "markup data returned " contentxml 
    print "contentxml.getName() " contentxml.getName()
    if(contentxml.getName()="children")
        for each item in contentxml.GetNamedElements("ContentNode")
            itemcontent=content.createChild("ContentNode")
            itemcontent.setFields(item.getAttributes())
            print "data - " itemcontent.text " " itemcontent.HDPosterUrl
        end for
    end if
end sub