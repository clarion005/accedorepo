sub init()
    m.label=CreateObject("roSGNode","Label")
    m.label.text = "Here is a label"
    m.label.translation=[100,200]
    m.label.font.size=50
    m.label.color="0xff0000"
    m.top.appendChild(m.label)
 
    ' Tags
    ' @thisisatag this is a comment
    ' @deprecated
    ' @return
    ' @see
    ' @param
    ' @since
    ' @see
    ' @see "text"
    ' @see https://....

    ' Examples

    ' @param utils an instance of the AA utils object created from calling the {@link .CreateUtils Utils Contructor}
    ' @param site the site string
    ' @param titlePrefix a static prefix for the video title display line
    ' @param contentAAArray an Array of content meta‐data Aas
    ' @return False if there was an error during creating or running this screen.
    ' @see <a href="/docs/developer-program/getting-started/architecture/content-metadata.md">Content Meta‐data</a>
    ' @see .CreateUtils CreateUtils()


    ' Inline Tags

    ' { @link }
    ' { @literal }
    ' { @code ddd}

    ' Examples
    ' Creates an {@link roAssociativeArray associative array} of useful general utility functions.
    ' {@literal <bold> and </bold> are presented as is in this literal tag, rather than causing "and" to be bolded} 

    ' {@code of course, the same thing is true in this code tag, but the font face is different ‐ <bold> and the matching </bold> tags are shown rather than cause the "and the matching" to be bolded}
    ' <br/>
    ' And any old HTML you want to throw in is also valid, although equivalent BrightScriptDoc tags are more efficient...
    ' <table border=1>
    ' <th>col 1</th><th>col 2</th><th>col 3</th>
    ' <tr><td>row 1 col 1</td><td>row 1 col 2</td><td>row 1 col 3</td></tr>
    ' </table>
    ' And so on...
    ' @see .ShowCustomScreen#z The z variable in the ShowCustomScreen method is rather uninteresting
    ' @return an AA containing useful utility functions

end sub