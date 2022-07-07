function TestSuite__StringUtils() as Object
  this = BaseTestSuite()
  this.name = "StringUtilsTestSuite"

  this.setUp = StringUtilsTestSuite__setUp
  this.tearDown = StringUtilsTestSuite__tearDown

  this.addTest("isEmptyString", TestCase__isEmptyString)
  this.addTest("foundInString", TestCase__foundInString)

  return this
end function

sub StringUtilsTestSuite__setUp()
  '
end sub

sub StringUtilsTestSuite__tearDown()
  '
end sub

function TestCase__isEmptyString()
  result = m.assertTrue(isEmptyString({}))        ' We didn't input a string, so we'd expect this to return true
  result += m.assertTrue(isEmptyString(""))       ' We input an empty string, so we'd expect this to return true
  result += m.assertFalse(isEmptyString("abc"))   ' We input a string with characters, so we'd expect this to return false

  return result
end function

function TestCase__foundInString()
  result = ""

  try
    foundInString({}, {})                                 ' We input bad parameters which will cause a type error
  catch e
    message = lCase(e.message)
    typeMismatch = message.inStr("type mismatch") <> -1
    result += m.assertTrue(typeMismatch)
  end try

  result += m.assertFalse(foundInString("abc", "def"))    ' We input a substring not expected to be found, so we'd expect this to return false
  result += m.assertTrue(foundInString("abcd", "abc"))    ' We input a substring expected to be found, so we'd expect this to return true

  return result
end function