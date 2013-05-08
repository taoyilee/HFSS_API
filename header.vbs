Function evenp(Number)
	evenp=(Number Mod 2 = 0)
End Function

Function MinMetSpacing(m)
	Select Case m
		Case 0
			returnVal = 0.09
		Case 1, 2, 3, 4, 5, 6, 7
			returnVal = 0.1
		Case 8, 9
			returnVal = 2.0
		Case true
			returnVal = 3.0
	End Select
	MinMetSpacing = returnVal
End Function
