' Begining Technology-dependent Codes
' All number in um. 
' RF-VLSI Lab, National Chiao-Tung University.
' All Rights Reserved, 2012

Dim oAnsoftApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule
Set oAnsoftApp = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oAnsoftApp.GetAppDesktop()
oDesktop.RestoreWindow
oDesktop.OpenProject "F:\Dropbox\ANTLR\HFSS_API\examples\T65_SYM_CT_ANTLR\nominal.hfss"
Set oProject = oDesktop.GetActiveProject
oProject.SaveAs "G:\HFSS_SIMULATIONS\T65_SYM_CT\SYM_CT-D185W4S2.hfss", true
Set oDesign = oProject.SetActiveDesign("BEOL_6X1Z1U")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")

Set oProject = oDesktop.GetActiveProject

oProject.ChangeProperty Array("NAME:AllTabs", Array("NAME:ProjectVariableTab", Array("NAME:PropServers",  _
  "ProjectVariables"), Array("NAME:ChangedProps", Array("NAME:$M9_W", "Value:=", "4um"))))
oProject.ChangeProperty Array("NAME:AllTabs", Array("NAME:ProjectVariableTab", Array("NAME:PropServers",  _
  "ProjectVariables"), Array("NAME:ChangedProps", Array("NAME:$M9_S", "Value:=", "2um"))))
oProject.ChangeProperty Array("NAME:AllTabs", Array("NAME:ProjectVariableTab", Array("NAME:PropServers",  _
  "ProjectVariables"), Array("NAME:ChangedProps", Array("NAME:$OD", "Value:=", "185um"))))
   
  
rfvlsi_em_export = 100
rfvlsi_maskgrid=0.005

Set oEditor = oDesign.SetActiveEditor("3D Modeler")
	Function MetalHeight(iLayer)
	Select Case iLayer
		Case -2	'PO
			MetalHeight=-2.0
		Case -1	'OD
			MetalHeight=-1.0
		Case 0	'M1
			MetalHeight="$M1_Z"
		Case 1	'M2
			MetalHeight="$M2_Z"
		Case 2	'M3
			MetalHeight="$M3_Z"
		Case 3	'M4
			MetalHeight="$M4_Z"
		Case 4	'M5
			MetalHeight="$M5_Z"
		Case 5	'M6
			MetalHeight="$M6_Z"
		Case 6	'M7
			MetalHeight="$M7_Z"
		Case 7 	'M8
			MetalHeight="$M8_Z"
		Case 8	'M9
			MetalHeight="$M9_Z"
		Case Else	'AP
			MetalHeight="$M10_Z"
	End Select
End Function

Function MetalThickness(iLayer)
	Select Case iLayer
		Case -2	'PO
			MetalThickness="$M1_T"
		Case -1	'OD
			MetalThickness="$M1_T"
		Case 0	'M1
			MetalThickness="$M1_T"
		Case 1	'M2
			MetalThickness="$M2_T"
		Case 2	'M3
			MetalThickness="$M3_T"
		Case 3	'M4
			MetalThickness="$M4_T"
		Case 4	'M5
			MetalThickness="$M5_T"
		Case 5	'M6
			MetalThickness="$M6_T"
		Case 6	'M7
			MetalThickness="$M7_T"
		Case 7 	'M8
			MetalThickness="$M8_T"
		Case 8	'M9
			MetalThickness="$M9_T"
		Case Else	'AP
			MetalThickness="$M10_T"
	End Select
End Function

Function MetalMaterial(iLayer)
	Select Case iLayer
		Case -2	'PO
			MetalMaterial="copper"
		Case -1	'OD
			MetalMaterial="copper"
		Case 0	'M1
			MetalMaterial="copper"
		Case 1	'M2
			MetalMaterial="copper"
		Case 2	'M3
			MetalMaterial="copper"
		Case 3	'M4
			MetalMaterial="copper"
		Case 4	'M5
			MetalMaterial="copper"
		Case 5	'M6
			MetalMaterial="copper"
		Case 6	'M7
			MetalMaterial="copper"
		Case 7 	'M8
			MetalMaterial="copper"
		Case 8	'M9
			MetalMaterial="copper"
		Case Else	'AP
			MetalMaterial="copper"
	End Select
End Function

Function ViaHeight(iLayer)
	Select Case iLayer
		Case -2	'PO
			ViaHeight=-1.5
		Case -1	'OD
			ViaHeight=-0.5
		Case 0	'M1
			ViaHeight="$VIA1_Z"
		Case 1	'M2
			ViaHeight="$VIA2_Z"
		Case 2	'M3
			ViaHeight="$VIA3_Z"
		Case 3	'M4
			ViaHeight="$VIA4_Z"
		Case 4	'M5
			ViaHeight="$VIA5_Z"
		Case 5	'M6
			ViaHeight="$VIA6_Z"
		Case 6	'M7
			ViaHeight="$VIA7_Z"
		Case 7 	'M8
			ViaHeight="$VIA8_Z"
		Case 8	'M9
			ViaHeight="$VIA9_Z"
		Case Else	'AP
			ViaHeight=9.5
	End Select
End Function

Function ViaThickness(iLayer)
	Select Case iLayer
		Case -2	'PO
			ViaThickness=0.5
		Case -1	'OD
			ViaThickness=0.5
		Case 0	'M1
			ViaThickness="$VIA1_T"
		Case 1	'M2
			ViaThickness="$VIA2_T"
		Case 2	'M3
			ViaThickness="$VIA3_T"
		Case 3	'M4
			ViaThickness="$VIA4_T"
		Case 4	'M5
			ViaThickness="$VIA5_T"
		Case 5	'M6
			ViaThickness="$VIA6_T"
		Case 6	'M7
			ViaThickness="$VIA7_T"
		Case 7 	'M8
			ViaThickness="$VIA8_T"
		Case 8	'M9
			ViaThickness="$VIA9_T"
		Case Else	'AP
			ViaThickness="$VIA10_T"
	End Select
End Function

Function ViaMaterial(iLayer)
	Select Case iLayer
		Case -2	'PO
			ViaMaterial="copper"
		Case -1	'OD
			ViaMaterial="copper"
		Case 0	'M1
			ViaMaterial="copper"
		Case 1	'M2
			ViaMaterial="copper"
		Case 2	'M3
			ViaMaterial="copper"
		Case 3	'M4
			ViaMaterial="copper"
		Case 4	'M5
			ViaMaterial="copper"
		Case 5	'M6
			ViaMaterial="copper"
		Case 6	'M7
			ViaMaterial="copper"
		Case 7 	'M8
			ViaMaterial="copper"
		Case 8	'M9
			ViaMaterial="copper"
		Case Else	'AP
			ViaMaterial="copper"
	End Select
End Function

