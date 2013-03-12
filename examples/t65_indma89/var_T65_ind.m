function param = var_T65_ind(fid, OD, M11_W, M11_S, NT)
    substrate = 500; % um
    %M11_S = 2;
    %M11_W = 5;
    lead = 20; %OD = 100; 
    encl = 200;
    H = 400;
    y0 = 0;
    z0 = 0; 
    param = ['D' num2str(OD) 'W' num2str(M11_W) 'S' num2str(M11_S) ];
    hfssCreateVar(fid, 'M11_W', [num2str(M11_W) 'um']);
    hfssCreateVar(fid, 'M11_S', [num2str(M11_S) 'um']); 
    hfssCreateVar(fid, 'NT', num2str(NT)); 
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
    hfssCreateVar(fid, 'AirX', '$W+100um');
    hfssCreateVar(fid, 'SUBS_T', [num2str(substrate) ' um'])
    hfssCreateVar(fid, 'AirY', '$L+100um');
    hfssCreateVar(fid, 'AirZ', '$H+100um');
    hfssCreateVar(fid, 'move_z', [num2str(z0) 'um']);
    % add a substrate
    
    permittivity = 11.9;
    bsigma = 10;
    material_name = 'SUBSTRATE';
    hfssAddMaterial(fid, material_name, permittivity,bsigma,0);   
        
    hfssBoxN(fid, 'Substrate', {'-$W/2+$move_x','-$L/2+$move_y','$move_z'}, ...
        {'$W','$L','-$SUBS_T'},'SUBSTRATE');
    hfssWireFrame(fid, 'Substrate');
    hfssSetColor(fid, 'Substrate', [0 0 255]);      
    % Add an AirBox.
    hfssBoxN(fid, 'AirBox', {'-$AirX/2+$move_x','-$AirY/2+$move_y','-$SUBS_T+$move_z'},{'$AirX','$AirY','$AirZ+$SUBS_T'},'air');
    hfssWireFrame(fid, 'AirBox');
    hfssAssignRadiation(fid, 'ABC', 'AirBox');
    