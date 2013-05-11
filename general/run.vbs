Dim oAnsoftApp
Dim oDesktop
Dim oProject
Dim oDesign
Dim oEditor
Dim oModule
Set oAnsoftApp = CreateObject("AnsoftHfss.HfssScriptInterface")
Set oDesktop = oAnsoftApp.GetAppDesktop()
oDesktop.RestoreWindow
oDesktop.OpenProject "HFSS_DIR\HFSS_FILENAME.hfss"
Set oProject = oDesktop.GetActiveProject
Set oDesign = oProject.SetActiveDesign("DESIGN_NAME")
Set oEditor = oDesign.SetActiveEditor("3D Modeler")
Set oModule = oDesign.GetModule("Solutions")
oModule.ExportNetworkData "", Array("SP_Sim:SP_Sim_Sweep"), 3, "HFSS_DIR\HFSS_FILENAME.s<N>p", Array("all"), true, 50.0
oProject.Save