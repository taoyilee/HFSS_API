function serial = hfss_hud_cross(fid,X, Y, Z, OD, S, OPEN, W,Thickness, serial)    
    me9 = 'ME0d005';    
    % hfss_xfm_halfudN(fid,X , Y, Z, W, R_OP,L_OP, OD,Thickness, serial,material)
    serial = hfss_xfm_halfudN(fid,X , Y, Z, W, ['2*' W '+' S], OPEN, OD, Thickness,serial,me9);
    % hfssSubtract(fid, {'IMD_9aEQ','IMD_9bEQ','IMD_9cEQ'}, {'lead1', 'lead2'},1);
    % hfssHeal(fid, {'IMD_9a','IMD_9b','IMD_9c','PASS1EQ','L0','P1'});