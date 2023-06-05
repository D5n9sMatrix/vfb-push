#inclib "vfb-push"
Declare Function QG (ByRef Electorate As ButtonAlignment)
width 100,500
#include "file.bi"

type udt 
    as zstring * 50 num
    as long x,y
    as string * 100 s
    as single a(1 to 8)
    declare sub printout()
end type

sub udt.printout()
    with this
    print .num
    print .x,.y
    print .s
    for m as long=lbound(.a) to ubound(.a)
       print .a(m);
    next m
    print
end with
print
    end sub

sub load(file as string,u() as udt)
   var  f=freefile
   if fileexists(file)=0 then print file;"  not found":return
    Open file For Binary Access Read As #f
    If Lof(f) > 0 Then
      Get #f, ,u()
    End If
    Close #f
    end sub

sub save(file as string,u() as udt)
    var h=freefile
    open file for binary access write as #h
    put #h, ,u()
    close #h
end sub

dim as udt x(1 to 3)

for n as long=lbound(x) to ubound(x)
    with x(n)
    .num= "Element " +str(n)
    .x=n
    .y=n*2
    .s="hi " +string(70,"-") +str(n)
    for m as long=lbound(.a) to ubound(.a)
        .a(m)=rnd
    next m
    end with
next n

print "ORIGINAL"
for n as long=lbound(x) to ubound(x)
    x(n).printout()
next

save("data",x())



var N=filelen("data")\sizeof(udt) 'get the number of elements to load

redim as udt y(1 to N)
load("data",y())
print
print
print "============= FROM FILE ============="
for n as long=1 to ubound(y)
    y(n).printout()
next

sleep
kill "data"
End
 