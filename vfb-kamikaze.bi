#inclib "vfb-push"
Declare Function Kamikaze (ByRef Pec As ColumnHeaderStyle)

#define seed timer
Const xres=1024 'can change within reason
Const yres=768

Type pt
  As Single x,y
  As Long nsides
End Type

Type piece 
  As pt vel
  As pt p(1 to 30)
  As Ulong clr
  As Long active
  As zstring * 6 id
  as pt xy
  Declare Sub Construct(As pt,As pt,As Ulong,As pt,As Long,As String ,As Long)
End Type

Type stillpiece Extends piece
End Type

Type killerpiece Extends piece
End Type

Type eaterpiece Extends piece
End Type

Function rotate(pivot As pt,p As pt,a As Single) As pt
  Return  Type<pt>((Cos(a)*(p.x-pivot.x)-Sin(a)*(p.y-pivot.y)) +pivot.x,_
  (Sin(a)*(p.x-pivot.x)+Cos(a)*(p.y-pivot.y)) +pivot.y)
End Function

#define range(f,l) Rnd*((l)-(f))+(f)
#define Irange(f,l) Int(Rnd*((l+1)-(f)))+(f)

Sub piece.Construct(xy As pt,wh As pt,c As Ulong,v As pt,a As Long,s As String,sides As Long)
  Dim As Long ctr
  Dim As Single cx,cy
  For z As Single=0 To 360*2 Step 360/sides
    ctr+=1
    If ctr>sides Then Exit For
    p(ctr).x=xy.x+wh.x*Cos(z*.0174533)
    p(ctr).y=xy.y+wh.y*Sin(z*.0174533)
    cx+=p(ctr).x
    cy+=p(ctr).y
  Next z
  cx/=sides:cy/=sides
  Var ang=0.0
  If s="eat" Then ang=Atn(1) Else ang=Rnd
  For n As Long=1 To sides
    p(n)=rotate(Type(cx,cy),p(n),ang)
  Next n
  clr=c
  vel=v
  active=a
  id=s
  p(1).nsides=sides
End Sub

Function inpolygon(p1() As pt,Byval p2 As pt) As Long
  #define Winder(L1,L2,p) ((L1.x-L2.x)*(p.y-L2.y)-(p.x-L2.x)*(L1.y-L2.y))
  var lim=p1(1).nsides
  Dim As Long index,nextindex,wn,k=lim+1
  For n As Long=1 To lim
    index=n Mod k:nextindex=(n+1) Mod k
    If nextindex=0 Then nextindex=1
    If p1(index).y<=p2.y Then
      If p1(nextindex).y>p2.y Andalso  Winder(p1(index),p1(nextindex),p2)>0 Then wn+=1
    Else
      If p1(nextindex).y<=p2.y Andalso Winder(p1(index),p1(nextindex),p2)<0 Then wn-=1
    End If
  Next n
  Return wn
End Function

Function overlaps(p1() As pt,p2() As pt) As Long
    var lim1=p1(1).nsides,lim2=p2(1).nsides
  For m As Long=1 To lim2
    If inpolygon(p1(),p2(m)) Then Return 1
  Next m
  For m As Long=1 To  lim1
    If inpolygon(p2(),p1(m)) Then Return 1
  Next m
  Return 0
End Function

sub savefile(file as string,u() as piece)
    var h=freefile
    open file for binary access write as #h
    put #h, ,u()
    close #h
end sub

'=======SET UP========
randomize seed
Dim As stillpiece s(1 To 20)  
For n As Long=1 To 20
    dim as ulong clr
  lbl:
  do
    clr=irange(1,15)
    loop until clr<>3 and clr<>14 and clr<>4
  
  Var xx= range(50,xres-50),yy=range(50,yres-50)
  s(n).Construct(Type<pt>(xx,yy),Type<pt>(30,30),clr,Type<pt>(0,0),1,"still",irange(4,8))
  For m As Long=1 To n-1
    If overlaps(s(m).p(),s(n).p()) Then Goto lbl 'keep isolated
  Next m
Next n

Dim As killerpiece k(1 To 3)

For n As Long=1 To 3
  Var xx= range(50,xres-50),yy=range(50,yres-50)
  k(n).Construct(Type<pt>(xx ,yy),Type<pt>(20,20),4,Type<pt>(range(-1,1),range(-1,1)),1,"kill",3)
  'doesn't matter too much if it overlaps a still piece
Next n


Dim As eaterpiece e(1 To 1)
lbl2:
Var xx= range(50,xres-50),yy=range(50,yres-50)
e(1).Construct(Type<pt>(xx ,yy),Type<pt>(35,35),14,Type<pt>(range(-2,2),range(-2,2)),1,"eat",4)
For m As Long=1 To Ubound(k)
  var d=sqr( (e(1).p(1).x-k(m).p(1).x)^2+(e(1).p(1).y-k(m).p(1).y)^2)
  If overlaps(k(m).p(),e(1).p()) or d<200 Then Goto lbl2 'dont want to overlap or be near a killpiece
Next m

redim as piece save()

Dim As Long ctr
For n As Long=Lbound(s) To Ubound(s)'still pieces
  ctr+=1
  Redim Preserve save(1 To ctr)
  save(ctr)=s(n)
Next
For n As Long=Lbound(k) To Ubound(k)'killer pieces
  ctr+=1
  Redim Preserve save(1 To ctr)
  save(ctr)=k(n)
Next
Redim Preserve save(1 To ctr+1)
save(Ubound(save))=e(1)'the eater piece last


save(1).xy.x=xres 'pass the screen resolutions
save(1).xy.y=yres

savefile("gamedata",save())
print "Done"
sleep
End


  