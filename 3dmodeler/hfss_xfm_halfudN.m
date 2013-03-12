function serial = hfss_xfm_halfudN(fid,X , Y, Z, W, R_OP,L_OP, OD,Thickness, serial,material)
    [mat colr]=hfssgetmaterial(material);
    hfssUDP(fid, 'xfm_half', ['L' num2str(serial)], 10, {'Xpos', 'Ypos',  'Zpos','OD','W','L_OP', 'R_OP', 'Thickness', 'maskGrid', 'DIV'},...
            {X,Y,Z,OD,W,L_OP,R_OP,Thickness, '0.005', '$DIV'}, mat, colr, 1);
    hfssDuplicateMirror(fid, {['L' num2str(serial)]}, [0 0 0], [0 -1 0], '', false)
    serial = serial + 1;