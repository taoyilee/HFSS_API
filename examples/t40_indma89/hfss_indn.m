function serial = hfss_indn(fid,X, Y, Z,  OD, S, NT, W, lead, serial)
        hfssCreateVar(fid, 'M11_P',  strcat(W, '+', S));
        hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
        hfssCreateVar(fid, 'VIA_ENC', '($M9_W - $VIA_W)/2');        
        if(NT>1)       
            serial = hfss_ind_open(fid, X, Y, Z, W, S, OD, '$NT', '$M11_T', lead, '0', serial, 'T40_ME0d021');
            serial = hfss_ind_open2(fid, '$VIA_ENC', Y, '$VIA9_Z', '$VIA_W', '$M9_S+2*$VIA_ENC', strcat(OD, '-2*$VIA_ENC'), '$NT', '$VIA9_T', strcat(lead, '+2*$VIA_ENC'), '$VIA_ENC', serial, 'T40_ME0d022');
            % underpass 1
            % hfssBoxN(fid, 'under_1', {strcat(OD, '-($NT-1)*$M11_P'),S,'$M11_Z'}, {strcat('$NT*$M11_P-', W), W, '$M11_T'},'T40_ME0d021' );
        else
            serial = hfss_ind(fid, X, Y, Z, W, S, OD, '$NT', '$M11_T', lead, '0', serial, 'T40_ME0d021');
            serial = hfss_ind(fid, '$VIA_ENC', Y, '$VIA9_Z', '$VIA_W', '$M9_S+2*$VIA_ENC', strcat(OD, '-2*$VIA_ENC'), '$NT', '$VIA9_T', strcat(lead, '+2*$VIA_ENC'), '$VIA_ENC', serial, 'T40_ME0d022');
        end        
        serial = hfss_ind(fid, X, Y, '$M9_Z', '$M9_W', '$M9_S', OD, '$NT', '$M9_T', lead, '0', serial, 'T40_ME0d022');
        serial = hfss_ind(fid, X, Y, '$M8_Z', '$M9_W', '$M9_S', OD, '$NT', '$M8_T', lead, '0', serial, 'T40_ME0d022');
        % inductor_in = strcat('L', num2str(serial-1));
        % vias        
        serial = hfss_ind(fid, '$VIA_ENC', Y, '$VIA8_Z', '$VIA_W', '$M9_S+2*$VIA_ENC', strcat(OD, '-2*$VIA_ENC'), '$NT', '$VIA8_T', strcat(lead, '+2*$VIA_ENC'), '$VIA_ENC', serial, 'T40_ME0d022');
        % end vias
        hfssCreateVar(fid, 'PORT_H', '$M11_Z-$M8_Z + $M11_T');
        hfssBoxN(fid, 'plus', {strcat(OD,'+$LEAD+$M11_P'), S, '$M8_Z'}, {'40nm', '$M11_W', '$PORT_H'},'T40_ME0d022' );
        hfssBoxN(fid, 'minus', {strcat(OD,'+$LEAD+$M11_P'),num2str(0), '$M8_Z'}, {'40nm', '-$M11_W', '$PORT_H'},'T40_ME0d022' );
        
        % port        
        posi = {strcat(OD,'+$LEAD+$M11_P+40nm'),'0','$M8_Z'};
        hfssRectangleN(fid, 'P1', 'x', posi , S, '$PORT_H');
        hfssAssignLumpedPortDTerm(fid, 'P1', posi, '', '1');
        hfssDeleteBoundaries(fid, 'minus_T1');       
        hfssSubtract(fid, {'IMD_8a', 'IMD_8b','IMD_8c','IMD_8d','IMD_9a', 'IMD_9b','IMD_9c', 'PASS1', 'PASS2', 'PASS3', 'PASS4'}, ...
        {'L0', 'L1', 'L2', 'L3', 'L4', 'plus','minus'},1);
        hfssHeal(fid, {'IMD_8a','IMD_8b','IMD_8c','IMD_8d','IMD_9a', ...
                'IMD_9b','IMD_9c','PASS1','PASS2','PASS3','PASS4','L0','L1','L2','L3','L4','plus','minus','P1'});