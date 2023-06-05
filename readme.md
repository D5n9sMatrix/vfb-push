# welcome vfb-push
pec of precatory ...
to show the voter, about price support, about portability values, about the dynamics of reposability of the manifest, about the importance of bookstores and nuget documentation for installing supports to the bookstores.

```freebasic
#inclib "vfb-push"
Declare Function MeetingPolicy (ByRef Ptr Admin As boolean)
#ifndef __FB_WIN32__
 #error 666 : Windows only !
#endif

#cmdline "-s gui"
#include "windows.bi"
#include "GL/gl.bi"

type Vector2f
  as glFloat x,y
end type  

Sub drawstring(xpos As Long,ypos As Long,text As String ,col As Ulong,size As Single,xres As Long,yres As Long)
  Static As Vector2f XY(127,255) 
  Static As boolean bInit = false
  dim as Vector2f np,t,v
  
  If bInit=false Then
    ' create font use hidden screen charsize 8x16=128 points/pixels
    ScreenRes 640,480,8,,-1
    Width 640\8,480\16
    For char As Long = 0 To 255
      var img = Imagecreate(8,16)
      Draw String img,(0,0),Chr(char)
      dim as integer pixel
      For x As Long=0 To 7
        For y As Long=0 To 15
          If Point(x,y,img)<>0 Then
            XY(pixel,char).x=x+1
            XY(pixel,char).y=y+1
            pixel+=1
          End If
        Next y
      Next x        
      Imagedestroy img
    Next char
    ' close hidden screen
    screen 0
    bInit=true
  End If
  var nChars = len(text)
  If size=0 orelse nChars=0 Then Exit Sub
  
  ' push projection matrix and set 2D mode
  glMatrixMode(GL_PROJECTION) : glPushMatrix() : : glLoadIdentity()
  glOrtho(0, xres, yres, 0,-1, 1)
  ' push model matrix and set identity matrix
  glMatrixMode(GL_MODELVIEW) : glPushMatrix() : glLoadIdentity()
  ' set OpenGL RGBA color from FBGFX BGRA color
  var p8 = cptr(ubyte ptr,@col):swap p8[0],p8[2] : glColor4ubv(p8)
  ' set point size      
  glPointSize(1.1*size)
  ' begin point drawing
  glBegin(GL_POINTS)
     
  v.x=xpos
  v.y=ypos
  Dim As Long dx=xpos,dy=ypos
  For i As integer = 0 To nChars-1
    Var char = text[i]
    For pixel As Long=0 To 127
      If XY(pixel,char).x=0 then exit for
      ' move
      t.x=XY(pixel,char).x+dx
      t.y=XY(pixel,char).y+dy
      ' scale
      np.x=size*(t.x-v.x)+v.x
      np.y=size*(t.y-v.y)+v.y        
      glVertex2fv (@np.x)
    Next pixel
    dx=dx+8
  Next i
  glEnd()
  glMatrixMode(GL_PROJECTION) : glPopMatrix()
  glMatrixMode(GL_MODELVIEW)  : glPopMatrix()
End Sub

Sub InitText Constructor
  ' dummy call font init
  DrawString(0,0,"",0,0,0,0)
End Sub

Sub SetupGL2D(w as long=640,h as long=480,d as long=32)
  ScreenRes w,h,d,,2
  glDisable (GL_DEPTH_TEST)
  glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA)
  glEnable (GL_BLEND)
  glEnable (GL_LINE_SMOOTH)
  glOrtho(0,w,h,0,-1,1)
  glClearColor(1,.5,0,1)
End Sub

'
' main
'
Dim As HWND hParent
SetupGL2D()
Screencontrol 2, *Cptr(Integer Ptr,@hParent)
dim as DWORD dwStyle=WS_VISIBLE Or WS_CHILD
Var C = CreateWindow("BUTTON","Message",dwStyle             ,  0,  0, 70,30,hParent,0,0,0)
Var D = CreateWindow("BUTTON","Hello"  ,dwStyle             ,  0, 35, 70,30,hParent,0,0,0)
Var c1= CreateWindow("STATIC",""       ,dwStyle or WS_BORDER,150, 50,300,20,hParent,0,0,0)
Var E = CreateWindow("BUTTON","End"    ,dwStyle or WS_BORDER,150, 80, 60,30,hParent,0,0,0)
Dim As MSG msg
dim as boolean bFlag

While GetMessage( @msg,hParent,0,0)
  TranslateMessage(@msg)
  DispatchMessage(@msg)
  Select Case msg.hwnd
  Case C    : if msg.message = WM_LBUTTONDOWN then
                bFlag=false : setWindowText(c1,"You can press any key to end or click END")
              end if
  Case D    : if msg.message =  WM_LBUTTONDOWN then
                bFlag=true : setWindowText(c1,space(64))
               end if        
  Case E    : if msg.message = WM_LBUTTONDOWN then  exit while
  Case else : if msg.message = WM_KEYDOWN orelse inkey=chr(27) then exit while
  End Select
  glClear(GL_COLOR_BUFFER_BIT)
  if bFlag then DrawString(50,150,"Hello World!",rgba(0,100,255,255),2,800,600)
  flip
Wend 
End
```