Function ViaMaterial(iLayer)
	Select Case iLayer
		Case -2	'PO
			ViaMaterial="copper"
		Case -1	'OD
			ViaMaterial="copper"
		Case 0	'M1
			ViaMaterial="copper"
		Case 1	'M2
			ViaMaterial="copper"
		Case 2	'M3
			ViaMaterial="copper"
		Case 3	'M4
			ViaMaterial="copper"
		Case 4	'M5
			ViaMaterial="copper"
		Case 5	'M6
			ViaMaterial="copper"
		Case 6	'M7
			ViaMaterial="copper"
		Case 7 	'M8
			ViaMaterial="copper"
		Case 8	'M9
			ViaMaterial="copper"
		Case Else	'AP
			ViaMaterial="copper"
	End Select
End Function

Function ViaWidthVec(iLayer)
	Select Case iLayer
		Case -1	'CO
			ViaWidthVec=0.09
		Case 0	'VIA1
			ViaWidthVec=0.1
		Case 1	'VIA2
			ViaWidthVec=0.1
		Case 2	'VIA3
			ViaWidthVec=0.1
		Case 3	'VIA4
			ViaWidthVec=0.1
		Case 4	'VIA5
			ViaWidthVec=0.1
		Case 5	'VIA6
			ViaWidthVec=0.1
		Case 6	'VIA7
			ViaWidthVec=0.36
		Case 7 	'VIA8
			ViaWidthVec=0.36
		Case Else	'RV
			ViaWidthVec=3.0
	End Select
End Function

Function ViaSpacingVec(iLayer)
	Select Case iLayer
		Case -1	'CO
			ViaSpacingVec=0.14
		Case 0	'VIA1
			ViaSpacingVec=0.13
		Case 1	'VIA2
			ViaSpacingVec=0.13
		Case 2	'VIA3
			ViaSpacingVec=0.13
		Case 3	'VIA4
			ViaSpacingVec=0.13
		Case 4	'VIA5
			ViaSpacingVec=0.13
		Case 5	'VIA6
			ViaSpacingVec=0.13
		Case 6	'VIA7
			ViaSpacingVec=0.54
		Case 7 	'VIA8
			ViaSpacingVec=0.54
		Case Else	'RV
			ViaSpacingVec=3.0
	End Select
End Function

Function ViaEncVec(iLayer)
	Select Case iLayer
		Case -1	'CO
			ViaEncVec=0.04
		Case 0	'VIA1
			ViaEncVec=0.04
		Case 1	'VIA2
			ViaEncVec=0.04
		Case 2	'VIA3
			ViaEncVec=0.04
		Case 3	'VIA4
			ViaEncVec=0.04
		Case 4	'VIA5
			ViaEncVec=0.04
		Case 5	'VIA6
			ViaEncVec=0.04
		Case 6	'VIA7
			ViaEncVec=0.08
		Case 7 	'VIA8
			ViaEncVec=0.3
		Case Else	'RV
			ViaEncVec=1.5
	End Select
End Function

Function MetalSingularEdgeFillVec(m)
	Select Case m
		Case 0, 1, 2, 3, 4, 5, 6
			returnVal = 0.5
		Case 7
			returnVal = 0.5
		Case 8
			returnVal = 2.0
		Case true
			returnVal = 3.0
	End Select
	MetalSingularEdgeFillVec = returnVal
End Function

Function drc_entry(m)
	Select Case m
		Case "co_diff"
			returnVal = 0.155
		Case "PO_S_4"
			returnVal = 0.05
		Case "co_diff_nch"
			returnVal = 0.115
		Case "co_diff_nch_25"
			returnVal = 0.135
		Case true
			returnVal = 0.2
	End Select
	drc_entry = returnVal
End Function

Function CoDiff(m)
	Select Case m
		Case "nch"
			returnVal = 0.115
		Case "pch"
			returnVal = 0.115
		Case "nch_lvt"
			returnVal = 0.115
		Case "nch_hvt"
			returnVal = 0.115
		Case "nch_25"
			returnVal = 0.135
		Case "pch_25"
			returnVal = 0.31
		Case "pch_lvt"
			returnVal = 0.2
		Case true
			returnVal = 0.2
	End Select
	CoDiff = returnVal
End Function

Function DiffWidth(m)
	Select Case m
		Case "nch"
			returnVal = 0.2
		Case "pch"
			returnVal = 0.2
		Case "nch_lvt"
			returnVal = 0.2
		Case "nch_hvt"
			returnVal = 0.2
		Case "nch_25"
			returnVal = 0.31
		Case "pch_25"
			returnVal = 0.31
		Case "pch_lvt"
			returnVal = 0.2
		Case true
			returnVal = 0.2
	End Select
	DiffWidth = returnVal
End Function


Function ImpbPP(m)
	Select Case m
		Case "nch"
			returnVal = true
		Case "pch"
			returnVal = false
		Case "nch_lvt"
			returnVal = true
		Case "nch_hvt"
			returnVal = true
		Case "nch_25"
			returnVal = true
		Case "pch_25"
			returnVal = false
		Case "pch_lvt"
			returnVal = false
		Case true
			returnVal = true
	End Select
	ImpbPP = returnVal
End Function

Function MOSYSpacing(m)
	Select Case m
		Case "nch"
			returnVal = 0.68
		Case "pch"
			returnVal = 0.68
		Case "nch_lvt"
			returnVal = 0.68
		Case "nch_hvt"
			returnVal = 0.68
		Case "nch_25"
			returnVal = 0.31
		Case "pch_lvt"
			returnVal = 0.68
		Case true
			returnVal = 0.2
	End Select
	MOSYSpacing = returnVal
End Function

Function OriginOffset(m)
	Select Case m
		Case "nch"
			returnVal = 0.1
		Case "pch"
			returnVal = 0.1
		Case "nch_lvt"
			returnVal = 0.1
		Case "nch_hvt"
			returnVal = 0.1
		Case "nch_25"
			returnVal = 0.155
		Case "pch_lvt"
			returnVal = 0.1
		Case true
			returnVal = 0.1
	End Select
	OriginOffset = returnVal
End Function

Function ViaWidthVec(m)
	Select Case m
		Case (1)
			returnVal = 0.09
		Case 0, 1, 2, 3, 4, 5
			returnVal = 0.1
		Case 6, 7
			returnVal = 0.36
		Case true
			returnVal = 3.0
	End Select
	ViaWidthVec = returnVal
End Function

Function MinMetWidth(m)
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
	MinMetWidth = returnVal
End Function

Function ViaSpacingVec(m)
	Select Case m
		Case (1)
			returnVal = 0.14
		Case 0, 1, 2, 3, 4, 5
			returnVal = 0.13
		Case 6, 7
			returnVal = 0.54
		Case true
			returnVal = 3.0
	End Select
	ViaSpacingVec = returnVal
