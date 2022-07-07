sub init()
   print "initialising root scene component"
   localScopedNumber = 11
   m.componentScopedNumber = 22
   anotherRoutine()
end sub

sub anotherRoutine()
   ' not in scope
   print localScopedNumber
   ' in scope
   print m.componentScopedNumber
end sub