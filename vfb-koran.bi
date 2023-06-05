#inclib "vfb-push"
Declare Function Koran ( ByRef Billion As boolean)
#include "windows.bi"
#include "GL/gl.bi"
Screen 19,32,,2

Sub setupgl
    Dim As Integer xres,yres
    Screeninfo xres,yres
    glDisable (GL_DEPTH_TEST)
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA)
    glEnable (GL_BLEND)
    glEnable (GL_LINE_SMOOTH)
    glOrtho 0, xres, yres,0,-1, 1
    glclearcolor 1,.5,0,1
End Sub
setupgl

declare Sub drawstring(xpos As Long,ypos As Long,text As String ,col As Ulong,size As Single,xres As Long,yres As Long)


Dim Win As Any Ptr

Screencontrol 2, *Cptr(Integer Ptr,@Win )

Var C=CreateWindowEx(0,"button","Message", WS_VISIBLE Or WS_CHILD,0,0,70,30,win,0,0,0)
Var D=CreateWindowEx(0,"Button","Hello", WS_VISIBLE Or WS_CHILD,0,35,70,30,win,0,0,0)
Var c1=CreateWindowEx(0,"STATIC","", WS_BORDER Or WS_VISIBLE Or WS_CHILD ,150,50,300,20,win,0,0,0)
Var E=CreateWindowEx(0,"Button","END",WS_BORDER or WS_VISIBLE Or WS_CHILD,150,80,60,30,win,0,0,0)
Dim As msg msg
dim as long flag
While GetMessage( @msg,Win,0,0)
   
    TranslateMessage(@msg)
    DispatchMessage(@msg)
    Select Case msg.hwnd
    Case C
        Select Case msg.message 
        Case WM_LBUTTONDOWN
           flag=0
            setWindowText(c1,"You can press any key to end or click END")
        End Select
        
      Case D
        Select Case msg.message 
        Case WM_LBUTTONDOWN
              flag=1
              setWindowText(c1,"                                       ")
        End Select  
       
    Case E
        Select Case msg.message 
        Case WM_LBUTTONDOWN
            End
        End Select
       
    End Select
   
    select case msg.message
    case WM_KEYDOWN
        end
    end select
    if inkey=chr(27) then end
    
     glClear(GL_COLOR_BUFFER_BIT)
     'gl in here
     if flag then drawstring(50,150,"Hello",rgb(0,100,255),2,800,600)
    flip
Wend

Sub drawstring(xpos As Long,ypos As Long,text As String ,col As Ulong,size As Single,xres As Long,yres As Long)
      glMatrixMode GL_PROJECTION 'save projection
      glPushMatrix
      glMatrixMode GL_MODELVIEW
      glPushMatrix
      
      glMatrixMode GL_PROJECTION 'make ortho
      glLoadIdentity
      glOrtho 0, xres, yres, 0,-1, 1
      glMatrixMode GL_MODELVIEW
      glLoadIdentity
      #define Red(c) ((c) Shr 16 And 255)
      #define Green(c) ((c) Shr  8 And 255)
      #define Blue(c) ((c) And 255)
      #define Alph(c) ((c) Shr 24)
      glColor4ub Red(col),Green(col),Blue(col),alph(col)
      glend
      glpointsize(1.1*size)
      glBegin (GL_POINTS)
      Type D2
            As Single x,y
      End Type
      Static As d2 cpt(),XY()
      Static As Long runflag
      If runflag=0 Then   
            Redim  XY(128,127)
            Redim cpt(1 To 64*2)
            Screen 8
            Width 640\8,200\16
            Dim As Ulong Pointer img
            Dim count As Long
            For ch As Long=1 To 127
                  img=Imagecreate(640,200)
                  Draw String img,(1,1),Chr(ch)
                  For x As Long=1 To 8 
                        For y As Long=1 To 16
                              If Point(x,y,img)<>0 Then
                                    count=count+1
                                    XY(count,ch)=Type<D2>(x,y)
                              End If
                        Next y
                  Next x
                  count=0
                  Imagedestroy img
            Next ch
            runflag=1
      End If
      If size=0 Then Exit Sub
      Dim As D2 np,t
      #macro Scale(p1,p2,d)
      np.x=d*(p2.x-p1.x)+p1.x
      np.y=d*(p2.y-p1.y)+p1.y
      #endmacro
      
      Dim As D2 c=Type<D2>(xpos,ypos)
      Dim As Long dx=xpos,dy=ypos
      For z6 As Long=1 To Len(text)
            Var asci=text[z6-1]
            For _x1 As Long=1 To 64*2
                  t=Type<D2>(XY(_x1,asci).x+dx,XY(_x1,asci).y+dy)         
                  Scale(c,t,size)
                  cpt(_x1)=np
                  
                  If XY(_x1,asci).x<>0 Then
                        If Abs(size)>0 Then
                              glVertex3f (cpt(_x1).x,(cpt(_x1).y),0)
                        End If
                  End If
            Next _x1
            dx=dx+8
      Next z6
      glend
      glMatrixMode GL_PROJECTION 'restore 
      glPopMatrix
      glMatrixMode GL_MODELVIEW
      glPopMatrix
End Sub

Sub inittext Constructor
      drawstring(0,0,"",0,0,0,0)
End Sub
End


 