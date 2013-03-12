function param = var_T40_ind(fid, OD, M11_W, M11_S)
    substrate = 100; % um
    %M11_S = 2;
    %M11_W = 5;
    lead = 15; %OD = 100; 
    encl = 20;
    H = 100;
    y0 = 0;
    z0 = 0; 
    param = ['D' num2str(OD) 'W' num2str(M11_W) 'S' num2str(M11_S) ];
    hfssCreateVar(fid, 'M11_W', [num2str(M11_W) 'um']);
    hfssCreateVar(fid, 'M11_S', [num2str(M11_S) 'um']); 
    hfssCreateVar(fid, 'OD', [num2str(OD) 'um']);
    hfssCreateVar(fid, 'DIV', num2str(3.14));
    hfssCreateVar(fid, 'lead', [num2str(lead) 'um']);
    hfssCreateVar(fid, 'encl', [num2str(encl) 'um']);
    hfssCreateVar(fid, 'grid', '0.005');
    hfssCreateVar(fid, 'WE', '$OD+$lead+$M11_S');
    hfssCreateVar(fid, 'LE', '$OD+$lead+$M11_S');
    hfssCreateVar(fid, 'WI', '$M11_W');
    hfssCreateVar(fid, 'WO', '$M11_W');        
    hfssCreateVar(fid, 'W', '$WE+$encl');
    hfssCreateVar(fid, 'L', '$LE+$encl');
    hfssCreateVar(fid, 'H', [num2str(H) 'um']);
    hfssCreateVar(fid, 'move_x', '$W/2 - $encl/2');
    hfssCreateVar(fid, 'move_y', [num2str(y0) 'um']);
    hfssCreateVar(fid, 'AirX', '$W');
    hfssCreateVar(fid, 'SUBS_T', [num2str(substrate) ' um'])
    hfssCreateVar(fid, 'AirY', '$L');
    hfssCreateVar(fid, 'AirZ', '$H');
    hfssCreateVar(fid, 'move_z', [num2str(z0) 'um']);
    % add a substrate
    hfssBoxN(fid, 'Substrate', {'-$AirX/2+$move_x','-$AirY/2+$move_y','$move_z'}, ...
        {'$AirX','$AirY','-$SUBS_T'});
    hfssWireFrame(fid, 'Substrate');
    hfssAssignMaterial(fid, 'Substrate','silicon');
    hfssSetColor(fid, 'Substrate', [0 0 255]);      
    % Add an AirBox.
    hfssBoxN(fid, 'AirBox', {'-$AirX/2+$move_x','-$AirY/2+$move_y','-$SUBS_T+$move_z'},{'$AirX','$AirY','$AirZ+$SUBS_T'});
    hfssWireFrame(fid, 'AirBox');
    hfssAssignMaterial(fid, 'AirBox','air');
    hfssAssignRadiation(fid, 'ABC', 'AirBox');
    