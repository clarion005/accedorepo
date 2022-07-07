sub init()
   print "initialising root scene component"
   print "root node m " m 
   print "root node m.top " m.top
   print "root node m.global " m.global
   customComponent = CreateObject("roSGNode", "CustomComponent")
   m.top.appendChild(customComponent)
   print "root node - custom component loaded is " customComponent
   counter = customComponent.counter
   print "component counter has initial default value " counter
   counter++
   print "component counter has incremented to " counter
   print "about to call interface function from parent component "
   customComponent.callFunc("printThis","mop the floor")
end sub