function serial  = hfss_ind_open2(fid,X , Y, Z, W, S, OD, NT,  Thickness, lead, viaen , serial, material)
    [mat colr] = hfssgetmaterial(material);       
    hfssUDP(fid, 'inductor_open2', strcat('L', num2str(serial)), 12, {'Xpos', 'Ypos',  'Zpos', 'OD','S','NT', 'W','lead','Thickness', 'maskGrid', 'DIV', 'VIA_ENC'},...
            {X, Y, Z,   OD ,S, NT,W, lead, Thickness, '0.005', '3.14', viaen}, mat, colr);     
    serial = serial + 1;