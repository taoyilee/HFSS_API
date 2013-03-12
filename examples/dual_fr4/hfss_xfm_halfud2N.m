function serial = hfss_xfm_halfud2N(fid,X , Y, Z, W, R_OP,L_OP, OD,Thickness,VIAW,VIAH, serial,material)
    [mat colr]=hfssgetmaterial(material);
    hfssUDP(fid, 'xfm_half_via', ['L' num2str(serial)], 12, {'Xpos', 'Ypos',  'Zpos','OD','W','L_OP', 'R_OP', 'Thickness', 'maskGrid', 'DIV', 'VIAW', 'VIAH'},...
            {X,Y,Z,OD,W,L_OP,R_OP,Thickness, '0.005', '$DIV', VIAW, VIAH}, mat, colr);
    hfssDuplicateMirror(fid, {['L' num2str(serial)]}, [0 0 0], [0 -1 0], '', false)
    serial = serial + 1;