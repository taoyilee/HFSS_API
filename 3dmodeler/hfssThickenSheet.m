function hfssThickenSheet(fid, obj, thickness)
    fprintf(fid, '\n');
    fprintf(fid, 'oEditor.ThickenSheet Array("NAME:Selections", "Selections:=", "%s", "NewPartsModelFlag:=",  _\n', obj);
    fprintf(fid, '  "Model"), Array("NAME:SheetThickenParameters", "Thickness:=", "%s", "BothSides:=",  _\n', thickness);
    fprintf(fid, '  false)\n\n');