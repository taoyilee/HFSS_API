function serial = hfss_ind_sym(fid,X, Y, Z, OD, S, OPEN, W, lead, serial)    
    me9 = 'ME0d005';
    serial = hfss_xfm_halfudN(fid,X , Y, Z, W, ['2*' W '+' S], OPEN, OD, Thickness,serial,me9);    
    serial = hfss_xfm_halfudN(fid,[X '+$M9_P'] , Y, Z, W, ['2*' W '+' S], OPEN, [OD '-2*$M9_P'], Thickness,serial,me9);        
    % port                
    hfssBoxN(fid, 'lead1', {'$OD+$M9_P', ['-' W],'$M9_Z'}, {'$lead', W, '$M9_T'}, me9);    
    hfssBoxN(fid, 'lead2', {'$LEAD_X', S,'$M9_Z'}, {'$LEAD_L', W, '$M9_T'}, me9);    
    
    posi = {strcat(OD,'+$LEAD+$M9_P'),'0','$M9_Z'};    
    hfssRectangleN(fid, 'P1', 'x', posi , S, '$PORT_H');
    hfssAssignLumpedPortDTerm(fid, 'P1', posi, '', '1');
    hfssDeleteBoundaries(fid, 'lead1_T1');       
    
    % hfssSubtract(fid, {'IMD_9aEQ','IMD_9bEQ','IMD_9cEQ'}, {'lead1', 'lead2'},1);
    % hfssHeal(fid, {'IMD_9a','IMD_9b','IMD_9c','PASS1EQ','L0','P1'});