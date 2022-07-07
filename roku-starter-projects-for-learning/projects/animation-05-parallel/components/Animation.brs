sub init()
      m.testparallelanimation = m.top.FindNode("testParallelAnimation")
      m.testparallelanimation.repeat = "true"
      m.testparallelanimation.control = "start"
      m.top.setFocus(true)
end sub