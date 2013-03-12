function subs = hfss_substrate(fid, mode, thickness, permittivity, bsigma, material_name)
        % permittivity = 11.9;
        % bsigma = 1;
        % material_name = 'SUBSTRATE';
        hfssAddMaterial(fid, material_name, permittivity,bsigma,0);    
        subsc = 'SUBS_T';
        hfssCreateVar(fid, subsc , [num2str(thickness) ' um'])
    if(mode==1)     % simplified substrate mode
        hfssRectangleN(fid, 'Substrate', 'z', {'-$W/2+$move_x','-$L/2+$move_y','$move_z'} ,'$W','$L');            
        hfssAssignFiniteCond(fid, 'FCsubstrate','Substrate' , material_name, '$SUBS_T',0 );    
        hfssCreateVar(fid, 'AirX', '$W');    
        hfssCreateVar(fid, 'AirY', '$L');
        hfssCreateVar(fid, 'AirZ', '$H');
        subs = '0';
    else            % solid substrate mode 
        hfssBoxN(fid, 'Substrate', {'-$W/2+$move_x','-$L/2+$move_y','$move_z'}, ...
        {'$W','$L','-$SUBS_T'},'SUBSTRATE');
        hfssWireFrame(fid, 'Substrate');
        hfssCreateVar(fid, 'AirX', '$W+$encl');    
        hfssCreateVar(fid, 'AirY', '$L+$encl');
        hfssCreateVar(fid, 'AirZ', '$H+$SUBS_T');
        subs = ['$' subsc];
    end
    hfssSetColor(fid, 'Substrate', [0 0 255]);          