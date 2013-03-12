function serial = hfss_cpwn(fid, M9_W, M9_GS,M9_SS, M9_L,GND_H,GND_F, serial)
      
        hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
        hfssCreateVar(fid, 'VIA_ENC', '($M9_W - $VIA_W)/2');                         
        me9 = 'ME0d005';
        me6 = 'ME0d1399';
        serial = hfss_gndvd(fid, '-$M9_GS-$M9_SS/2-$M9_W', strcat('-',M9_L,'/2') ,'$M6_Z', '2*$M9_GS+$M9_SS+2*$M9_W', '$M9_L',GND_H, GND_F, '$M6_T', serial, me6); % gnd mesh        
        serial = hfss_lead(fid, strcat('-', M9_GS,'-', M9_SS,'/2-2*',M9_W),strcat('-',M9_L,'/2') , '$M6_Z' , M9_W, M9_L, '$M6_T','$VIA_W','$M9_Z-$M6_Z-$M6_T', serial,me6);
        serial = hfss_lead(fid, strcat(M9_GS,'+',M9_SS,'/2+',M9_W),strcat('-',M9_L,'/2') , '$M6_Z' , M9_W, M9_L, '$M6_T','$VIA_W','$M9_Z-$M6_Z-$M6_T', serial,me6);
        
        hfssBoxN(fid, 'SP', {strcat('-', M9_SS,'/2'), strcat('-', M9_L,'/2'),'$M9_Z'}, {strcat('-',M9_W), M9_L, '$M9_T'},me9 );
        hfssBoxN(fid, 'SN', {strcat(M9_SS,'/2' ), strcat('-', M9_L,'/2'),'$M9_Z'}, {M9_W, M9_L, '$M9_T'},me9);
        
        hfssBoxN(fid, 'GN', {strcat('-', M9_W,'-', M9_GS, '-', M9_SS,'/2'), strcat('-', M9_L,'/2'),'$M9_Z'}, {strcat('-',M9_W), M9_L, '$M9_T'},me9 );
        hfssBoxN(fid, 'GP', {strcat(M9_W, '+', M9_GS, '+', M9_SS,'/2'), strcat('-', M9_L,'/2'),'$M9_Z'}, {M9_W, M9_L, '$M9_T'},me9 );        
        hfssCreateVar(fid, 'PORT_H', '$M9_Z-$M6_Z-$M6_T');
        % port        
        posip = {strcat( M9_SS,'/2'), strcat('-', M9_L,'/2'),'$M6_Z+$M6_T'};
        posin = {strcat('-',M9_SS,'/2'), strcat('-', M9_L,'/2'),'$M6_Z+$M6_T'};
        posop = {strcat(M9_SS,'/2'), strcat(M9_L,'/2'),'$M6_Z+$M6_T'};
        poson = {strcat('-',M9_SS,'/2'), strcat(M9_L,'/2'),'$M6_Z+$M6_T'};
        
        hfssRectangleN(fid, 'P1p', 'y', posip , '$PORT_H',M9_W);
        hfssRectangleN(fid, 'P1n', 'y', posin , '$PORT_H',strcat('-',M9_W));
        hfssRectangleN(fid, 'P2p', 'y', posop , '$PORT_H',M9_W);
        hfssRectangleN(fid, 'P2n', 'y', poson , '$PORT_H',strcat('-',M9_W));
        hfssAssignLumpedPortDTerm(fid, 'P1p', posip, '', '1');
        hfssAssignLumpedPortDTerm(fid, 'P1n', posin, '', '2');
        hfssAssignLumpedPortDTerm(fid, 'P2p', posop, '', '3');
        hfssAssignLumpedPortDTerm(fid, 'P2n', poson, '', '4');        
        hfssDeleteBoundaries(fid, 'L0_T1');
        hfssDeleteBoundaries(fid, 'L0_T2');
        hfssDeleteBoundaries(fid, 'L0_T3');
        hfssDeleteBoundaries(fid, 'L0_T4');
        hfssSubtract(fid, {'IMD_8gEQ','IMD_9a'}, {'lead1','lead2'},1);
        hfssSubtract(fid, {'IMD_9a','IMD_9b','IMD_9c'}, {'SN','SP','GN','GP'},1);