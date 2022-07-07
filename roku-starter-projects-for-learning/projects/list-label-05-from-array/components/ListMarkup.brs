sub init()
    ' this label was created in xml
    m.label=m.top.findNode("label")
    ' add a label dynamically
    m.label2 = CreateObject("roSGNode","Label")
    m.label2.text = "this is another label"
    m.label2.translation = [0,100]
    m.top.appendChild(m.label2)
    m.top.translation=[100,100]
    ' now lets add a label list
    m.labellist = CreateObject("roSGNode","LabelList")
    m.labellist.translation = [0,200]
    ' create content for label list
    m.content = CreateObject("roSGNode","ContentNode")
    m.section = m.content.createChild("ContentNode")
    m.section.CONTENTTYPE="SECTION"
    m.names = ["bugs","bunny","top","cat"]
    for each name in m.names 
        item = m.section.createChild("ContentNode")
        item.title=name
    end for
    m.labellist.content=m.content
    m.top.appendChild(m.labellist)
    m.labellist.setFocus(true)
end sub