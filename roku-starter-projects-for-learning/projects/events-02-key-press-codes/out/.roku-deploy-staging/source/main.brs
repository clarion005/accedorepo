Library "v30/bslDefender.brs"

Function Main() as void
    print "starting app"
    screen = CreateObject("roScreen", true)
    print "screen " screen
    port = CreateObject("roMessagePort")
    print "port " port
    bitmapset = dfNewBitmapSet(ReadAsciiFile("pkg:/assets/bitmapset.xml"))
    print "bitmapset " bitmapset   
    compositor = CreateObject("roCompositor")
    print "compositor " compositor
    compositor.SetDrawTo(screen, &h000000FF)
    
    ' clock
    clock = CreateObject("roTimespan")
    ' sets clock to system clock time.
    clock.Mark()
    print "clock.TotalSeconds().ToStr() " clock.TotalSeconds()
    print "clock.TotalMilliseconds().ToStr() " clock.TotalMilliseconds()
    print "clock.GetSecondsToISO8601Date() " clock.GetSecondsToISO8601Date("24 June 2020")
    print "clock.GetSecondsToISO8601Date() " clock.GetSecondsToISO8601Date("2008-11-29T14:54:02.171")

    ' date.
    date = CreateObject("roDateTime")
    print "long date " date.AsDateString("long-date")
    print "short weekday " date.AsDateString("short-weekday")
    print "no weekday " date.AsDateString("no-weekday")
    print "short month " date.AsDateString("short-month")
    print "short month short weekday " date.AsDateString("short-month-short-weekday")
    print "short month no weekday " date.AsDateString("short-month-no-weekday")
    print "short date " date.AsDateString("short-date")
    print "short date " date.AsDateString("short-date-dashes")
    print "full date" date.AsDateStringNoParam()
    print "day of month " date.GetDayOfMonth()
    print "weekday " date.GetWeekday()
    print "month " date.GetMonth()
    print "year " date.GetYear()
    print "hours " date.GetHours()
    print "minutes " date.GetMinutes()
    print "seconds " date.GetSeconds()
    print "milliseconds " date.GetMilliseconds()
    print "last day of month " date.GetLastDayOfMonth()
    print "day of week " date.GetDayOfWeek()
    


    ' sets time to system time
    date.Mark()
    print "date " date
    print "date as local time " date.ToLocalTime()
    print "time offset " date.GetTimeZoneOffset()
    print "date as seconds " date.AsSeconds()
    print "date as ISO string " date.ToISOString()
    'print "date.FromSeconds() " date.FromSeconds(22)
    'print "date.FromISO8601String()" date.FromISO8601String("3 October 2020")
    'print "date.FromISO8601String()" date.FromISO8601String("2009-01-01 01:00:00.000")
    
    screen.SetMessagePort(port)
    screen.SetAlphaEnable(true)
    print "screen " screen
    codes = bslUniversalControlEventCodes()
    print "button codes" codes
    print "left 4/104" codes.BUTTON_LEFT_PRESSED
    print "right 5/105" codes.BUTTON_RIGHT_PRESSED
    print "up 2/102" codes.BUTTON_UP_PRESSED
    print "down 3/103" codes.BUTTON_DOWN_PRESSED
    print "select = OK 6/106" codes.BUTTON_SELECT_PRESSED
    print "back 0/100" codes.BUTTON_BACK_PRESSED
    print "replay 7/107" codes.BUTTON_INSTANT_REPLAY_PRESSED
    print "info 10/100" codes.BUTTON_INFO_PRESSED
    print "rewind 8/108" codes.BUTTON_REWIND_PRESSED
    print "forward 9/109" codes.BUTTON_FAST_FORWARD_PRESSED
    print "play 13/113" codes.BUTTON_PLAY_PRESSED 
    sprite = compositor.NewAnimatedSprite(450, 225, bitmapset.animations.animated_sprite)
    speed = 1000
    while true    
        event = port.GetMessage()
        if (type(event) = "roUniversalControlEvent") 'Press the right remote key to speed up, left remote key to slow down
            id = event.GetInt()
            print "event " event " has id " event.GetInt()
            if (id = codes.BUTTON_LEFT_PRESSED)
                print "left button pressed which has code " codes.BUTTON_LEFT_PRESSED
                speed = speed - 100
                if (speed < 300)
                    speed = 300
                endif   
            else if (id = codes.BUTTON_RIGHT_PRESSED)
                print "right button pressed which has code " codes.BUTTON_RIGHT_PRESSED
                speed = speed + 100
                if (speed > 2000)
                    speed = 2000
                endif
            endif
        else if (event = invalid)
                ticks = clock.TotalMilliseconds()
                if ((ticks MOD 1000 = 0) and (ticks>0))
                    'print "ticks " ticks " and speed is " speed
                end if
            if (ticks > speed)
                'print "ticks " ticks " > speed " speed
                compositor.AnimationTick(ticks)
                compositor.DrawAll()
                screen.SwapBuffers()
                clock.Mark()
            endif
        endif
    end while
End Function