End Function

Function MetSpacingVec(m)
	Select Case m
		Case 1
			returnVal = 0.09
		Case 2, 3, 4, 5, 6, 7
			returnVal = 0.1
		Case 8, 9
			returnVal = 0.54
		Case true
			returnVal = 3.0
	End Select
	MetSpacingVec = returnVal
End Function

Function ViaOneRowSpacingVec(m)
	Select Case m
		Case (1)
			returnVal = 0.11
		Case 0, 1, 2, 3, 4, 5
			returnVal = 0.1
		Case 6, 7
			returnVal = 0.34
		Case true
			returnVal = 3.0
	End Select
	ViaOneRowSpacingVec = returnVal
End Function

Function ViaEncVec(m)
	Select Case m
		Case (1), 0, 1, 2, 3, 4, 5
			returnVal = 0.04
		Case 6
			returnVal = 0.08
		Case 7
			returnVal = 0.3
		Case true
			returnVal = 1.5
	End Select
	ViaEncVec = returnVal
End Function

Function ViaMinEncWidthVec(m, bIsLast)

	If (bIsLast) Then
		Select Case m
			Case 0
				returnVal = 0.1
			Case 1, 2, 3, 4, 5, 6
				returnVal = 0.1
			Case 7
				returnVal = 0.4
			Case 8
				returnVal = 2.0
			Case true
				returnVal = 4.5
		End Select
	Else
		Select Case m
			Case 0
				returnVal = 0.1
			Case 1, 2, 3, 4, 5
				returnVal = 0.1
			Case 6, 7
				returnVal = 0.4
			Case 7
				returnVal = 0.4
			Case true
				returnVal = 4.5
		End Select
	End If

	ViaMinEncWidthVec = returnVal
End Function

Function ViaDiagonalEncVec(m)
	Select Case m
		Case 0, 1, 2, 3, 4, 5
			returnVal = 0.06
		Case 6
			returnVal = 0.115
		Case 7
			returnVal = 0.45
		Case true
			returnVal = 2.12
	End Select
	ViaDiagonalEncVec = returnVal
End Function

Function floor(Number)
	floor=Int(Number)
End Function

Function pcRound(Number)
	pcRound=Round(Number)
End Function

Function atoi(Number)
	atoi=CInt(Number)
End Function

Function Max(Number1, Number2)
	If (Number1>Number2) Then
		Max=Number1
	Else
		Max=Number2
	End If 
End Function

Function roundtogrid(Number)
	roundtogrid=Round(Number/rfvlsi_maskgrid)*rfvlsi_maskgrid
End Function

' This source code is generated by NCTU RFVLSI Lab SKILL -> HFSS VBscript translator.
' This SKILL/HFSS VBsciprt Translator is a intellectual property of RFVLSI Lab, NCTU, Taiwan
' All rights reserved. 2012. Confidential, and intended for internal use only. 

' local variable declarations
strLibName = "RFVLSI_N65"
strCellName = "xfm_lead"
Sub rfvlsiHFSS_Create_xfm_lead(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, L , W , WD , PINTXT , PINP , TOP_ME , BTM_ME , DUMMYL , DUMMYP , dummy )
	' content of let-statement	
		' local variable declarations
		rfvlsiHFSS_Create_vias rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _	
			rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
			W,L,atoi(TOP_ME),atoi(BTM_ME),true,true,false,false


End Sub


''Drawing output functions:
Sub CMetalRect(strORIENT, iMetalIndex, fOriginX, fOriginY, fWidth, fLength, iNumX, iNumY, fSpaceX, fSpaceY)			
	For iXCreateBox=0 To (iNumX-1) 
		For iYCreateBox=0 To (iNumY-1)		
			oEditor.CreateBox _
			Array("NAME:BoxParameters", _
			"XPosition:=", cstr(rfvlsi_newOriginX(fOriginX, fOriginY, strORIENT, (iXCreateBox*(fWidth+fSpaceX)), (iYCreateBox*(fLength+fSpaceY)), hfss_ORIENT_R0))&"um" , _
			"YPosition:=", cstr(rfvlsi_newOriginY(fOriginX, fOriginY, strORIENT, (iXCreateBox*(fWidth+fSpaceX)), (iYCreateBox*(fLength+fSpaceY)), hfss_ORIENT_R0))&"um" , _
			"ZPosition:=", MetalHeight(iMetalIndex), _
			"XSize:=", cstr(rfvlsi_newOriginX(0, 0, strORIENT, fWidth, fLength, hfss_ORIENT_R0)) &"um", _
			"YSize:=", cstr(rfvlsi_newOriginY(0, 0, strORIENT, fWidth, fLength, hfss_ORIENT_R0)) &"um", _
			"ZSize:=", MetalThickness(iMetalIndex)), _
			Array("NAME:Attributes", _
			"Name:=", "Metal"&cstr(iMetalIndex+1), _
			"Flags:=", "", _
			"Color:=", "(132 132 193)", _
			"Transparency:=", 0.75, _
			"PartCoordinateSystem:=", "Global", _
			"MaterialName:=",  MetalMaterial(iMetalIndex), _
			"SolveInside:=", false)
		Next
	Next
End Sub

Sub CViaRect(strORIENT, iViaIndex, fOriginX, fOriginY, fWidth, fLength, iNumX, iNumY, fSpaceX, fSpaceY)			
	For iXCreateBox=0 To (iNumX-1) 
		For iYCreateBox=0 To (iNumY-1) 
			oEditor.CreateBox _
			Array("NAME:BoxParameters", _
			"XPosition:=", cstr(rfvlsi_newOriginX(fOriginX, fOriginY, strORIENT, (iXCreateBox*(fWidth+fSpaceX)), (iYCreateBox*(fLength+fSpaceY)), hfss_ORIENT_R0)) &"um", _
			"YPosition:=", cstr(rfvlsi_newOriginY(fOriginX, fOriginY, strORIENT, (iXCreateBox*(fWidth+fSpaceX)), (iYCreateBox*(fLength+fSpaceY)), hfss_ORIENT_R0)) &"um", _
			"ZPosition:=", ViaHeight(iViaIndex), _
			"XSize:=", cstr(rfvlsi_newOriginX(0, 0, strORIENT, fWidth, fLength, hfss_ORIENT_R0)) &"um", _
			"YSize:=", cstr(rfvlsi_newOriginY(0, 0, strORIENT, fWidth, fLength, hfss_ORIENT_R0)) &"um", _
			"ZSize:=", ViaThickness(iViaIndex)), _
			Array("NAME:Attributes", _
			"Name:=", "Via"&cstr(iViaIndex+1), _
			"Flags:=", "", _
			"Color:=", "(132 132 193)", _
			"Transparency:=", 0.75, _
			"PartCoordinateSystem:=", "Global", _
			"MaterialName:=",  ViaMaterial(iViaIndex), _
			"SolveInside:=", false)
		Next
	Next
