function serial = hfss_cpwn(fid, M9_W, M9_S, M9_L,GND_H,GND_F, serial)
        hfssCreateVar(fid, 'M9_P',  strcat(M9_W, '+', M9_S));
        hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
        hfssCreateVar(fid, 'VIA_ENC', '($M9_W - $VIA_W)/2');                         
        serial = hfss_gndvd_THz_V(fid, '-5*$M9_W', strcat('-',M9_L,'/2') ,'$M1_Z', '10*$M9_W', '$M9_L',GND_H, GND_F, '$M1_T', serial, 'ME0d16'); % gnd mesh
        hfssBoxN(fid, 'S', {strcat('-', M9_W,'/2'), strcat('-', M9_L,'/2'),'$M9_Z'}, {M9_W, M9_L, '$M9_T'},'ME0d005' );        
        hfssCreateVar(fid, 'PORT_H', '$M9_Z-$M1_Z-$M1_T');
        % port        
        posi = {strcat('-', M9_W,'/2'), strcat('-', M9_L,'/2'),'$M1_Z+$M1_T'};
        poso = {strcat('-', M9_W,'/2'), strcat(M9_L,'/2'),'$M1_Z+$M1_T'};
        hfssRectangleN(fid, 'P1', 'y', posi , '$PORT_H',M9_W);
        hfssRectangleN(fid, 'P2', 'y', poso , '$PORT_H',M9_W);
        hfssAssignLumpedPortDTerm(fid, 'P1', posi, '', '1');
        hfssAssignLumpedPortDTerm(fid, 'P2', poso, '', '2');
        hfssDeleteBoundaries(fid, 'L0_T1');
        hfssDeleteBoundaries(fid, 'L0_T2');

        hfssSubtract(fid, {'IMD_9a','IMD_9b','IMD_9c'}, {'S'},1);
        % hfssHeal(fid, {'IMD_9a','IMD_9b','IMD_9c','PASS1EQ','L0','P1'});