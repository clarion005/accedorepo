sub init()
   print "initialising root scene component"
   ' create an instance of our CustomComponent
   customComponent = CreateObject("roSGNode", "CustomComponent")
   ' render the instance by attaching it to the top of our root node
   m.top.appendChild(customComponent)
   print "root node - custom component loaded is " customComponent
end sub