End Sub

Sub CMetalPolygon(iMetalIndex,hfss_ThicknessFactor,XArray,YArray)
	Dim strPolyname
	Dim iNumPts
	iNumPts=UBound(XArray)+1
	Dim arrayPolyLinePoints
	Redim arrayPolyLinePoints(iNumPts)' staring from index 0,point1, ... , pointLast

	Dim iPts
	arrayPolyLinePoints(0)="NAME:PolylinePoints"
	For iPts=1 To (iNumPts) 
		arrayPolylinePoints(iPts)=Array("NAME:PLPoint", "X:=", XArray(iPts-1)&"um", "Y:=",  YArray(iPts-1)&"um", "Z:=", MetalHeight(iMetalIndex))
	Next
	
	Dim arrayPolyLineSegments
	Redim arrayPolyLineSegments(iNumPts-1)
	arrayPolyLineSegments(0)="NAME:PolylineSegments"
	For iPts=1 To (iNumPts-1) 
		arrayPolyLineSegments(iPts)=Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", iPts-1, "NoOfPoints:=", iNumPts-2)
	Next

	idPolyShape = oEditor.CreatePolyline(Array("NAME:PolylineParameters", "IsPolylineCovered:=", true, "IsPolylineClosed:=",  true, arrayPolylinePoints, arrayPolyLineSegments), _
	Array("NAME:Attributes", "Name:=", "Metal"&cstr(iMetalIndex+1), "Flags:=", "", "Color:=",  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=", "", "MaterialValue:=", Chr(34)&"vacuum"&Chr(34), "SolveInside:=", true))

	oEditor.ThickenSheet Array("NAME:Selections", "Selections:=", idPolyShape, "NewPartsModelFlag:=",  _
	  "Model"), Array("NAME:SheetThickenParameters", "Thickness:=", hfss_ThicknessFactor&MetalThickness(iMetalIndex), "BothSides:=",  _
	  false)

	oEditor.AssignMaterial Array("NAME:Selections", "Selections:=", idPolyShape), Array("NAME:Attributes", "MaterialValue:=",  _
	  Chr(34)&MetalMaterial(iMetalIndex)&Chr(34), "SolveInside:=", false)

End Sub

Sub CViaPolygon(iViaIndex,hfss_ThicknessFactor,XArray,YArray)
	Dim strPolyname
	Dim iNumPts
	iNumPts=UBound(XArray)+1
	Dim arrayPolyLinePoints
	Redim arrayPolyLinePoints(iNumPts)' staring from index 0,point1, ... , pointLast

	Dim iPts
	arrayPolyLinePoints(0)="NAME:PolylinePoints"
	For iPts=1 To (iNumPts) 
		arrayPolylinePoints(iPts)=Array("NAME:PLPoint", "X:=", XArray(iPts-1)&"um", "Y:=",  YArray(iPts-1)&"um", "Z:=", ViaHeight(iViaIndex))
	Next
	
	Dim arrayPolyLineSegments
	Redim arrayPolyLineSegments(iNumPts-1)
	arrayPolyLineSegments(0)="NAME:PolylineSegments"
	For iPts=1 To (iNumPts-1) 
		arrayPolyLineSegments(iPts)=Array("NAME:PLSegment", "SegmentType:=", "Line", "StartIndex:=", iPts-1, "NoOfPoints:=", iNumPts-2)
	Next

	idPolyShape = oEditor.CreatePolyline( _
	Array("NAME:PolylineParameters", _
	"IsPolylineCovered:=", true, _
	"IsPolylineClosed:=",  true, _
	arrayPolylinePoints, _
	arrayPolyLineSegments), _ 
	Array("NAME:Attributes", "Name:=", "Via"&Cstr(iViaIndex+1), "Flags:=", "", "Color:=",  "(132 132 193)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=", "", "MaterialValue:=", Chr(34)&"vacuum"&Chr(34), "SolveInside:=", true))

	oEditor.ThickenSheet Array("NAME:Selections", "Selections:=", idPolyShape, "NewPartsModelFlag:=",  _
	  "Model"), Array("NAME:SheetThickenParameters", "Thickness:=", hfss_ThicknessFactor&ViaThickness(iViaIndex), "BothSides:=",  _
	  false)

	oEditor.AssignMaterial Array("NAME:Selections", "Selections:=", idPolyShape), Array("NAME:Attributes", "MaterialValue:=",  _
	  Chr(34)&ViaMaterial(iViaIndex)&Chr(34), "SolveInside:=", false)

End Sub

'Orientation Constant Definition:
Const rfvlsi_ORIENT_R0 = 0
Const rfvlsi_ORIENT_R90 = 1
Const rfvlsi_ORIENT_R180 = 2
Const rfvlsi_ORIENT_R270 = 3
Const rfvlsi_ORIENT_MX = 4
Const rfvlsi_ORIENT_MXR90 = 5
Const rfvlsi_ORIENT_MY = 6
Const rfvlsi_ORIENT_MYR90 = 7

Dim rfvlsiHFSS_RotateR0By
Dim rfvlsiHFSS_RotateR90By
Dim rfvlsiHFSS_RotateR180By
Dim rfvlsiHFSS_RotateR270By
Dim rfvlsiHFSS_RotateMXBy
Dim rfvlsiHFSS_RotateMXR90By
Dim rfvlsiHFSS_RotateMYBy
Dim rfvlsiHFSS_RotateMYR90By

rfvlsiHFSS_RotateR0By=Array(0,1,2,3,4,5,6,7)
rfvlsiHFSS_RotateR90By=Array(1,2,3,0,7,4,5,6)
rfvlsiHFSS_RotateR180By=Array(2,3,0,1,6,7,4,5)
rfvlsiHFSS_RotateR270By=Array(3,0,1,2,5,6,7,4)
rfvlsiHFSS_RotateMXBy=Array(4,5,6,7,0,1,2,3)
rfvlsiHFSS_RotateMXR90By=Array(5,6,7,4,3,0,1,2)
rfvlsiHFSS_RotateMYBy=Array(6,7,4,5,2,3,0,1)
rfvlsiHFSS_RotateMYR90By=Array(7,4,5,6,1,2,3,0)


Function rfvlsiHFSS_ThicknessFactor(rfvlsiHFSS_ORIENT)
	
	Select Case rfvlsiHFSS_ORIENT
      Case rfvlsi_ORIENT_R0
		rfvlsiHFSS_ThicknessFactor=""
      Case rfvlsi_ORIENT_R90
		rfvlsiHFSS_ThicknessFactor=""
      Case rfvlsi_ORIENT_R180
		rfvlsiHFSS_ThicknessFactor=""
      Case rfvlsi_ORIENT_R270
		rfvlsiHFSS_ThicknessFactor=""
      Case rfvlsi_ORIENT_MX
		rfvlsiHFSS_ThicknessFactor="-"
      Case rfvlsi_ORIENT_MXR90
		rfvlsiHFSS_ThicknessFactor="-"
      Case rfvlsi_ORIENT_MY
		rfvlsiHFSS_ThicknessFactor="-"
	  Case Else
		rfvlsiHFSS_ThicknessFactor="-"
   End Select
   
End Function

Function rfvlsi_newORIENT(orient1, orient2)
	Select Case orient1
      Case rfvlsi_ORIENT_R0
		rfvlsi_newORIENT=rfvlsiHFSS_RotateR0By(orient2)
      Case rfvlsi_ORIENT_R90
		rfvlsi_newORIENT=rfvlsiHFSS_RotateR90By(orient2)
      Case rfvlsi_ORIENT_R180
		rfvlsi_newORIENT=rfvlsiHFSS_RotateR180By(orient2)
      Case rfvlsi_ORIENT_R270
		rfvlsi_newORIENT=rfvlsiHFSS_RotateR270By(orient2)
      Case rfvlsi_ORIENT_MX
		rfvlsi_newORIENT=rfvlsiHFSS_RotateMXBy(orient2)
      Case rfvlsi_ORIENT_MXR90
		rfvlsi_newORIENT=rfvlsiHFSS_RotateMXR90By(orient2)
      Case rfvlsi_ORIENT_MY
		rfvlsi_newORIENT=rfvlsiHFSS_RotateMYBy(orient2)
	  Case Else
		rfvlsi_newORIENT=rfvlsiHFSS_RotateMYR90By(orient2)
   End Select
End Function

Function rfvlsi_newOriginX(offsetX, offsetY, offset_ORIENT, originX, originY, origin_ORIENT)
	Select Case offset_ORIENT
      Case rfvlsi_ORIENT_R0
		rfvlsi_newOriginX=offsetX+originX
      Case rfvlsi_ORIENT_R90
		rfvlsi_newOriginX=offsetX-originY
      Case rfvlsi_ORIENT_R180
		rfvlsi_newOriginX=offsetX-originX
      Case rfvlsi_ORIENT_R270
		rfvlsi_newOriginX=offsetX+originY
      Case rfvlsi_ORIENT_MX
		rfvlsi_newOriginX=offsetX+originX
      Case rfvlsi_ORIENT_MXR90
		rfvlsi_newOriginX=offsetX+originY
      Case rfvlsi_ORIENT_MY
		rfvlsi_newOriginX=offsetX-originX
	  Case Else
		rfvlsi_newOriginX=offsetX-originY
   End Select
End Function

Function rfvlsi_newOriginY(offsetX, offsetY, offset_ORIENT, originX, originY, origin_ORIENT)
	Select Case offset_ORIENT
      Case rfvlsi_ORIENT_R0
		rfvlsi_newOriginY=offsetY+originY
      Case rfvlsi_ORIENT_R90
		rfvlsi_newOriginY=offsetY+originX
      Case rfvlsi_ORIENT_R180
		rfvlsi_newOriginY=offsetY-originY
      Case rfvlsi_ORIENT_R270
		rfvlsi_newOriginY=offsetY-originX
      Case rfvlsi_ORIENT_MX
		rfvlsi_newOriginY=offsetY-originY
      Case rfvlsi_ORIENT_MXR90
		rfvlsi_newOriginY=offsetY+originX
      Case rfvlsi_ORIENT_MY
		rfvlsi_newOriginY=offsetY+originY
	  Case Else
		rfvlsi_newOriginY=offsetY-originY
   End Select
End Function
' This source code is generated by NCTU RFVLSI Lab SKILL -> HFSS VBscript translator.
' This SKILL/HFSS VBsciprt Translator is a intellectual property of RFVLSI Lab, NCTU, Taiwan
' All rights reserved. 2012. Confidential, and intended for internal use only. 

' This source code is generated by NCTU RFVLSI Lab SKILL -> HFSS VBscript translator.
' This SKILL/HFSS VBsciprt Translator is a intellectual property of RFVLSI Lab, NCTU, Taiwan
' All rights reserved. 2012. Confidential, and intended for internal use only. 
' This source code is generated by NCTU RFVLSI Lab SKILL -> HFSS VBscript translator.
' This SKILL/HFSS VBsciprt Translator is a intellectual property of RFVLSI Lab, NCTU, Taiwan
' All rights reserved. 2012. Confidential, and intended for internal use only. 

' local variable declarations
strLibName = "RFVLSI_N65"
strCellName = "vias"
Sub rfvlsiHFSS_Create_vias(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, Length , Width , TOP_ME , BTM_ME , bPP , conservative , x_cut , y_cut )
	' content of let-statement	
		'Redudant ID at current scope: netx
		' local variable declarations
		PP_ext = 0.02
		NP_ext = 0.13
		NW_ENC = 0.16
		CMetalRect rfvlsi_newORIENT(rfvlsi_PCellOffsetORIENT, rfvlsi_ORIENT_R0), _
			((BTM_ME-1)), _ 
			rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _ 
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _ 
			Width, Length, 1, 1, 1, 1		


		CMetalRect rfvlsi_newORIENT(rfvlsi_PCellOffsetORIENT, rfvlsi_ORIENT_R0), _
			((TOP_ME-1)), _ 
			rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _ 
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _ 
			(Width-0), (Length-0), 1, 1, 1, 1		


		For m = ((BTM_ME-1)) to ((TOP_ME-2))
			CMetalRect rfvlsi_newORIENT(rfvlsi_PCellOffsetORIENT, rfvlsi_ORIENT_R0), _
				(m), _ 
				rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _ 
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _ 
				(Width-0), (Length-0), 1, 1, 1, 1		

			enc_prime = ViaEncVec(m)

			If (conservative) Then
				enc_prime = max(ViaEncVec(m), (ViaSpacingVec(m))/(2))
			End If

			Pitch = (ViaWidthVec(m)+ViaSpacingVec(m))
			num_Horz_Vias = floor((((Width-(2)*(enc_prime))+ViaSpacingVec(m)))/(Pitch))

			If (x_cut) Then
				num_Horz_Vias = floor(((Width+ViaSpacingVec(m)))/(Pitch))
			End If

			num_Horz_Vias = max(num_Horz_Vias, 1)
			num_Vert_Vias = floor((((Length-(2)*(enc_prime))+ViaSpacingVec(m)))/(Pitch))

			If (y_cut) Then
				num_Vert_Vias = floor(((Length+ViaSpacingVec(m)))/(Pitch))
			End If

			num_Vert_Vias = max(num_Vert_Vias, 1)
			len_Horz_Edge = roundtogrid((((Width-(num_Horz_Vias)*(ViaWidthVec(m)))-((num_Horz_Vias-1))*(ViaSpacingVec(m))))/(2))
			len_Vert_Edge = roundtogrid((((Length-(num_Vert_Vias)*(ViaWidthVec(m)))-((num_Vert_Vias-1))*(ViaSpacingVec(m))))/(2))

			If ((rfvlsi_em_export=0)) Then

				If (((num_Vert_Vias>0) AND (num_Horz_Vias>0))) Then
					CViaRect rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsiHFSS_ORIENT_R0), _ 
						(m), _ 
						rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (len_Horz_Edge), (len_Vert_Edge), rfvlsi_ORIENT_R0), _ 
						rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (len_Horz_Edge), (len_Vert_Edge), rfvlsi_ORIENT_R0), _ 
						ViaWidthVec(m), ViaWidthVec(m), num_Horz_Vias, num_Vert_Vias, ViaSpacingVec(m), ViaSpacingVec(m)	

				End If

			Else
				CViaRect rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsiHFSS_ORIENT_R0), _ 
					(m), _ 
					rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _ 
					rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _ 
					Width, Length, 1, 1, ViaSpacingVec(m), ViaSpacingVec(m)	

			End If

		Next

