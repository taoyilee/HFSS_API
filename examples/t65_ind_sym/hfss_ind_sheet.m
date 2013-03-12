function serial  = hfss_ind_sheet(fid,X , Y, Z, W, S, OD,NT,  lead, viaen, serial, material)
    [mat colr] = hfssgetmaterial(material);       
    ind_name = ['L' num2str(serial)];
    hfssUDP(fid, 'inductor_sh', ind_name, 11, {'Xpos', 'Ypos',  'Zpos', 'OD','S','NT', 'W','lead', 'maskGrid', 'DIV', 'VIA_ENC'},...
            {X, Y, Z,  OD ,S, NT,W, lead, '0.005', '3.14', viaen}, mat, colr, 1);             
    % hfssAssignMaterial(fid, ind_name, mat)
    % hfssAssignFiniteCond(fid, ['FC' strcat('L', num2str(serial)) ], strcat('L', num2str(serial)) , material, thickness);
    serial = serial + 1;