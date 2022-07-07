sub init()
   print "initialising root scene component"
   localScopedNumber = 11
   m.componentScopedNumber = 22
   anotherRoutine()
   print "printing m. component " m
   print "printing m.top root node component " m.top
   print "printing m.global " m.global
end sub

sub anotherRoutine()
   ' not in scope
   print localScopedNumber
   ' in scope
   print m.componentScopedNumber
end sub