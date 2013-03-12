function serial = hfss_xfm_cross_viaN(fid,X , Y, Z, W, S, OP, Thickness, viah, serial, material)
    [mat colr] = hfssgetmaterial(material);
    hfssUDP(fid, 'xfm_cross_via', ['C' num2str(serial)], 9, {'Xpos', 'Ypos',  'Zpos','W','S', 'OPEN', 'Thickness', 'maskGrid','viah'},...
            {X,Y,Z,W,S,OP,Thickness, '0.005', viah}, mat, colr);
    serial = serial + 1;