End Sub


' local variable declarations
strLibName = "RFVLSI_N65"
strCellName = "xfm_body"
Sub rfvlsiHFSS_Create_xfm_body(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, OD , W , LOP , ROP , MET )
	' content of let-statement	
		' local variable declarations
		pi = 3.141592
		C = roundtogrid((W)*(tan((pi)/(8))))
		DIV = (2+Sqr(2))
		A = roundtogrid((OD)/(DIV))
		B = (OD-(2)*(A))
		BA = roundtogrid((B)/(2))
		BB = (B-BA)
		CMetalPolygon ((MET-1)), _
			rfvlsiHFSS_ThicknessFactor(rfvlsi_pcellOffsetORIENT), _
			Array(_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (BA), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (LOP), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (W), (LOP), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (W), ((BA-C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((A+C)), (((BA+A)-W)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (((OD-A)-C)), (((BA+A)-W)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OD-W)), ((BA-C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OD-W)), (ROP), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OD), (ROP), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OD), (BA), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OD-A)), ((BA+A)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (A), ((BA+A)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (BA), rfvlsi_ORIENT_R0)), _
			Array(_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (BA), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (LOP), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (W), (LOP), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (W), ((BA-C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((A+C)), (((BA+A)-W)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (((OD-A)-C)), (((BA+A)-W)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OD-W)), ((BA-C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OD-W)), (ROP), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OD), (ROP), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OD), (BA), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OD-A)), ((BA+A)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (A), ((BA+A)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (BA), rfvlsi_ORIENT_R0)) 
