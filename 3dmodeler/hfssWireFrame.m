function hfssWireFrame(fid, Name)

% Preamble.
fprintf(fid, '\n');
fprintf(fid, 'oEditor.ChangeProperty Array("NAME:AllTabs", Array("NAME:Geometry3DAttributeTab", Array("NAME:PropServers",  _\n');
fprintf(fid, '"%s"), Array("NAME:ChangedProps", Array("NAME:Display Wireframe", "Value:=", true))))\n', Name);
                
