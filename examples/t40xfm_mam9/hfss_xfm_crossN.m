function serial = hfss_xfm_crossN(fid,X , Y, Z, W, S, OP, Thickness, serial)
    hfssUDP(fid, 'xfm_cross', ['C' num2str(serial)], 8, {'Xpos', 'Ypos',  'Zpos','W','S', 'OPEN', 'Thickness', 'maskGrid'},...
            {X, Y, Z,W, S, OP,Thickness, '0.005'}, hfssgetmaterial('T40_ME0d022'),{'255','0','0'});
    serial = serial + 1;