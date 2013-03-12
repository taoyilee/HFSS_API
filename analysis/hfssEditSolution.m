function hfssEditSolution(fid, Name,  order,fGHz, maxDeltaS, maxPass)
% order = 0, 1, 2, -1
% create the necessary script.
fprintf(fid, '\n');
fprintf(fid, 'oModule.EditSetup "%s", Array("NAME:%s", "Frequency:=", "%fGHz", ',Name,Name,fGHz);
fprintf(fid, '"PortsOnly:=",  _\n');
fprintf(fid, '  false, "MaxDeltaS:=", %f, "UseMatrixConv:=", false, "MaximumPasses:=", %d, "MinimumPasses:=",  _\n', maxDeltaS, maxPass);
fprintf(fid, '  1, "MinimumConvergedPasses:=", 1, "PercentRefinement:=", 20, "IsEnabled:=",  _\n');
fprintf(fid, '  true, "BasisOrder:=", %s , "UseIterativeSolver:=", true, "IterativeResidual:=",  _\n', order);
fprintf(fid, '  0.0001, "DoLambdaRefine:=", true, "DoMaterialLambda:=", true, "SetLambdaTarget:=",  _\n');
fprintf(fid, '  false, "Target:=", 0.6667, "UseMaxTetIncrease:=", false, "PortAccuracy:=", 2, "UseABCOnPort:=",  _\n');
fprintf(fid, '  false, "SetPortMinMaxTri:=", false, "EnableSolverDomains:=", false, "ThermalFeedback:=",  _\n');
fprintf(fid, '  false, "NoAdditionalRefinementOnImport:=", false)\n');
