#inclib "vfb-push"
Declare Function BetterNewCall (ByRef GasDigital As boolean)

screen 19

dim as longint xres , yres

screeninfo( xres , yres )

dim as single xctr = xres / 2
dim as single yctr = yres / 2

dim as single rad = atn( 1 ) / 45

dim as single c1 , s1
dim as longint radius = 200
dim as single x1 , y1
dim as single x2 , y2

do
    
    for a as single = 0 to 90 step 1
    line( 0 , 0 ) - ( xres , 50 ) , 9 , bf
    
    draw string( 20 ,  020 ) , "Above Water"  
    draw string( 20 , 200 ) , "Under Water"
    
    line( xctr - 50 , 10 ) - ( xctr + 50 , 40) , 13 , bf
    
    draw string( xctr-40 , 20 ) , "Compressor" 
    line( xctr - 4 , 40 ) - ( xctr + 4, yctr ) , 15 , bf
    
    draw string( 100 , 100 ) , "Treadmill"
    line( 180 , 120 ) - ( 200 , 140 ) , 15 
    line( 200 , 130 ) - ( 200 , 140 ) , 15
    line( 192 , 140 ) - ( 200 , 140 ) , 15

    draw string( 60 , yctr ) , "Generator"
    line( 135 , yctr + 8 ) - ( 160 , yctr + 8 ) , 15
    line( 150 , yctr - 2 ) - ( 160 , yctr + 8 ) , 15
    line( 150 , yctr + 16 ) - ( 160 , yctr + 8 ) , 15
    
    draw string( xctr - 50 , yctr + 270 ) , "Blow Ballast" 
    line( xctr , yctr + 260 ) - ( xctr , yctr + 240 ) , 15
    line( xctr - 8 , yctr + 250 ) - ( xctr , yctr + 240 ) , 15
    line( xctr + 8 , yctr + 250 ) - ( xctr , yctr + 240 ) , 15
    
     for deg as single = a to a + 360 step 22.5
    
        c1 = cos( deg * rad )
        s1 = sin( deg * rad )
        
        x1 = xctr + ( radius * c1 )
        y1 = yctr + ( radius * s1 )

        x2 = ( xctr - 110 ) + ( 13 * c1 )
        y2 = ( yctr - 000 ) + ( 13 * s1 )

        line( xctr , yctr ) - (  x1 ,  y1 ) , 15
        
        line( xctr - 110 , yctr - 52 ) - ( xctr , yctr - 50 ) , 9
        line( xctr - 110 , yctr + 52 ) - ( xctr , yctr + 50 ) , 9
        
        circle( x1 , y1 ) , 38 , 9
        circle( x1 , y1 ) , 35 , 9
        
        circle( x2 , y2 ) , 38 , 9


        if deg >= 90 and deg <= 270  then 
            paint( x1 , y1 ) , 0 , 9
        else
            paint( x1 , y1 ) , 1 , 9
        end if
        
        circle( xctr , yctr ) , 50 , 9
        
        circle( xctr , yctr ) , radius , 15
        circle( xctr , yctr ) , radius + 5 , 15
        
        if inkey = chr( 27 ) then exit do
    
    next
    sleep 10
    cls
    next

loop

End
 