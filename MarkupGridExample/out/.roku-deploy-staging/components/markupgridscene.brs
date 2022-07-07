sub init()
    m.top.backgroundURI = "pkg:/images/rsgde_bg_hd.jpg"
    m.top.setFocus(true)
    m.markupgrid = m.top.findNode("exampleMarkupGrid")
    m.readMarkupGridTask = createObject("roSGNode", "ContentReader")
    m.readMarkupGridTask.contenturi = "http://www.sdktestinglab.com/Tutorial/content/rendergrid.xml"
    m.readMarkupGridTask.observeField("content", "showmarkupgrid")
    m.readMarkupGridTask.control = "RUN"
  end sub
  sub showmarkupgrid()
    m.markupgrid.content = m.readMarkupGridTask.content
  end sub