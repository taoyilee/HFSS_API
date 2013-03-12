function param = var_T65_xfm(fid, OD, M9_WI, M9_WO, M9_S)
    substrate = 350; % um
    lead = 20;
    encl = 100;
    H = 200;
    y0 = 0;
    z0 = 0; 
    
    param = ['D' num2str(OD) 'WI' num2str(M9_WI) 'WO' num2str(M9_WO) 'S' num2str(M9_S) ];
    hfssCreateVar(fid, 'M9_WI', [num2str(M9_WI) 'um']);
    hfssCreateVar(fid, 'M9_WO', [num2str(M9_WO) 'um']);
    hfssCreateVar(fid, 'M9_S', [num2str(M9_S) 'um']); 
    hfssCreateVar(fid, 'OD', [num2str(OD) 'um']);
    hfssCreateVar(fid, 'DIV', num2str(3.5));
    hfssCreateVar(fid, 'lead', [num2str(lead) 'um']);
    hfssCreateVar(fid, 'encl', [num2str(encl) 'um']);
    hfssCreateVar(fid, 'grid', '0.005');
    hfssCreateVar(fid, 'WE', '$OD+2*$lead+$M9_S');
    hfssCreateVar(fid, 'LE', '$OD+2*$lead+$M9_S');
    hfssCreateVar(fid, 'WI', '$M9_WI');
    hfssCreateVar(fid, 'WO', '$M9_WO');        
    hfssCreateVar(fid, 'W', '$WE+$encl');
    hfssCreateVar(fid, 'L', '$LE+$encl');
    hfssCreateVar(fid, 'H', [num2str(H) 'um']);
	hfssCreateVar(fid, 'GR_W', [num2str(5) 'um']);
    hfssCreateVar(fid, 'move_x', '$OD/2+$M9_WO-$GR_W');
    hfssCreateVar(fid, 'move_y', num2str(y0));
    hfssCreateVar(fid, 'move_z', num2str(z0));
    
    % add a substrate    
    permittivity = 11.9;
    bsigma = 1;
    material_name = 'SUBSTRATE';
    subs = hfss_substrate(fid, 0 ,substrate, permittivity, bsigma, material_name);
         
    % Add an AirBox.
    hfssBoxN(fid, 'AirBox', {'-$AirX/2+$move_x','-$AirY/2+$move_y',['-$H/4-' subs]},{'$AirX','$AirY','$AirZ'},'vacuum');
    hfssWireFrame(fid, 'AirBox');
    hfssAssignMaterial(fid, 'AirBox','air');
    hfssAssignRadiation(fid, 'ABC', 'AirBox');