End Sub
' This source code is generated by NCTU RFVLSI Lab SKILL -> HFSS VBscript translator.
' This SKILL/HFSS VBsciprt Translator is a intellectual property of RFVLSI Lab, NCTU, Taiwan
' All rights reserved. 2012. Confidential, and intended for internal use only. 

' local variable declarations
strLibName = "RFVLSI_N65"
strCellName = "xfm_half"
Sub rfvlsiHFSS_Create_xfm_half(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, OD , W , S , B_TK , A_TK , LOP , ROP , TOP_ME , BTM_ME , en_dmy , via_to_next , via_diag )
	' content of let-statement	
		' local variable declarations
		pi = 3.141592
		P = (S+W)
		C = roundtogrid((W)*(tan((pi)/(8))))
		DIV = (2+Sqr(2))
		A = (roundtogrid((OD)/(DIV))-A_TK)
		B = ((OD-(2)*(A))-B_TK)
		BA = roundtogrid((B)/(2))
		BB = (B-BA)
		PA = roundtogrid((P)/(2))
		PB = (P-PA)
		'no corresponding for assigning masterx with specified function in HFSS, thus skipped translation.

		For i = (BTM_ME) to (TOP_ME)
			rfvlsiHFSS_Create_xfm_body rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				OD,W,LOP,ROP,i

		Next

		'no corresponding for assigning mastervd with specified function in HFSS, thus skipped translation.

		If (via_to_next) Then
			rfvlsiHFSS_Create_vias rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((OD-W)), (ROP), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((OD-W)), (ROP), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				(BA-ROP),W,TOP_ME,BTM_ME,true,true,false,false

			rfvlsiHFSS_Create_vias rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (A), (((BA+A)-W)), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (A), (((BA+A)-W)), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				W,B,TOP_ME,BTM_ME,true,true,false,false

		End If

		If (via_diag) Then
			rfvlsiHFSS_Create_vias_diagonal rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (BA), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (BA), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				((A-C)-W),(W+C),TOP_ME,BTM_ME

			rfvlsiHFSS_Create_vias_diagonal rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (OD), (BA), rfvlsi_ORIENT_MY), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (OD), (BA), rfvlsi_ORIENT_MY), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_MY), _
				((A-C)-W),(W+C),TOP_ME,BTM_ME

		End If

End Sub


strLibName = "RFVLSI_N65"
strCellName = "xfm_halfud"
Sub rfvlsiHFSS_Create_xfm_halfud(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, OD , W , S , B_TK , A_TK , LOP , ROP , LEADDYI , LEADDYO , en_dmy , TOP_ME , BTM_ME , via_to_next , via_diag )
	' content of let-statement	
		' local variable declarations
		rfvlsiHFSS_Create_xfm_half rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _	
			rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
			OD,W,S,B_TK,A_TK,(LOP+LEADDYI),(ROP+LEADDYO),TOP_ME,BTM_ME,en_dmy,via_to_next,via_diag

		rfvlsiHFSS_Create_xfm_half rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_MX), _
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_MX), _	
			rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_MX), _
			OD,W,S,B_TK,A_TK,(LOP-LEADDYI),(ROP-LEADDYO),TOP_ME,BTM_ME,en_dmy,via_to_next,via_diag

End Sub

