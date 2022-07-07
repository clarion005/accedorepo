sub init()
  print "Hello World"
  m.top.setFocus(true)
    m.postergrid = m.top.findNode("grid")
    m.postergrid.translation = [ 130, 160 ]
    m.readPosterGridTask = createObject("roSGNode", "ContentReader")
    m.readPosterGridTask.contenturi = "http://c4.arm.accedo.tv/develop/matt/we/feed.json"
    m.readPosterGridTask.observeField("content", "showpostergrid")
    m.readPosterGridTask.control = "RUN"
end sub
sub showpostergrid()
  m.postergrid.content = m.readPosterGridTask.content
end sub
function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false
  print "press = " press
  if press then
    if (key = "OK") then
    print m.postergrid.itemSelected
    print m.postergrid.content.getChild(m.postergrid.itemSelected)
    m.top.hideView = true

    end if
  end if
  return handled
end function