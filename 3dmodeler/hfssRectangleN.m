function hfssRectangleN(fid, Name, Axis, Start, Width, Height)

Transparency = 0.5;

% Preamble.
fprintf(fid, '\n');
fprintf(fid, 'oEditor.CreateRectangle _\n');

% Rectangle Parameters.
fprintf(fid, 'Array("NAME:RectangleParameters", _\n');
fprintf(fid, '"IsCovered:=", true, _\n');
fprintf(fid, '"XStart:=", "%s", _\n', Start{1});
fprintf(fid, '"YStart:=", "%s", _\n', Start{2});
fprintf(fid, '"ZStart:=", "%s", _\n', Start{3});

fprintf(fid, '"Width:=", "%s", _\n', Width);
fprintf(fid, '"Height:=", "%s", _\n', Height);

fprintf(fid, '"WhichAxis:=", "%s"), _\n', upper(Axis));

% Rectangle Attributes.
fprintf(fid, 'Array("NAME:Attributes", _\n');
fprintf(fid, '"Name:=", "%s", _\n', Name);
fprintf(fid, '"Flags:=", "", _\n');
fprintf(fid, '"Color:=", "(132 132 193)", _\n');
fprintf(fid, '"Transparency:=", %d, _\n', Transparency);
fprintf(fid, '"PartCoordinateSystem:=", "Global", _\n');
fprintf(fid, '"MaterialName:=", "vacuum", _\n');
fprintf(fid, '"SolveInside:=", true)\n');
