#inclib "vfb-push"
Declare Function Commit (ByRef Special As byte)
' ...
Type tPlane
	callsign As String
	origin As String
	destination As String
	position As tPosition
	target As tPosition
	
	xdisp As Integer
	ydisp As Integer
	tagDispx As Integer
	tagDispy As Integer
	tagDispBasex As Integer = 15 '10
	tagDispBasey As Integer = -29 '-24
	Union
		selbuffer_ As Byte
		selbuffer As tMark
	End Union
	
	altitude As Double 'ft
	targetAltitude As Integer 'ft
	messageAltitude As Integer 'ft
	climbrate As Integer = 30 'ft/min
	descendrate As Integer = 30 'ft/min
	tagAltitude As String
			
	direction As Double 'as angle
	turn As String
	messageTurn As String
			
	speed As Double 'kt
	targetSpeed As Integer 'kt
	messageSpeed As Integer 'kt
	maxSpeed As Integer = 450 'kt  (450kt = 833 km/h) '(500kt = 910 km/h)
	stallSpeed As Integer = 120 'kt (120kt = 222 km/h)
	approachSpeed As Integer = 150 'kt (150kt = 278 km/h)
	cruiseSpeed As Integer = 400 'kt (400kt = 740 km/h)
	acceleration As Integer = 5 'kt/s
	deceleration As Integer = 5 'kt/s
	tagSpeed As String
		
	timerem As Double
	scheduledDepartureTime As Double
	fuel As Double 'as time
	messageLock As Double '= 2
	Union 
		planeflags As UShort 'for saving / loading
		planeflag As tPlaneflag
	End Union
	Union
		mark_ As Byte
		mark As tMark
	End Union
	flightstatus As Byte
	runway_ As Byte
	wheelrem As Integer
	listColor As tMMcolors
	comment As String
			
	Static As Integer tagTop 
	Static As Integer tagBottom 
	Static As Integer tagLeft 
	Static As Integer tagRight 
	Static As tPlane plane() 'planes array
		
	Declare Static Function create(org As Integer = 0) As boolean
	Declare Sub operate(mode As Integer)
	Declare Function checkApproach(runway As tRunway) As Integer
	Declare Sub savePlane(filenr As Integer)
	Declare Sub loadPlane(filenr As Integer)
	
End Type

'dim static variables
Static As Integer tPlane.tagTop    = -29 '-24
Static As Integer tPlane.tagBottom =  29 '24
Static As Integer tPlane.tagLeft   = -35 '-30
Static As Integer tPlane.tagRight  =  15 '10

ReDim As tPlane tPlane.plane(0)

...


Sub tPlane.savePlane(filenr As Integer)
	
	Print #filenr, "PLANE"
	Print #filenr, callsign
	Print #filenr, destination
	Print #filenr, origin
	Print #filenr, position.x
	Print #filenr, position.y
	Print #filenr, tagDispBasex
	Print #filenr, tagDispBasey
	Print #filenr, target.x
	Print #filenr, target.y
	Print #filenr, selbuffer_
	Print #filenr, altitude
	Print #filenr, targetAltitude
	Print #filenr, messageAltitude
	Print #filenr, direction
	Print #filenr, turn
	Print #filenr, messageTurn
	Print #filenr, speed
	Print #filenr, targetSpeed
	Print #filenr, messageSpeed
	Print #filenr, timerem
	Print #filenr, scheduledDepartureTime
	Print #filenr, fuel
	Print #filenr, planeflags
	Print #filenr, mark_
	Print #filenr, flightstatus
	Print #filenr, runway_
		
End Sub

Sub tPlane.loadPlane(filenr As Integer)
	
	Input #filenr, callsign
	Input #filenr, destination
	Input #filenr, origin
	Input #filenr, position.x
	Input #filenr, position.y
	Input #filenr, tagDispBasex
	Input #filenr, tagDispBasey
	Input #filenr, target.x
	Input #filenr, target.y
	Input #filenr, selbuffer_
	Input #filenr, altitude
	Input #filenr, targetAltitude
	Input #filenr, messageAltitude
	Input #filenr, direction
	Input #filenr, turn
	Input #filenr, messageTurn
	Input #filenr, speed
	Input #filenr, targetSpeed
	Input #filenr, messageSpeed
	Input #filenr, timerem
	Input #filenr, scheduledDepartureTime
	Input #filenr, fuel
	Input #filenr, planeflags
	Input #filenr, mark_
	Input #filenr, flightstatus
	Input #filenr, runway_
	timerem = Timer
	operate(0)
End Sub

...

ff = FreeFile
Open "resume.pln" For Output As #ff
...
For p = 1 To UBound(tPlane.plane)
	tPlane.plane(p).savePlane(ff)
Next
Close ff
	
...

ff = FreeFile
Open "resume.pln" For Input As #ff
...
ReDim tPlane.plane(0)
p = 0
Do Until Eof(ff)
	Input #ff, g
	If g = "PLANE" Then
		p += 1
		tPlane.create(-1) 
		tPlane.plane(p).loadPlane(ff)
	EndIf
Loop
Close ff
End


