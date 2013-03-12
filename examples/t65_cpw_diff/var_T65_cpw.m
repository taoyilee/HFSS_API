function param = var_T65_cpw(fid,M9_W, M9_GS, M9_SS,M9_L,GND_H,GND_F)
    substrate = 350; % um    
    encl = 100;
    H = 400;
    y0 = 0;
    z0 = 0; 
    param = ['W' num2str(M9_W) 'GS' num2str(M9_GS) 'SS' num2str(M9_SS) 'L' num2str(M9_L)];
    hfssCreateVar(fid, 'M9_W', [num2str(M9_W) 'um']);
    hfssCreateVar(fid, 'M9_GS', [num2str(M9_GS) 'um']); 
    hfssCreateVar(fid, 'M9_SS', [num2str(M9_SS) 'um']); 
    hfssCreateVar(fid, 'M9_L', [num2str(M9_L) 'um']);    
    hfssCreateVar(fid, 'GND_H', [num2str(GND_H) 'um']);    
    hfssCreateVar(fid, 'GND_F', [num2str(GND_F) 'um']);    
    hfssCreateVar(fid, 'encl', [num2str(encl) 'um']);
    hfssCreateVar(fid, 'grid', '0.005');
    hfssCreateVar(fid, 'WE', '4*$M9_W+2*$M9_GS+$M9_SS');
    hfssCreateVar(fid, 'LE', '$M9_L');
    hfssCreateVar(fid, 'WI', '$M9_W');
    hfssCreateVar(fid, 'WO', '$M9_W');        
    hfssCreateVar(fid, 'W', '$WE+$encl');
    hfssCreateVar(fid, 'L', '$LE+$encl');
    hfssCreateVar(fid, 'H', [num2str(H) 'um']);
    hfssCreateVar(fid, 'move_x', '0');
    hfssCreateVar(fid, 'move_y', [num2str(y0) 'um']);
    hfssCreateVar(fid, 'AirX', '$W+$encl');
    hfssCreateVar(fid, 'SUBS_T', [num2str(substrate) ' um'])
    hfssCreateVar(fid, 'AirY', '$L+$encl');
    hfssCreateVar(fid, 'AirZ', '$H+$encl');
    hfssCreateVar(fid, 'move_z', [num2str(z0) 'um']);
    % add a substrate    
    permittivity = 11.9;
    bsigma = 5;
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
    