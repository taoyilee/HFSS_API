function serial = hfss_lead(fid,X , Y, Z, W, L,Thickness,VIAW,VIAH, serial,material)
    [mat colr]=hfssgetmaterial(material);
    hfssUDP(fid, 'lead_via', ['lead' num2str(serial)], 8, {'Xpos', 'Ypos',  'Zpos','W','L', 'Thickness','VIAW', 'VIAH'},...
            {X,Y,Z,W,L,Thickness, VIAW, VIAH}, mat, colr);    
    serial = serial + 1;