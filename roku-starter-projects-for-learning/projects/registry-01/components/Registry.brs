sub init()
    print "about to edit the system registry"
    registry = CreateObject("roRegistry")
    print "registry.GetSpaceAvailable()" registry.GetSpaceAvailable()

    ' section is like a container in which we store registry key-value items
    section = CreateObject("roRegistrySection","data")
    ' list sections
    print "registry.GetSectionList()" registry.GetSectionList()

    ' write entry
    key = "key"
    value = "value"
    section.Write(key,value)
    section.Flush()
    if (section.Exists("key"))
        print "registry key has value """ section.Read(key) """"
        section.Write(key,"new value")
        print "updated key with new value """ section.Read(key) """"
        section.Delete(key)
        print "key has now been deleted " section.Read(key)
    end if
    
    ' create temporary section 
    temp = CreateObject("roRegistrySection","temp")
    temp.Write(key,value)
    print "section list including temporary section " registry.GetSectionList()
    registry.Delete("temp")
    print "temporary section has now been deleted " registry.GetSectionList()
    registry.GetSectionList()
        
end sub