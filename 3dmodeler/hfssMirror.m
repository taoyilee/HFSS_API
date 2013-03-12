function hfssMirror(fid, ObjectList, Base, Normal, Units)
nObjects = length(ObjectList);

fprintf(fid, 'oEditor.Mirror _\n');
fprintf(fid, '\tArray("NAME:Selections", "Selections:=", "');

% Object Selections.
for iObj = 1:nObjects,
	fprintf(fid, '%s', ObjectList{iObj});
	if (iObj ~= nObjects)
		fprintf(fid, ',');
	end;
end;
fprintf(fid, '"), _\n');

fprintf(fid, '\tArray("NAME:MirrorParameters", _\n');
fprintf(fid, '\t\t"MirrorBaseX:=",  "%f%s", _\n', Base(1), Units);
fprintf(fid, '\t\t"MirrorBaseY:=", "%f%s", _\n', Base(2), Units);
fprintf(fid, '\t\t"MirrorBaseZ:=", "%f%s", _\n', Base(3), Units);
fprintf(fid, '\t\t"MirrorNormalX:=",  "%f%s", _\n', Normal(1), Units);
fprintf(fid, '\t\t"MirrorNormalY:=", "%f%s", _\n', Normal(2), Units);
fprintf(fid, '\t\t"MirrorNormalZ:=", "%f%s" )\n', Normal(3), Units);


