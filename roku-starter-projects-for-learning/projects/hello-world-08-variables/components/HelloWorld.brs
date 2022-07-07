sub init()
   ' declare integer (32 bit)
   integer01 = 1
   integer02 = 1%
   integer03 = &HFF ' Hex Literal 255

   ' declare long integer (64 bit)
   long01 = 1&

   ' declare float
   float01 = 1.0
   float02 = 1!
   float03 = 1.23E5

   ' declare double
   double01 = 1#
   double02 = 1.23D5

   ' declare string (immutable) 
   string01 = "this is a string"
   ' declare roku String (which is an object)
   string02 = CreateObject("roString")

   ' Arrays 
   ' create an array with initial size 0 and resizable set to true
   array01 = createObject("roArray", 0, true)
   ' add to end
   array01.push("a value to add at the end")
   array01.push(100)
   ' remove from end
   array01.pop()
   ' view last item
   array01.peek()
   ' add item to start
   array01.unshift("a value to add at the start")
   ' remove item from the start
   array01.shift()
   ' remove item at index 3
   array01.delete(3)
   ' array length
   array01.count()
   ' remove all items
   array01.clear()
   ' array literal
   array02 = [10,20,30]
   ' join 2 arrays
   array01.append(array02)

   ' List
   list = createObject("roList")
   list.AddTail("a")
   list.AddTail("b")
   list.AddTail("c")
   print "Item in list at index 2 = " list[2] ' c


   ' Objects
   object01 = {
      number01 : 100,
      string01 : "a string"
      boolean01 : false
   }
   print "object01.number01 = " object01.number01  
    
   object02 = {}
   object02.item = "value"
   object02["item"] = "value"
   object02.AddReplace("item","value")
   object02.Lookup("item")
   object02.DoesExist("item")
   object02.Delete("item")
   ' remove all items
   object02.Clear()
   ' create an array containing all of the object keys
   object02.Keys()
   ' create an array containing all the key/value pairs
   object02.Items()
   ' join 2 objects
   object02.Append(object01)
   ' number of keys
   object02.Count()
    
   object03 = CreateObject("roAssociativeArray")

   ' conversion of string to int
   convertString = "100"
   print "adding 1 to 100 = " convertString.toInt() + 1
   ' conversion of int to string
   convertInt = 1000
   print "converting number 1000 to string = " convertInt.tostr() 
end sub