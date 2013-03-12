function serial  = hfss_ind_sheet(fid,X , Y, Z, W, S, OD,thickness, NT,  lead, viaen, serial, material)
    [mat colr] = hfssgetmaterial(material);       
    hfssUDP(fid, 'inductor_sh', strcat('L', num2str(serial)), 11, {'Xpos', 'Ypos',  'Zpos', 'OD','S','NT', 'W','lead', 'maskGrid', 'DIV', 'VIA_ENC'},...
            {X, Y, Z,  OD ,S, NT,W, lead, '0.005', '3.14', viaen}, mat, colr, 1);             
    hfssAssignFiniteCond(fid, ['FC' strcat('L', num2str(serial)) ], strcat('L', num2str(serial)) , material, thickness);
    serial = serial + 1;