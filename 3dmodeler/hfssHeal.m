function hfssHeal(fid, Parts)

% Preamble.
fprintf(fid, '\n');
fprintf(fid, 'oEditor.HealObject Array("NAME:Selections", "Selections:=",  _\n');

% Add  Parts.
if (iscell(Parts))
	nTool = length(Parts);
	fprintf(fid, '"');
	for iB = 1:nTool-1,
		fprintf(fid, '%s,', Parts{iB});
	end;
	fprintf(fid, '%s" _\n', Parts{nTool});
else
	fprintf(fid, '"%s" _\n', Parts);
end;

  fprintf(fid, ', "NewPartsModelFlag:=", "Model"), Array("NAME:ObjectHealingParameters", "Version:=",  _\n');
  fprintf(fid, '1, "AutoHeal:=", true, "TolerantStitch:=", true, "SimplifyGeom:=", true, "TightenGaps:=",  _\n');
  fprintf(fid, 'true, "StopAfterFirstStitchError:=", false, "MaxStitchTol:=", 0.001, "ExplodeAndStitch:=",  _\n');
  fprintf(fid, 'true, "GeomSimplificationTol:=", -1, "MaximumGeneratedRadiusForSimplification:=",  _\n');
  fprintf(fid, '-1, "SimplifyType:=", 2, "TightenGapsWidth:=", 1E-006, "RemoveSliverFaces:=",  _\n');
  fprintf(fid, 'false, "RemoveSmallEdges:=", false, "RemoveSmallFaces:=", false, "SliverFaceTol:=",  _\n');
  fprintf(fid, '0, "SmallEdgeTol:=", 0, "SmallFaceAreaTol:=", 0, "BoundingBoxScaleFactor:=",  _\n');
  fprintf(fid, '1250, "RemoveHoles:=", false, "RemoveChamfers:=", false, "RemoveBlends:=",  _\n');
  fprintf(fid, 'false, "HoleRadiusTol:=", 0, "ChamferWidthTol:=", 0, "BlendRadiusTol:=", 0, "AllowableSurfaceAreaChange:=",  _\n');
  fprintf(fid, '5, "AllowableVolumeChange:=", 5)\n');
