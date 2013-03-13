function serial = hfss_xfmN(fid,X , Y, Z, Z2, WI, WO, S, R_OP,L_OP, OD,Thickness1, Thickness2, VIAH,serial)
    hfssCreateVar(fid, 'PI', strcat(WI, '+', S));   
    hfssCreateVar(fid, 'PO', strcat(WO, '+', S));
    serial = hfss_xfm_halfudN(fid,X , Y, Z, WO, R_OP,L_OP, OD,Thickness2,serial);
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO'), Y, Z, WI, strcat(R_OP,'+2*',S), '0', strcat(OD,'-2*$PO'),Thickness2,serial);
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO+$PI'), Y, Z, WO, R_OP, '0', strcat(OD, '-2*($PO+$PI)'),Thickness2,serial);
    
    serial = hfss_xfm_crossN(fid,X , Y, Z, WO, strcat('2*', S, '+', WI), R_OP, Thickness2, serial); % under pass
    hfssMirror(fid, {['C' num2str(serial-1)]}, [0 0 0], [0 -1 0], '')
    serial = hfss_xfm_cross_viaN(fid,X , Y, Z2, WO, strcat('2*', S,'+', WI), R_OP, Thickness1, VIAH, serial); % under pass
    serial = serial + 1;
    
    hfssBoxN(fid, 'leadp1', {strcat('-', S),strcat(R_OP, '/2+', S),'$M11_Z'}, {'-$LEAD',WO,'$M11_T'});
    hfssAssignMaterial(fid, 'leadp1','T40_ME0d021',0 );
    hfssBoxN(fid, 'leadp2', {strcat('-', S),strcat('-', R_OP, '/2-', S),'$M11_Z'}, {'-$LEAD',strcat('-', WO),'$M11_T'});
    hfssAssignMaterial(fid, 'leadp2','T40_ME0d021',0);
    
    hfssBoxN(fid, 'leadp3', {OD,strcat(L_OP, '/2'),'$M11_Z'}, {'$LEAD',WI,'$M11_T'});
    hfssAssignMaterial(fid, 'leadp3','T40_ME0d021',0);
    hfssBoxN(fid, 'leadp4', {OD,strcat('-', L_OP, '/2'),'$M11_Z'}, {'$LEAD',strcat('-', WI),'$M11_T'});
    hfssAssignMaterial(fid, 'leadp4','T40_ME0d021',0);
    
    % Guardring
    hfssCreateVar(fid, 'GR_W', [num2str(8) 'um']);
    hfssBoxN(fid, 'GR_L', {'-$WE/2+$move_x' ,'-$LE/2','$M6_Z'}, {'$GR_W','$LE','$M6_T'});
    hfssAssignMaterial(fid, 'GR_L','T40_ME0d022',0);
    hfssBoxN(fid, 'GR_R', {'$WE/2+$move_x' ,'-$LE/2','$M6_Z'}, {'-$GR_W','$LE','$M6_T'});
    hfssAssignMaterial(fid, 'GR_R','T40_ME0d022',0);
    
    hfssBoxN(fid, 'GR_T', {'-$WE/2+$move_x+$GR_W' ,'-$LE/2','$M6_Z'}, {'$WE-2*$GR_W','$GR_W','$M6_T'});
    hfssAssignMaterial(fid, 'GR_T','T40_ME0d022',0);
    hfssBoxN(fid, 'GR_D', {'-$WE/2+$move_x+$GR_W' ,'$LE/2','$M6_Z'}, {'$WE-2*$GR_W','-$GR_W','$M6_T'});
    hfssAssignMaterial(fid, 'GR_D','T40_ME0d022',0);
    
    % ports
    hfssCreateVar(fid, 'PORT_H', '$M11_Z-$M6_Z-$M6_T');
    posi = {strcat('-', S,'-$LEAD'),strcat(R_OP, '/2+', S),'$M6_Z+$M6_T'};
    hfssRectangleN(fid, 'P1', 'x', posi , WO, '$PORT_H');
    hfssAssignLumpedPortDTerm(fid, 'P1', posi, 'GR_L', '1');
    
    posi = {strcat('-', S,'-$LEAD'),strcat('-', R_OP, '/2-', S),'$M6_Z+$M6_T'};
    hfssRectangleN(fid, 'P2', 'x', posi, strcat('-', WO), '$PORT_H');
    hfssAssignLumpedPortDTerm(fid, 'P2', posi, 'GR_L', '2');
    
    posi = {strcat(OD,'+$LEAD'),strcat(L_OP, '/2'),'$M6_Z+$M6_T'};
    hfssRectangleN(fid, 'P3', 'x',posi , WI, '$PORT_H');
    hfssAssignLumpedPortDTerm(fid, 'P3', posi, 'GR_R', '3');
    
    posi =  {strcat(OD,'+$LEAD'),strcat('-', L_OP, '/2'),'$M6_Z+$M6_T'};
    hfssRectangleN(fid, 'P4', 'x', posi, strcat('-', WI), '$PORT_H');
    hfssAssignLumpedPortDTerm(fid, 'P4', posi, 'GR_R', '4');

    % underpass 1
    hfssBoxN(fid, 'under_1', {strcat('-', S, '-', WI),strcat(R_OP, '/2+', S),'$M9_Z'}, {'2*$PI+$WO',WI,'$M9_T'});
    hfssAssignMaterial(fid, 'under_1','T40_ME0d022',0);
    % via 1 for underpass 1
    hfssBoxN(fid, 'u1_via1', {strcat('-', S, '-', WI),strcat(R_OP, '/2+',S),'$M9_Z+$M9_T'}, {'$WO',WI,'$M11_Z-($M9_Z+$M9_T)'});
    hfssAssignMaterial(fid, 'u1_via1','T40_ME0d022',0);
    % via 2 for underpass 1
    hfssBoxN(fid, 'u1_via2', {strcat(S, '+', WO),strcat(R_OP, '/2+',S),'$M9_Z+$M9_T'}, {'$WO',WI,'$M11_Z-($M9_Z+$M9_T)'});
    hfssAssignMaterial(fid, 'u1_via2','T40_ME0d022',0);
    
    % underpass 2
    hfssBoxN(fid, 'under_2', {strcat('-', S, '-', WI),strcat('-', R_OP, '/2-',S),'$M9_Z'}, {'2*$PI+$WO',strcat('-', WI),'$M9_T'});
    hfssAssignMaterial(fid, 'under_2','T40_ME0d022',0);
    % via 1 for underpass 2
    hfssBoxN(fid, 'u2_via1', {strcat('-', S, '-', WI),strcat('-', R_OP, '/2-',S),'$M9_Z+$M9_T'}, {'$WO',strcat('-', WI),'$M11_Z-($M9_Z+$M9_T)'});
    hfssAssignMaterial(fid, 'u2_via1','T40_ME0d022',0);
    % via 2 for underpass 2
    hfssBoxN(fid, 'u2_via2', {strcat(S, '+', WO),strcat('-', R_OP, '/2-',S),'$M9_Z+$M9_T'}, {'$WO',strcat('-', WI),'$M11_Z-($M9_Z+$M9_T)'});
    hfssAssignMaterial(fid, 'u2_via2','T40_ME0d022',0);
    
    % substract
    hfssSubtract(fid, 'IMD_9a', 'C4',1)
    hfssSubtract(fid, 'IMD_9a', 'under_1',1)
    hfssSubtract(fid, 'IMD_9a', 'under_2',1)
    hfssSubtract(fid, 'IMD_9b', 'C4',1)
    hfssSubtract(fid, 'IMD_9b', 'under_1',1)
    hfssSubtract(fid, 'IMD_9b', 'under_2',1)
    
    hfssSubtract(fid, 'IMD_9c', 'C4',1)
    hfssSubtract(fid, 'IMD_9c', 'under_1',1)
    hfssSubtract(fid, 'IMD_9c', 'under_2',1)
    hfssSubtract(fid, 'IMD_9d', 'C4',1)
    hfssSubtract(fid, 'IMD_9d', 'under_1',1)
    hfssSubtract(fid, 'IMD_9d', 'under_2',1)
    hfssSubtract(fid, 'IMD_10a', 'C4',1)
    hfssSubtract(fid, 'IMD_10a', 'under_1',1)
    hfssSubtract(fid, 'IMD_10a', 'under_2',1)
    hfssSubtract(fid, 'IMD_10a', 'u1_via1',1)
    hfssSubtract(fid, 'IMD_10a', 'u1_via2',1)
    hfssSubtract(fid, 'IMD_10a', 'u2_via1',1)
    hfssSubtract(fid, 'IMD_10a', 'u2_via2',1)
    
    hfssSubtract(fid, 'IMD_10b', 'C4',1)
    hfssSubtract(fid, 'IMD_10b', 'under_1',1)
    hfssSubtract(fid, 'IMD_10b', 'under_2',1)
    hfssSubtract(fid, 'IMD_10b', 'u1_via1',1)
    hfssSubtract(fid, 'IMD_10b', 'u1_via2',1)
    hfssSubtract(fid, 'IMD_10b', 'u2_via1',1)
    hfssSubtract(fid, 'IMD_10b', 'u2_via2',1)
    hfssSubtract(fid, 'IMD_10c', 'L0',1)
    hfssSubtract(fid, 'IMD_10c', 'L0_1',1)
    hfssSubtract(fid, 'IMD_10c', 'L1',1)
    hfssSubtract(fid, 'IMD_10c', 'L1_1',1)    
    hfssSubtract(fid, 'IMD_10c', 'L2',1)
    hfssSubtract(fid, 'IMD_10c', 'L2_1',1)    
    hfssSubtract(fid, 'IMD_10c', 'C3',1)
    hfssSubtract(fid, 'IMD_10c', 'C4',1)    
    hfssSubtract(fid, 'IMD_10c', 'leadp1',1)    
    hfssSubtract(fid, 'IMD_10c', 'leadp2',1)    
    hfssSubtract(fid, 'IMD_10c', 'leadp3',1)    
    hfssSubtract(fid, 'IMD_10c', 'leadp4',1)    
    hfssSubtract(fid, 'IMD_10c', 'u1_via1',1)    
    hfssSubtract(fid, 'IMD_10c', 'u1_via2',1)    
    hfssSubtract(fid, 'IMD_10c', 'u2_via1',1)    
    hfssSubtract(fid, 'IMD_10c', 'u2_via2',1)    
    
    hfssSubtract(fid, 'PASS1', 'L0',1)
    hfssSubtract(fid, 'PASS1', 'L0_1',1)
    hfssSubtract(fid, 'PASS1', 'L1',1)
    hfssSubtract(fid, 'PASS1', 'L1_1',1)    
    hfssSubtract(fid, 'PASS1', 'L2',1)
    hfssSubtract(fid, 'PASS1', 'L2_1',1)  
    hfssSubtract(fid, 'PASS1', 'leadp1',1)    
    hfssSubtract(fid, 'PASS1', 'leadp2',1)    
    hfssSubtract(fid, 'PASS1', 'leadp3',1)    
    hfssSubtract(fid, 'PASS1', 'leadp4',1)    
    hfssSubtract(fid, 'PASS1', 'C3',1)
    hfssSubtract(fid, 'PASS1', 'C4',1)
    
    hfssSubtract(fid, 'PASS2', 'L0',1)
    hfssSubtract(fid, 'PASS2', 'L0_1',1)
    hfssSubtract(fid, 'PASS2', 'L1',1)
    hfssSubtract(fid, 'PASS2', 'L1_1',1)    
    hfssSubtract(fid, 'PASS2', 'L2',1)
    hfssSubtract(fid, 'PASS2', 'L2_1',1)  
    hfssSubtract(fid, 'PASS2', 'leadp1',1)    
    hfssSubtract(fid, 'PASS2', 'leadp2',1)    
    hfssSubtract(fid, 'PASS2', 'leadp3',1)    
    hfssSubtract(fid, 'PASS2', 'leadp4',1)   
    hfssSubtract(fid, 'PASS2', 'C3',1)
    hfssSubtract(fid, 'PASS2', 'C4',1)
    
    hfssSubtract(fid, 'PASS3', 'L0',1)
    hfssSubtract(fid, 'PASS3', 'L0_1',1)
    hfssSubtract(fid, 'PASS3', 'L1',1)
    hfssSubtract(fid, 'PASS3', 'L1_1',1)    
    hfssSubtract(fid, 'PASS3', 'L2',1)
    hfssSubtract(fid, 'PASS3', 'L2_1',1)  
    hfssSubtract(fid, 'PASS3', 'leadp1',1)    
    hfssSubtract(fid, 'PASS3', 'leadp2',1)    
    hfssSubtract(fid, 'PASS3', 'leadp3',1)    
    hfssSubtract(fid, 'PASS3', 'leadp4',1)   
    hfssSubtract(fid, 'PASS3', 'C3',1)
    hfssSubtract(fid, 'PASS3', 'C4',1)
    