function serial = hfss_indn(fid,X, Y, Z, OD, S, NT, W, lead, serial)
        hfssCreateVar(fid, 'M9_P',  strcat(W, '+', S));
        hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
        hfssCreateVar(fid, 'VIA_ENC', '($M9_W - $VIA_W)/2');        
        if(NT>1)       
            % serial = hfss_ind_open(fid, X, Y, Z, W, S, OD, '$NT', '$M9_T', lead, '0', serial, 'ME0d005');
            serial = hfss_ind(fid, X, Y, Z, W, S, OD, '$NT', '$M9_T', lead, '0', serial, 'ME0d005');
            % serial = hfss_ind_open2(fid, '$VIA_ENC', Y, '$VIA9_Z', '$VIA_W', '$M9_S+2*$VIA_ENC', strcat(OD, '-2*$VIA_ENC'), '$NT', '$VIA9_T', strcat(lead, '+2*$VIA_ENC'), '$VIA_ENC', serial, 'ME0d00577');
            % underpass 1
            for i=0:NT-2
                istr =   num2str(i);
                hfssBoxN(fid, strcat('under_1_', istr), ...
                        {strcat(OD, '-', W, '-',istr, '*$M9_P'), strcat('-', W),'$M8_Z'}, {W, strcat('2*$M9_P+', W), '$M8_T'},'ME0d0218' ); % under pass
                hfssBoxN(fid, strcat('via_1_',istr), ...
                        {strcat(OD, '-', W, '-',istr, '*$M9_P'), strcat('-', W),'$VIA10_Z'}, {W, W, '$VIA10_T'},'ME0d0218' ); % via 1
                hfssBoxN(fid, strcat('via_2_', istr), ...
                        {strcat(OD, '-', W, '-',istr, '*$M9_P'), '$M9_P+$M9_S','$VIA10_Z'}, {W, W, '$VIA10_T'},'ME0d0218' ); % via 2
                hfssSubtract(fid, {'IMD_9a'},  {strcat('under_1_', istr), strcat('via_1_',istr), strcat('via_2_', istr)},1);    
                hfssSubtract(fid, {'IMD_8gEQ'},  {strcat('via_1_',istr), strcat('via_2_', istr)},1);    
            end                     
        else % if NT = 1, single turn
            serial = hfss_ind(fid, X, Y, Z, W, S, OD, '$NT', '$M9_T', lead, '0', serial, 'ME0d005');           
        end        
        hfssCreateVar(fid, 'PORT_H', '$M9_T');
        % port        
        posi = {strcat(OD,'+$LEAD+$M9_P'),'0','$M9_Z'};
        hfssRectangleN(fid, 'P1', 'x', posi , S, '$PORT_H');
        hfssAssignLumpedPortDTerm(fid, 'P1', posi, '', '1');
        hfssDeleteBoundaries(fid, 'L0_T1');       
        hfssSubtract(fid, {'IMD_9a','IMD_9b','IMD_9c'}, {'L0'},1);
        hfssHeal(fid, {'IMD_9a','IMD_9b','IMD_9c','PASS1','L0','P1'});