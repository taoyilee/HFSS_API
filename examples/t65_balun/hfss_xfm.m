function serial = hfss_xfm(fid,X , Y, Z, Z2, WI, WO, S, R_OP,L_OP, OD,Thickness,serial)
    PI = WI + S;
    PO = WO + S;
    serial = hfss_xfm_halfud(fid,X , Y, Z, WO, R_OP,L_OP, OD,Thickness,serial);
    serial = hfss_xfm_halfud(fid,X+PO, Y, Z, WI, R_OP,0, OD-2*PO,Thickness,serial);
    serial = hfss_xfm_halfud(fid,X+PO+PI, Y, Z, WO, R_OP,0, OD-2*(PO+PI),Thickness,serial);
    
    serial = hfss_xfm_cross(fid,X , Y, Z, WO, 2*S+WI, R_OP, Thickness, serial); % under pass
    hfssMirror(fid, {['C' num2str(serial-1)]}, [0 0 0], [0 -1 0], '')
    serial = hfss_xfm_cross_via(fid,X , Y, Z2, WO, 2*S+WI, R_OP, Thickness, Thickness, serial); % under pass
    serial = serial + 1;
