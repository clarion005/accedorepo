sub init()
    m.top.functionName = "getcontent"
  end sub
  sub getcontent()
    content = createObject("roSGNode", "ContentNode")
    readInternet = createObject("roUrlTransfer")
    readInternet.setUrl(m.top.contenturi)
    response = ParseJson(readInternet.GetToString())
    print response

    for i = 0 to response.count() - 1 
      itemcontent = content.createChild("ContentNode")
      itemcontent.SHORTDESCRIPTIONLINE1 = response[i].title
      itemcontent.hdgridposterurl = response[i].image.href
      itemcontent.stream = response[i].stream.href
    end for
    

    m.top.content = content
  end sub
  