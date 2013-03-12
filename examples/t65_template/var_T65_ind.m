function param = var_T65_ind(fid, OD, M9_W, M9_S, NT)
    substrate = 350; % um
    %M9_S = 2;
    %M9_W = 5;
    lead = 15; %OD = 100; 
    encl = 20;
    H = 100;
    y0 = 0;
    z0 = 0; 
    param = ['D' num2str(OD) 'W' num2str(M9_W) 'S' num2str(M9_S) ];
    hfssCreateVar(fid, 'M9_W', [num2str(M9_W) 'um']);
    hfssCreateVar(fid, 'M9_S', [num2str(M9_S) 'um']); 
    hfssCreateVar(fid, 'NT', num2str(NT)); 
    hfssCreateVar(fid, 'OD', [num2str(OD) 'um']);
    hfssCreateVar(fid, 'DIV', num2str(3.14));
    hfssCreateVar(fid, 'lead', [num2str(lead) 'um']);
    hfssCreateVar(fid, 'encl', [num2str(encl) 'um']);
    hfssCreateVar(fid, 'grid', '0.005');
    hfssCreateVar(fid, 'WE', '$OD+$lead+$M9_S');
    hfssCreateVar(fid, 'LE', '$OD+$lead+$M9_S');
    hfssCreateVar(fid, 'WI', '$M9_W');
    hfssCreateVar(fid, 'WO', '$M9_W');        
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
    permittivity = 11.9;
    bsigma = 5; % 5- 10
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
    