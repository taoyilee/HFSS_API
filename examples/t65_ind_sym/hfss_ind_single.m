function serial = hfss_ind_single(fid,X, Y, Z, OD, S, W, lead, serial,projectname)
        hfssCreateVar(fid, 'M9_P',  strcat(W, '+', S));
        hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
        hfssCreateVar(fid, 'VIA_ENC', '($M9_W - $VIA_W)/2');        
        me9 = 'ME0d005';
        % serial = hfss_ind(fid, X, Y, Z, W, S, OD, '$NT', '$M9_T', lead, '0', serial, 'ME0d005');
        serial = hfss_xfm_half(fid,X , Y, Z, W, '0', '0', strcat(OD,'-', S), '$M9_T' , serial,me9);
        hfssSaveProject(fid, projectname, true);
        % serial = hfss_xfm_half(fid,X , Y, Z, W, '0', '0', OD, '$M9_T' , serial,me9);
        serial = hfss_xfm_half(fid,X , Y, Z, W, '0', '2*$M9_S', strcat(OD,'+', W), '$M9_T' , serial,me9);        
        hfssMirror(fid, {['L' num2str(serial-1)]}, [0 0 0], [0 -1 0], 'um')     
        hfssSaveProject(fid, projectname, true);
   
        hfssBoxN(fid, 'lead1', ...
            {strcat(OD, '+', W) ,'-$M9_W-$M9_S','$M9_Z'}, {lead, W, '$M9_T'},me9); % via 1
        hfssBoxN(fid, 'lead2', ...
            {strcat(OD, '-', S), '0','$M9_Z'}, {strcat(lead,'+$M9_P'), W, '$M9_T'},me9 ); % via 2
                   
        hfssCreateVar(fid, 'PORT_H', '$M9_T');        
        % GR
        % hfssCreateVar(fid, 'GR_W', [num2str(5) 'um']);
        % hfssRectangleN(fid, 'GR_R','z', {'$WE/2+$move_x' ,'-$LE/2','$M1_Z'}, '-$GR_W','$LE');    
        % hfssAssignPE(fid, 'PE-R', {'GR_R'}, 0);
        % port                
        % posi = {strcat(OD,'+$LEAD+$M9_W'), '-$M9_S-$M9_W','$M6_Z'};        
        % hfssRectangleN(fid, 'P1', 'x', posi , W, '$PORT_H');
        posi = {strcat(OD,'+$LEAD+$M9_W'), '-$M9_S','$M9_Z'};        
        hfssRectangleN(fid, 'P1', 'x', posi , S, '$PORT_H');
        
        hfssAssignLumpedPortDTerm(fid, 'P1', posi, '', '1');
        
        % posi2 = {strcat(OD,'+$LEAD+$M9_W'), '0','$M6_Z'};
        % hfssRectangleN(fid, 'P2', 'x', posi2 , W, '$PORT_H');
        % hfssAssignLumpedPortDTerm(fid, 'P2', posi2, '', '2');
        
        hfssDeleteBoundaries(fid, 'lead2_T1');       
        hfssSubtract(fid, {'IMD_9aEQ','IMD_9bEQ','IMD_9cEQ'}, {'L0','L1','lead1','lead2'},1);
        % hfssSubtract(fid, {'IMD_9a','IMD_9b'}, {'L0','L1','lead1','lead2'},1);
        % hfssHeal(fid, {'L0'});        