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
oDesktop.OpenProject "G:\HFSS_SIMULATIONS\T65_SYM_CCT\SUBDIR\HFSS_FILENAME.hfss"
Set oProject = oDesktop.GetActiveProject
Set oDesign = oProject.SetActiveDesign("BEOL_6X1Z1U")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
Set oModule = oDesign.GetModule("Solutions")
oModule.ExportNetworkData "", Array("Setup24G:SWP40G"), 3, "G:\HFSS_SIMULATIONS\T65_SYM_CCT\SUBDIR\HFSS_FILENAME.s4p", Array("all"), true, 50.0
oProject.Save