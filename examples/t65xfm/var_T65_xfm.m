function param = var_T65_xfm(fid, OD, M9_W, M9_S)
    substrate = 350; % um
    lead = 20;
    encl = 150;
    H = substrate;
    y0 = 0;
    z0 = 0; 
    param = ['D' num2str(OD) 'W' num2str(M9_W) 'S' num2str(M9_S) ];
    hfssCreateVar(fid, 'M9_W', [num2str(M9_W) 'um']);
    hfssCreateVar(fid, 'M9_S', [num2str(M9_S) 'um']); 
    hfssCreateVar(fid, 'OD', [num2str(OD) 'um']);
    hfssCreateVar(fid, 'DIV', num2str(3.5));
    hfssCreateVar(fid, 'lead', [num2str(lead) 'um']);
    hfssCreateVar(fid, 'encl', [num2str(encl) 'um']);
    hfssCreateVar(fid, 'grid', '0.005');
    hfssCreateVar(fid, 'WE', '$OD+2*$lead+$M9_S');
    hfssCreateVar(fid, 'LE', '$OD+2*$lead+$M9_S');
    hfssCreateVar(fid, 'WI', '$M9_W');
    hfssCreateVar(fid, 'WO', '$M9_W');        
    hfssCreateVar(fid, 'W', '$WE+$encl');
    hfssCreateVar(fid, 'L', '$LE+$encl');
    hfssCreateVar(fid, 'H', [num2str(H) 'um']);
    hfssCreateVar(fid, 'move_x', '-$lead-$M9_S + $W/2 - $encl/2');
    hfssCreateVar(fid, 'move_y', num2str(y0));
    hfssCreateVar(fid, 'AirX', '$W');
    hfssCreateVar(fid, 'SUBS_T', [num2str(substrate) ' um'])
    hfssCreateVar(fid, 'AirY', '$L');
    hfssCreateVar(fid, 'AirZ', '$H');
    hfssCreateVar(fid, 'move_z', num2str(z0));
    % add a substrate
    hfssBoxN(fid, 'Substrate', {'-$AirX/2+$move_x','-$AirY/2+$move_y','$move_z'},{'$AirX','$AirY','-$SUBS_T'},'silicon');
    hfssWireFrame(fid, 'Substrate');
    hfssSetColor(fid, 'Substrate', [0 0 255]);      
    % Add an AirBox.
    hfssBoxN(fid, 'AirBox', {'-$AirX/2+$move_x','-$AirY/2+$move_y','-$SUBS_T+$move_z'},{'$AirX','$AirY','$AirZ+$SUBS_T'},'vacuum');
    hfssWireFrame(fid, 'AirBox');
    hfssAssignMaterial(fid, 'AirBox','air');
    hfssAssignRadiation(fid, 'ABC', 'AirBox');