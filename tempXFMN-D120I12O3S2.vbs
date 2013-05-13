Dim oAnsoftApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule
Set oAnsoftApp = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oAnsoftApp.GetAppDesktop()
oDesktop.RestoreWindow
oDesktop.OpenProject "E:\HFSS_API_RUN\XFMN2\XFMN-D120I12O3S2.hfss"
Set oProject = oDesktop.GetActiveProject
Set oDesign = oProject.SetActiveDesign("xfm_highk")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
oDesign.Analyze "SP_Sim"
Set oModule = oDesign.GetModule("Solutions")
oModule.ExportNetworkData "", Array("SP_Sim:SP_Sim_Sweep"), 3, "E:\HFSS_API_RUN\XFMN2\XFMN-D120I12O3S2.s4p", Array("all"), true, 50.0
oProject.Save