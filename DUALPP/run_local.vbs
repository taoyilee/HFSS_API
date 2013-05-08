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
oDesktop.OpenProject "C:\Users\michaelgod\Dropbox\GIT\HFSS_API\DUALP\output\ind_dualp_O120W4S2.hfss"
Set oProject = oDesktop.GetActiveProject
Set oDesign = oProject.SetActiveDesign("ind_dualp")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
Set oModule = oDesign.GetModule("Solutions")
oModule.ExportNetworkData "", Array("SP_Sim:SP_Sim_Sweep"), 3, "C:\Users\michaelgod\Dropbox\GIT\HFSS_API\DUALP\output\ind_dualp_O120W4S2.s3p", Array("all"), true, 50.0
oProject.Save