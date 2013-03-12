function hfssDeleteBoundaries(fid, Name)
% The usual fprintf stuff.
fprintf(fid, '\n');
fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');
fprintf(fid, 'oModule.DeleteBoundaries Array("%s")\n', Name);