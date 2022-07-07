function TestSuite__Button() as Object
  ' Inherit your test suite from BaseTestSuite
  this = BaseTestSuite()
  
  ' Test suite name for log statistics
  this.Name = "TestSuite__Button"
  
  ' Add tests to suite's tests collection
  this.addTest("TestCase__Interface_Properties", TestCase__Interface_Properties)
  this.addTest("TestCase__Interface_Focus", TestCase__Interface_Focus)
  
  return this
end function

function TestCase__Interface_Properties()
  result = ""

  that = getGlobalAA()

  properties = {
    width: 200,
    height: 100,
    color: "#000000",
    opacity: 1,
    labelColor: "#FFFFFF",
    labelText: "label"
  }
  
  that.top.properties = properties
  
  ButtonLabel = that.top.findNode("buttonLabel")

  for each property in properties
    result += m.assertAAHasKey(ButtonLabel, property)
    result += m.assertEqual(ButtonLabel[property], properties[property])
  end for

  return result
end function

function TestCase__Interface_Focus()
  result = ""

  that = getGlobalAA()

  properties = {
    color: "#000000",
    labelColor: "#FFFFFF",
    focusedColor: "#FFFFFF",
    labelFocusedColor: "#000000"
  }

  that.top.properties = properties

  result += m.assertEqual(that.top.findNode("buttonContainer").color, properties.color)
  result += m.assertEqual(that.top.findNode("buttonLabel").color, properties.labelColor)

  that.top.focus = true

  result += m.assertEqual(that.top.findNode("buttonContainer").color, properties.focusedColor)
  result += m.assertEqual(that.top.findNode("buttonLabel").color, properties.labelFocusedColor)

  return result
end function