' local variable declarations
strLibName = "RFVLSI_N65"
strCellName = "ind_hud_cross"
Sub rfvlsiHFSS_Create_ind_hud_cross(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, OD , W , S , OPENING , TOP_ME , BTM_ME , under , dummy , DUMMYL )
	' content of let-statement	
		' local variable declarations
		P = (W+S)

		If (((atoi(TOP_ME)-atoi(BTM_ME))<2)) Then
			via_to_next = false
		End If

		rfvlsiHFSS_Create_xfm_halfud rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((-OD))/(2)), (0), rfvlsi_ORIENT_R0), _
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((-OD))/(2)), (0), rfvlsi_ORIENT_R0), _	
			rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
			OD,W,S,0.0,0.0,((W/2)+S),OPENING,0.0,0.0,true, 9, 9,via_to_next,via_to_next


		If (under) Then
			rfvlsiHFSS_Create_xfm_cross rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((-OD))/(2)), (0), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((-OD))/(2)), (0), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				S,W,0.0, 9, 8,dummy,true,true,false

			rfvlsiHFSS_Create_xfm_cross rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((((-OD))/(2)+P)+W)), (0), rfvlsi_ORIENT_MY), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((((-OD))/(2)+P)+W)), (0), rfvlsi_ORIENT_MY), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_MY), _
				S,W,0.0, 9, 8,dummy,false,false,true
		End If

End Sub


strLibName = "RFVLSI_N65"
strCellName = "ind_sym_ct"
Sub rfvlsiHFSS_Create_ind_sym_ct(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, OD , W , OPENING , LEAD , S , TOP_ME , NT , L1A , L1B , BTM_ME , dummy , DUMMYL , NT_N )
		P = (W+S)
		
		rfvlsiHFSS_Create_ind_hud_cross rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _	
			rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
			OD,W,S,OPENING,TOP_ME,BTM_ME,true,dummy,"RFVLSI"


		If (NT>2) Then

			For i = (1) to ((NT-2))

				If (evenp(i)) Then
					rfvlsiHFSS_Create_ind_hud_cross rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _
						rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _	
						rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
						(OD-((2)*(i))*(P)),W,S,(2)*(W),TOP_ME,BTM_ME,true,dummy,"RFVLSI"

				Else
					rfvlsiHFSS_Create_ind_hud_cross rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_MY), _
						rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_MY), _	
						rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_MY), _
						(OD-((2)*(i))*(P)),W,S,(2)*(W),TOP_ME,BTM_ME,true,dummy,"RFVLSI"

				End If

			Next

		End If


		If (NT mod 2 = 0) Then
			rfvlsiHFSS_Create_ind_hud_cross rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				(OD-((2)*((NT-1)))*(P)),W,S,0,TOP_ME,BTM_ME,false,dummy,"RFVLSI"

		Else
			rfvlsiHFSS_Create_ind_hud_cross rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_MY), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_MY), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_MY), _
				(OD-((2)*((NT-1)))*(P)),W,S,0,TOP_ME,BTM_ME,false,dummy,"RFVLSI"

		End If

		rfvlsiHFSS_Create_xfm_lead rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((OD)/(2)), (OPENING), rfvlsi_ORIENT_R0), _
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((OD)/(2)), (OPENING), rfvlsi_ORIENT_R0), _	
			rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
			LEAD,W,1.0,"P1","dummy1",TOP_ME,BTM_ME,DUMMYL,"drawing",dummy

		rfvlsiHFSS_Create_xfm_lead rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((OD)/(2)), (((-OPENING)-W)), rfvlsi_ORIENT_R0), _
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((OD)/(2)), (((-OPENING)-W)), rfvlsi_ORIENT_R0), _	
			rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
			LEAD,W,1.0,"N1","dummy1",TOP_ME,BTM_ME,DUMMYL,"drawing",dummy


		If (NT mod 2 = 0) Then

			If ((NT=2)) Then
				rfvlsiHFSS_Create_xfm_lead rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((OD)/(2)-((NT-1))*(P))), (((-W))/(2)), rfvlsi_ORIENT_R0), _
					rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((OD)/(2)-((NT-1))*(P))), (((-W))/(2)), rfvlsi_ORIENT_R0), _	
					rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
					(LEAD+((NT-1))*(P)),W,1.0,"CT","dummy1","9","9",DUMMYL,"drawing",dummy

			Else
				rfvlsiHFSS_Create_vias rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((((OD)/(2)-(NT)*(P))+S)), (((-W))/(2)), rfvlsi_ORIENT_R0), _
					rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((((OD)/(2)-(NT)*(P))+S)), (((-W))/(2)), rfvlsi_ORIENT_R0), _	
					rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
					W,W,9,7,true,true,false,false

				rfvlsiHFSS_Create_xfm_lead rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((OD)/(2)-((NT-1))*(P))), (((-W))/(2)), rfvlsi_ORIENT_R0), _
					rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((OD)/(2)-((NT-1))*(P))), (((-W))/(2)), rfvlsi_ORIENT_R0), _	
					rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
					(LEAD+((NT-1))*(P)),W,1.0,"CT","dummy1","7","7",DUMMYL,"drawing",dummy

			End If

		Else
			rfvlsiHFSS_Create_vias rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((((-OD))/(2)+((NT-1))*(P))), (((-W))/(2)), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, ((((-OD))/(2)+((NT-1))*(P))), (((-W))/(2)), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				W,W,9,7,true,true,false,false

			rfvlsiHFSS_Create_xfm_lead rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((((-OD))/(2)+((NT-1))*(P))+W)), (((-W))/(2)), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((((-OD))/(2)+((NT-1))*(P))+W)), (((-W))/(2)), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				(((LEAD+OD)-(NT)*(P))+S),W,1.0,"CT","dummy1","7","7",DUMMYL,"drawing",dummy

		End If

End Sub


strLibName = "RFVLSI_N65"
strCellName = "xfm_cross"
Sub rfvlsiHFSS_Create_xfm_cross(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, WI , WO , S , TOP_ME , BTM_ME , dummy , viat , viad , top )
	' content of let-statement	
		' local variable declarations
		pi = 3.141592
		C = roundtogrid((WO)*(tan((pi)/(8))))
		C2 = roundtogrid((C)/(Sqr(2)))
		OOCH = (((WO+(WI)/(2))+S)-C2)

		If ((((2)*(S)+WI)<=(2.0)*(Sqr(2.0)))) Then
			OOCHD = roundtogrid(((2.0)*(Sqr(2.0))-WI))
		Else
			OOCHD = 0.0
		End If

		'no corresponding for assigning masterxdiag with specified function in HFSS, thus skipped translation.

		If (top) Then
			rfvlsiHFSS_Create_xfm_diag rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				WI,WO,S, 9,dummy

		Else
			rfvlsiHFSS_Create_xfm_diag rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _
				rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (0), rfvlsi_ORIENT_R0), _	
				rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
				WI,WO,S, 8,dummy

		End If

		rfvlsiHFSS_Create_vias rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (((-OOCH)-OOCHD)), rfvlsi_ORIENT_MX), _
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (0), (((-OOCH)-OOCHD)), rfvlsi_ORIENT_MX), _	
			rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_MX), _
			WO,WO,TOP_ME,BTM_ME,true,true,false,false

		rfvlsiHFSS_Create_vias rfvlsi_newOriginX(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((WI+WO)+(2)*(S))), ((OOCH+OOCHD)), rfvlsi_ORIENT_R0), _
			rfvlsi_newOriginY(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, (((WI+WO)+(2)*(S))), ((OOCH+OOCHD)), rfvlsi_ORIENT_R0), _	
			rfvlsi_newORIENT(rfvlsi_pcellOffsetORIENT, rfvlsi_ORIENT_R0), _
			WO,WO,TOP_ME,BTM_ME,true,true,false,false

