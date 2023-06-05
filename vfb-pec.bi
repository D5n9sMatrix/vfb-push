#inclib "vfb-push"
Declare Function StatesEasyFuel (ByRef Emergency As boolean)
	hFileMenuBar = CreateMenu()
	AppendMenu(hFileMenuBar, MF_STRING, 1, "&Commander Window")
	AppendMenu(hFileMenuBar, MF_STRING, 2, "&Output Window")
	SetMenu(child, hFileMenuBar)
	DrawMenuBar(child)
End   