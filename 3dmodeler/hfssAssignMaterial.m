
function hfssAssignMaterial(fid, Name, Material, varargin)
if(length(varargin) == 1)
    solveinside = varargin{1};
else
    solveinside = 1;
end

fprintf(fid, '\n');
fprintf(fid, 'oEditor.AssignMaterial _\n');
fprintf(fid, '\tArray("NAME:Selections", _\n');
fprintf(fid, '\t\t"Selections:=", "%s"), _\n', Name);  
fprintf(fid, '\tArray("NAME:Attributes", _\n');
fprintf(fid, '\t\t"MaterialName:=", "%s", _\n', Material);

% if the material is copper, we should set solve inside to be false and for
% other materials (in general) is should be true.
if (~solveinside || strcmp(Material, 'copper') || strcmp(Material, 'pec'))
	fprintf(fid, '\t\t"SolveInside:=", false)\n');
else	
	fprintf(fid, '\t\t"SolveInside:=", true)\n');
end;