End Sub

' This source code is generated by NCTU RFVLSI Lab SKILL -> HFSS VBscript translator.
' This SKILL/HFSS VBsciprt Translator is a intellectual property of RFVLSI Lab, NCTU, Taiwan
' All rights reserved. 2012. Confidential, and intended for internal use only. 

' local variable declarations
strLibName = "RFVLSI_N65"
strCellName = "xfm_diag"
Sub rfvlsiHFSS_Create_xfm_diag(rfvlsi_pcellOffsetX0, rfvlsi_pcellOffsetY0, rfvlsi_pcellOffsetORIENT, WI , WO , S , MET , dummy )
	' content of let-statement	
		' local variable declarations
		pi = 3.141592
		P = (S+WO)
		C = roundtogrid((WO)*(tan((pi)/(8))))
		K = roundtogrid(((P+C))/(2))
		C2 = roundtogrid((C)/(Sqr(2)))
		OO = (((2)*(WO)+WI)+(2)*(S))
		OOC = ((((2)*(WO)+WI)+(2)*(S))-(2)*(C2))
		OOCH = (OOC)/(2)
		OOH = (OO)/(2)
		
		If ((((2)*(S)+WI)<=(2.0)*(Sqr(2.0)))) Then
			OOCHD = roundtogrid(((2.0)*(Sqr(2.0))-WI))
		Else
			OOCHD = 0.0
		End If
		
		If ((((2)*(S)+WI)<=(2.0)*(Sqr(2)))) Then			
			CMetalPolygon (MET-1), _
			rfvlsiHFSS_ThicknessFactor(rfvlsi_pcellOffsetORIENT), _
			Array(_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH-roundtogrid((2*Sqr(2)-WI)))), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (WO), ((-OOCH- roundtogrid((2*Sqr(2)-WI)))), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (WO), ((-OOCH)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), ((OOCH-C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), (OOCH), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), (OOCH+roundtogrid((2*Sqr(2)-WI))), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OO-WO)), (OOCH+roundtogrid((2*Sqr(2)-WI))), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OO-WO)), (OOCH), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (((-OOCH)+C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH)), rfvlsi_ORIENT_R0)), _
			Array(_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH-roundtogrid((2*Sqr(2)-WI)))), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (WO), ((-OOCH-roundtogrid((2*Sqr(2)-WI)))), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (WO), ((-OOCH)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), ((OOCH-C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), (OOCH), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), (OOCH+roundtogrid((2*Sqr(2)-WI))), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OO-WO)), (OOCH+roundtogrid((2*Sqr(2)-WI))), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OO-WO)), (OOCH), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (((-OOCH)+C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH)), rfvlsi_ORIENT_R0)) 
		Else			
			CMetalPolygon (MET-1), _
			rfvlsiHFSS_ThicknessFactor(rfvlsi_pcellOffsetORIENT), _
			Array(_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (WO), ((-OOCH)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), ((OOCH-C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), (OOCH), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OO-WO)), (OOCH), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (((-OOCH)+C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginX(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH)), rfvlsi_ORIENT_R0)), _
			Array(_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (WO), ((-OOCH)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), ((OOCH-C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (OO), (OOCH), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, ((OO-WO)), (OOCH), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), (((-OOCH)+C)), rfvlsi_ORIENT_R0),_
				rfvlsi_newOriginY(rfvlsi_PCellOffsetX0, rfvlsi_PCellOffsetY0, rfvlsi_PCellOffsetORIENT, (0), ((-OOCH)), rfvlsi_ORIENT_R0)) 
		End If

		

End Sub
'Invoke TopCell
													   'OD , W , OPENING , LEAD , S , TOP_ME , NT , L1A , L1B , BTM_ME , dummy , DUMMYL , NT_N )
rfvlsiHFSS_Create_ind_sym_ct 0,  0,  rfvlsi_ORIENT_R0,  185,  4,  18, 20 , 2,   9 , 2 , "1n" , "1n" , 9 , false , "RFVLSI" , false 
' End Invoking topcell .... 
oProject.Save

A = oEditor.GetMatchedObjectName("Metal9*")
oEditor.Unite Array("NAME:Selections", "Selections:=",  Join(A,",")), Array("NAME:UniteParameters", "KeepOriginals:=",  _
false)
A = oEditor.GetMatchedObjectName("Metal8*")
oEditor.Unite Array("NAME:Selections", "Selections:=",  Join(A,",")), Array("NAME:UniteParameters", "KeepOriginals:=",  _
  false)
  A = oEditor.GetMatchedObjectName("Via8*")
oEditor.Unite Array("NAME:Selections", "Selections:=",  Join(A,",")), Array("NAME:UniteParameters", "KeepOriginals:=",  _
  false)

oProject.Save

A = oEditor.GetMatchedObjectName("Via8*")  
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "IMD_1aEQ", "Tool Parts:=",  _
	Join(A,",")), Array("NAME:SubtractParameters", "KeepOriginals:=", true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "IMD_9aEQ", "Tool Parts:=",  _
	Join(A,",")), Array("NAME:SubtractParameters", "KeepOriginals:=", true)

A = oEditor.GetMatchedObjectName("Metal9*")	
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "IMD_9aEQ", "Tool Parts:=",  _
	Join(A,",")), Array("NAME:SubtractParameters", "KeepOriginals:=", true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "IMD_9bEQ", "Tool Parts:=",  _
	Join(A,",")), Array("NAME:SubtractParameters", "KeepOriginals:=", true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "IMD_9cEQ", "Tool Parts:=",  _
	Join(A,",")), Array("NAME:SubtractParameters", "KeepOriginals:=", true)


	A = oEditor.GetMatchedObjectName("Via8*")  
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "IMD_1aEQ", "Tool Parts:=",  _
	Join(A,",")), Array("NAME:SubtractParameters", "KeepOriginals:=", true)
oEditor.Subtract Array("NAME:Selections", "Blank Parts:=", "IMD_9aEQ", "Tool Parts:=",  _
	Join(A,",")), Array("NAME:SubtractParameters", "KeepOriginals:=", true)
	
	
Set oModule = oDesign.GetModule("BoundarySetup")
oModule.AutoIdentifyPorts Array("NAME:Faces", 26981, 26993, 27005), false,_
Array("NAME:ReferenceConductors", "M1"), "1", true
oProject.Save