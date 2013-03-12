% ----------------------------------------------------------------------------
% function hfssBox(fid, Name, Start, Size, Units, [Center1], [Radius1], ...
%                  [Axis1], [Center2], [Radius2], [Axis2], ...)
% 
% Description :
% -------------
% Create the VB Script necessary to create a Box (or Cuboid) in HFSS. This 
% function also p
function hfssUDP_simple(fid,dllname, iName, nop,params, values,color)

% Preamble.
fprintf(fid, '\n');

fprintf(fid, 'oEditor.CreateUserDefinedPart Array("NAME:UserDefinedPrimitiveParameters", "DllName:=",  _\n');
fprintf(fid, '"%s", "Version:=", "1.0", "NoOfParameters:=", %d, "Library:=", "userlib", Array("NAME:ParamVector", _\n',dllname, nop);
    for i=1:nop-1

        fprintf(fid, 'Array("NAME:Pair", "Name:=", "%s", "Value:=", "%s"), _\n', params{i},  values{i});
    end
    fprintf(fid, 'Array("NAME:Pair", "Name:=", "%s", "Value:=", "%s"))), _\n', params{nop},  values{nop});
    fprintf(fid, 'Array("NAME:Attributes", "Name:=", "%s", "Flags:=", "", "Color:=",  _\n',iName);
    fprintf(fid, '  "(%s %s %s)", "Transparency:=", 0, "PartCoordinateSystem:=", "Global", "UDMId:=",  _\n', color{1}, color{2}, color{3});
    fprintf(fid, '  "", "MaterialValue:=", "%s", "SolveInside:=",  _\n', material);
if(solvein)
    fprintf(fid, '  true)\n');	                   
else
    fprintf(fid, '  false)\n');	                   
end
