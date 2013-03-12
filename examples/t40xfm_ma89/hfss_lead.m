function serial = hfss_lead(fid,X , Y, Z, W, L,Thickness,VIAW,VIAH, serial)
    hfssUDP(fid, 'lead_via', ['lead' num2str(serial)], 8, {'Xpos', 'Ypos',  'Zpos','W','L', 'Thickness','VIAW', 'VIAH'},...
            {X,Y,Z,W,L,Thickness, VIAW, VIAH}, hfssgetmaterial('T40_ME0d022'),{'0','255','0'});    
    serial = serial + 1;