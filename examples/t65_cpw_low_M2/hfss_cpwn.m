function serial = hfss_cpwn(fid, M9_W, M9_S, M9_L,GND_H,GND_F, serial)
        hfssCreateVar(fid, 'M9_P',  strcat(M9_W, '+', M9_S));
        hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
        hfssCreateVar(fid, 'VIA_ENC', '($M9_W - $VIA_W)/2');                         
        serial = hfss_gndvd(fid, '-$M9_S-0.5*$M9_W', strcat('-',M9_L,'/2') ,'$M2_Z', '2*$M9_S+$M9_W', '$M9_L',GND_H, GND_F, '$M2_T', serial, 'ME0d1399'); % gnd mesh        
        serial = hfss_lead(fid, strcat('-', M9_S,'-1.5*',M9_W),strcat('-',M9_L,'/2') , '$M2_Z' , M9_W, M9_L, '$M2_T','$VIA_W','$M9_Z-$M2_Z-$M2_T', serial,'ME0d1399');
        serial = hfss_lead(fid, strcat(M9_S,'+0.5*',M9_W),strcat('-',M9_L,'/2') , '$M2_Z' , M9_W, M9_L, '$M2_T','$VIA_W','$M9_Z-$M2_Z-$M2_T', serial,'ME0d1399');
        hfssBoxN(fid, 'S', {strcat('-', M9_W,'/2'), strcat('-', M9_L,'/2'),'$M9_Z'}, {M9_W, M9_L, '$M9_T'},'ME0d005' );
        hfssBoxN(fid, 'GN', {strcat('-1.5*', M9_W,'-', M9_S), strcat('-', M9_L,'/2'),'$M9_Z'}, {M9_W, M9_L, '$M9_T'},'ME0d005' );
        hfssBoxN(fid, 'GP', {strcat(M9_W,'/2+',M9_S), strcat('-', M9_L,'/2'),'$M9_Z'}, {M9_W, M9_L, '$M9_T'},'ME0d005' );        
        hfssCreateVar(fid, 'PORT_H', '$M9_Z-$M2_Z-$M2_T');
        % port        
        posi = {strcat('-', M9_W,'/2'), strcat('-', M9_L,'/2'),'$M2_Z+$M2_T'};
        poso = {strcat('-', M9_W,'/2'), strcat(M9_L,'/2'),'$M2_Z+$M2_T'};
        hfssRectangleN(fid, 'P1', 'y', posi , '$PORT_H',M9_W);
        hfssRectangleN(fid, 'P2', 'y', poso , '$PORT_H',M9_W);
        hfssAssignLumpedPortDTerm(fid, 'P1', posi, '', '1');
        hfssAssignLumpedPortDTerm(fid, 'P2', poso, '', '2');
        hfssDeleteBoundaries(fid, 'L0_T1');
        hfssDeleteBoundaries(fid, 'L0_T2');
        hfssSubtract(fid, {'IMD_8gEQ','IMD_9a'}, {'lead1','lead2'},1);
        hfssSubtract(fid, {'IMD_9a','IMD_9b','IMD_9c'}, {'S','GN','GP'},1);
        % hfssHeal(fid, {'IMD_9a','IMD_9b','IMD_9c','PASS1EQ','L0','P1'});