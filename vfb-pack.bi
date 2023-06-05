#inclib "vfb-push"
Declare Function Position (ByRef AutoScales As FormStartPosition)
Screen 20
#define map(a,b,x,c,d) ((d)-(c))*((x)-(a))/((b)-(a))+(c)
Dim As Single d,y
Do
    d-=.01
    Screenlock
    Cls
    
    For n As Long=0 To 1024
        Var ypos=map(-1,1,Sin(n/75+d),600,700)
        Pset(n,ypos)
        If n=500 Then y=ypos
    Next n
    Draw String(450,120),"compression"
    Draw String(450,140),"chamber"
    Line(500-50,100)-(500+50,500),,b
    Line(500-50,250)-(500-10,250)
    Line(500+10,250)-(500+50,250)
    Var cy=map(600,700,y,285,250)
    If y>610 Then cy=294
    Circle(500,cy-50),12,,,,,f
    Line(500-50,500)-(500+50,500),0
    Line(500,y)-(500,y-300)
    Line(500-50,y-300)-(500+50,y-300)
    Line(500+50,250)-(500+50,500),0
    Line(500+50,250)-(500+50,270)
    Line(500+50,290)-(500+50,500)
    cy=map(600,700,y,545,535)
    If y<690 Then cy=545
    Circle(cy,280),12,,,,,f
    Circle(500,y),50,15,,,,f
     draw string(480,y-15),"Float",0
    Screenunlock
    Sleep 1
    Loop Until Inkey=Chr(27) 
 End
    