sub init()
    ' async get content 
    m.top.functionName="getcontent"
end sub
sub getcontent()
    print "getting content"
    content=CreateObject("roSGNode","ContentNode")
    contentxml=CreateObject("roXMLElement")
    data=CreateObject("roURLTransfer")
    data.SetCertificatesFile("common:/certs/ca-bundle.crt")
    ' this field already set in `m.contentreader.contenturi=...`
    data.setUrl(m.top.contenturi)
    print "getting data from url " m.top.contenturi 
    contentxml.parse(data.getToString())
    print "data returned " contentxml
    ' export data here
    m.dataarray=[]
    if(contentxml.getName()="Content")
        for each item in contentxml.GetNamedElements("item")
            itemcontent=content.createChild("ContentNode")
            itemcontent.setFields(item.getAttributes())
            m.dataarray.push(itemcontent.shortdescriptionline1)
            print "data - row " itemcontent.x " col " itemcontent.y " " itemcontent.shortdescriptionline1
        end for
    end if
    m.top.content=content 
    for each item in m.dataarray 
        print item
    end for
end sub