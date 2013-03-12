function serial = hfss_indn(fid,X, Y, Z, OD, S, NT, W, lead, serial)
        hfssCreateVar(fid, 'M9_P',  strcat(W, '+', S));
        hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
        hfssCreateVar(fid, 'VIA_ENC', '($M9_W - $VIA_W)/2');        
        me9 = 'ME0d005';
        me8 = 'ME0d022';
        if(NT>1)                  
            serial = hfss_ind_sheet(fid, X, Y, Z, W, S, OD,'$M9_T', '$NT', lead, '0', serial, me9);
            hfssBoxN(fid, 'under_1', ...
                        {strcat(OD, '-', W, '-($NT-1)*$M9_P'), S ,'$M8_Z'}, {strcat('$NT*$M9_P+', W), W, '$M8_T'},me8); % under pass
            hfssBoxN(fid, 'via_1', ...
                        {strcat(OD, '-', W, '-($NT-1)*$M9_P'), S,'$VIA10_Z'}, {W, W, '$VIA10_T'},me8); % via 1
            hfssBoxN(fid, 'via_2', ...
                       {strcat(OD, '+', S), S,'$VIA10_Z'}, {W, W, '$VIA10_T'},me8); % via 2
            hfssSubtract(fid, {'IMD_9a'},  {'via_1', 'via_2'},1);    
            hfssSubtract(fid, {'IMD_8gEQ'},  {'via_1', 'via_2'},1);                        
        else % if NT = 1, single turn
            serial = hfss_ind_sheet(fid, X, Y, Z, W, S, OD,'$M9_T', '$NT', lead, '0', serial, me9);           
        end        
        
        % port        
        posi = {strcat(OD,'+$LEAD+$M9_P'),strcat('-',W),'$M6_Z+$M6_T'};
        hfssRectangleN(fid, 'P1', 'x', posi , strcat(S,'+2*',W), '$M9_Z-$M6_Z-$M6_T');
        hfssAssignLumpedPortDTerm(fid, 'P1', posi, '', '1');
        hfssDeleteBoundaries(fid, 'L0_T1');       
        % hfssSubtract(fid, {'IMD_9a','IMD_9b','IMD_9c'}, {'L0'},1);