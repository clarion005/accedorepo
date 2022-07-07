sub init()
      m.testsequentialanimation = m.top.FindNode("testSequentialAnimation")
      m.testsequentialanimation.repeat = "true"
      m.testsequentialanimation.control = "start"
      m.top.setFocus(true)
end sub