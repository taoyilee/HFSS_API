% ----------------------------------------------------------------------------
function hfssBoxN(fid, Name, Start, Size, material)

% Preamble.
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreateBox _\n');

% Box Parameters.
fprintf(fid, 'Array("NAME:BoxParameters", _\n');
fprintf(fid, '"XPosition:=", "%s", _\n', Start{1});
fprintf(fid, '"YPosition:=", "%s", _\n', Start{2});
fprintf(fid, '"ZPosition:=", "%s", _\n', Start{3});
fprintf(fid, '"XSize:=", "%s", _\n', Size{1});
fprintf(fid, '"YSize:=", "%s", _\n', Size{2});
fprintf(fid, '"ZSize:=", "%s"), _\n', Size{3});

[mat colr solvin] = hfssgetmaterial(material);
% Box Attributes.
fprintf(fid, 'Array("NAME:Attributes", _\n');
fprintf(fid, '"Name:=", "%s", _\n', Name);
fprintf(fid, '"Flags:=", "", _\n');
fprintf(fid, '"Color:=", "(%s %s %s)", _\n', colr{1}, colr{2}, colr{3});
fprintf(fid, '"Transparency:=", 0, _\n');
fprintf(fid, '"PartCoordinateSystem:=", "Global", _\n');
fprintf(fid, '"MaterialName:=", "%s", _\n', mat);
if(solvin)
    fprintf(fid, '"SolveInside:=", true)\n');
else
    fprintf(fid, '"SolveInside:=", false)\n');
end

       
