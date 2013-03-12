function param = var_T65_ind(fid, OD, M9_W, M9_S, NT)
    substrate = 350; % um
    %M9_S = 2;
    %M9_W = 5;
    lead = 20; %OD = 100; 
    encl = 200;
    H = 400;
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
    hfssCreateVar(fid, 'WE', '$OD+$lead+$M9_W');
    hfssCreateVar(fid, 'LE', '$OD+$lead+$M9_W');     
    hfssCreateVar(fid, 'W', '4*$WE');
    hfssCreateVar(fid, 'L', '4*$LE');
    hfssCreateVar(fid, 'H', [num2str(H) 'um']);
    hfssCreateVar(fid, 'move_x', '$WE/2');
    hfssCreateVar(fid, 'move_y', [num2str(y0) 'um']);

    hfssCreateVar(fid, 'move_z', [num2str(z0) 'um']);
    
    % add a substrate    
    permittivity = 11.9;
    bsigma = 1;
    material_name = 'SUBSTRATE';
    subs = hfss_substrate(fid, 0 ,substrate, permittivity, bsigma, material_name);
        
    % Add an AirBox.        
    hfssBoxN(fid, 'AirBox', {'-$AirX/2+$move_x','-$AirY/2+$move_y',['-$H/4-' subs]},{'$AirX','$AirY','$AirZ'},'air');
    hfssWireFrame(fid, 'AirBox');
    hfssAssignRadiation(fid, 'ABC', 'AirBox');
    
    