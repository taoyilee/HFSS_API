function serial = hfss_xfmmam9N(fid,X , Y, Z, Z2, WI, WO, S, R_OP,L_OP, OD,Thickness1, Thickness2, VIAH,serial)
    hfssCreateVar(fid, 'PI', strcat(WI, '+', S));   
    hfssCreateVar(fid, 'PO', strcat(WO, '+', S));
    hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
    hfssCreateVar(fid, 'VIA_ENC', strcat('(', WI, '-$VIA_W)/2'));
    serial = hfss_xfm_halfudN(fid,X , Y, Z, WO, strcat(R_OP,'+2*$PO+2*', S),L_OP, OD,Thickness2,serial, 'T40_ME0d021');
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO'), Y, Z, WI, strcat(R_OP,'+2*',S), '0', strcat(OD,'-2*$PO'),Thickness2,serial, 'T40_ME0d021');
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO+$PI'), Y, Z, WO, R_OP, '0', strcat(OD, '-2*($PO+$PI)'),Thickness2,serial, 'T40_ME0d021');
    
    serial = hfss_xfm_halfudN(fid,X , Y, '$M9_Z' , WO, strcat(R_OP,'+2*$PO+2*', S) ,L_OP, OD,'$M9_T',serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO'), Y, '$M9_Z', WI, strcat(R_OP,'+2*',S), '0', strcat(OD,'-2*$PO'),'$M9_T', serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO+$PI'), Y, '$M9_Z', WO, R_OP, '0', strcat(OD, '-2*($PO+$PI)'),'$M9_T',serial, 'T40_ME0d022');
    
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$VIA_ENC') , Y, '$VIA9_Z' , '$VIA_W', strcat(R_OP,'+2*$PO+2*', S) ,L_OP, strcat(OD, '-2*$VIA_ENC'),VIAH,serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO+$VIA_ENC'), Y, '$VIA9_Z', '$VIA_W', strcat(R_OP,'+2*',S), '0', strcat(OD,'-2*$PO-2*$VIA_ENC'),VIAH, serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO+$PI+$VIA_ENC'), Y, '$VIA9_Z', '$VIA_W' , R_OP, '0', strcat(OD, '-2*($PO+$PI)-2*$VIA_ENC'),VIAH,serial, 'T40_ME0d022');
    
    serial = hfss_xfm_cross_viaN(fid,X , Y, Z, WO, strcat('2*', S, '+', WI), R_OP, Thickness2, '-$VIA9_T-$M11_T-$M9_T',serial,'T40_ME0d021'); % under pass
    hfssMirror(fid, {['C' num2str(serial-1)]}, [0 0 0], [0 -1 0], '')
    serial = hfss_xfm_cross_viaN(fid,X , Y, Z2, WO, strcat('2*', S,'+', WI), R_OP, Thickness1, '0', serial,'T40_ME0d022'); % under pass
    hfssBoxN(fid, 'gap1', {'0',strcat('-', R_OP, '/2'),'$M9_Z'}, {'$WI',strcat('-$PO-',S),'$M9_T'}, 'T40_ME0d022');
    hfssBoxN(fid, 'gap2', {'0',strcat(R_OP, '/2'),'$M9_Z'}, {'$WI',strcat('$PO+',S),'$M9_T'},'T40_ME0d022');
    serial = serial + 1;
    
    % leads 
    % lead 1
    hfssBoxN(fid, 'under_1', {strcat('-', S, '-$lead'),strcat(R_OP, '/2+', S),'$M11_Z'}, {'$M11_S+$PO+$lead',WI,'$M11_T'},'T40_ME0d021');
    % lead 2
    hfssBoxN(fid, 'under_2', {strcat('-', S, '-$lead'),strcat('-', R_OP, '/2-',S),'$M11_Z'}, {'$M11_S+$PO+$lead',strcat('-', WI),'$M11_T'},'T40_ME0d021');
    
    serial = hfss_lead(fid,strcat('-', S),strcat(R_OP, '/2+', S),'$M9_Z', '-$LEAD',  WO, '$M9_T',WO, '$VIA9_T', serial);
    serial =  hfss_lead(fid,strcat('-', S),strcat('-',R_OP, '/2-', S),'$M9_Z', '-$LEAD', strcat('-', WO), '$M9_T', WO, '$VIA9_T', serial); 
    
    serial =  hfss_lead(fid,OD,strcat(L_OP, '/2'),'$M9_Z', '$LEAD',  WI, '$M9_T', WI, '$VIA9_T', serial);
    hfssBoxN(fid, 'leadp3', {OD,strcat(L_OP, '/2'),'$M11_Z'}, {'$LEAD',WI,'$M11_T'},'T40_ME0d021');
    serial =  hfss_lead(fid,OD,strcat('-',L_OP, '/2'),'$M9_Z', '$LEAD', strcat('-', WI), '$M9_T', WI, '$VIA9_T', serial);
    hfssBoxN(fid, 'leadp4', {OD,strcat('-', L_OP, '/2'),'$M11_Z'}, {'$LEAD',strcat('-', WI),'$M11_T'},'T40_ME0d021');

    % Guardring
    hfssCreateVar(fid, 'GR_W', [num2str(8) 'um']);
    hfssBoxN(fid, 'GR_L', {'-$WE/2+$move_x' ,'-$LE/2','$M6_Z'}, {'$GR_W','$LE','$M6_T'},'T40_ME0d289');
    hfssBoxN(fid, 'GR_R', {'$WE/2+$move_x' ,'-$LE/2','$M6_Z'}, {'-$GR_W','$LE','$M6_T'},'T40_ME0d289');
    
    hfssBoxN(fid, 'GR_T', {'-$WE/2+$move_x+$GR_W' ,'-$LE/2','$M6_Z'}, {'$WE-2*$GR_W','$GR_W','$M6_T'},'T40_ME0d289');
    hfssBoxN(fid, 'GR_D', {'-$WE/2+$move_x+$GR_W' ,'$LE/2','$M6_Z'}, {'$WE-2*$GR_W','-$GR_W','$M6_T'},'T40_ME0d289');

    
    % ports
    hfssCreateVar(fid, 'PORT_H', '$M9_Z-$M6_Z-$M6_T');
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
    
    % substract
    hfssSubtract(fid, 'IMD_9a', 'L3',1)
    hfssSubtract(fid, 'IMD_9a', 'L3_1',1)
    hfssSubtract(fid, 'IMD_9a', 'L4',1)
    hfssSubtract(fid, 'IMD_9a', 'L4_1',1)
    hfssSubtract(fid, 'IMD_9a', 'L5',1)
    hfssSubtract(fid, 'IMD_9a', 'L5_1',1)
    hfssSubtract(fid, 'IMD_9a', 'C9',1)
    hfssSubtract(fid, 'IMD_9a', 'C10',1)
    hfssSubtract(fid, 'IMD_9a', 'gap1',1)
    hfssSubtract(fid, 'IMD_9a', 'gap2',1)
    hfssSubtract(fid, 'IMD_9a', 'lead12',1)
    hfssSubtract(fid, 'IMD_9a', 'lead13',1)
    hfssSubtract(fid, 'IMD_9a', 'lead14',1)
    hfssSubtract(fid, 'IMD_9a', 'lead15',1)
    
	hfssSubtract(fid, 'IMD_9b', 'L3',1)
    hfssSubtract(fid, 'IMD_9b', 'L3_1',1)
    hfssSubtract(fid, 'IMD_9b', 'L4',1)
    hfssSubtract(fid, 'IMD_9b', 'L4_1',1)
    hfssSubtract(fid, 'IMD_9b', 'L5',1)
    hfssSubtract(fid, 'IMD_9b', 'L5_1',1)
    hfssSubtract(fid, 'IMD_9b', 'C9',1)
    hfssSubtract(fid, 'IMD_9b', 'C10',1)
    hfssSubtract(fid, 'IMD_9b', 'gap1',1)
    hfssSubtract(fid, 'IMD_9b', 'gap2',1)
    hfssSubtract(fid, 'IMD_9b', 'lead12',1)
    hfssSubtract(fid, 'IMD_9b', 'lead13',1)
    hfssSubtract(fid, 'IMD_9b', 'lead14',1)
    hfssSubtract(fid, 'IMD_9b', 'lead15',1)

	hfssSubtract(fid, 'IMD_9c', 'L3',1)
    hfssSubtract(fid, 'IMD_9c', 'L3_1',1)
    hfssSubtract(fid, 'IMD_9c', 'L4',1)
    hfssSubtract(fid, 'IMD_9c', 'L4_1',1)
    hfssSubtract(fid, 'IMD_9c', 'L5',1)
    hfssSubtract(fid, 'IMD_9c', 'L5_1',1)
    hfssSubtract(fid, 'IMD_9c', 'C9',1)
    hfssSubtract(fid, 'IMD_9c', 'C10',1)
    hfssSubtract(fid, 'IMD_9c', 'gap1',1)
    hfssSubtract(fid, 'IMD_9c', 'gap2',1)
    hfssSubtract(fid, 'IMD_9c', 'lead12',1)
    hfssSubtract(fid, 'IMD_9c', 'lead13',1)
    hfssSubtract(fid, 'IMD_9c', 'lead14',1)
    hfssSubtract(fid, 'IMD_9c', 'lead15',1)

    hfssSubtract(fid, 'PASS1', 'L6',1)
    hfssSubtract(fid, 'PASS1', 'L6_1',1)
    hfssSubtract(fid, 'PASS1', 'L7',1)
    hfssSubtract(fid, 'PASS1', 'L7_1',1)
    hfssSubtract(fid, 'PASS1', 'L8',1)
    hfssSubtract(fid, 'PASS1', 'L8_1',1)    
    hfssSubtract(fid, 'PASS1', 'C9',1)
    hfssSubtract(fid, 'PASS1', 'lead12',1)    
    hfssSubtract(fid, 'PASS1', 'lead13',1)        
    hfssSubtract(fid, 'PASS1', 'lead14',1)    
    hfssSubtract(fid, 'PASS1', 'lead15',1)    
    
	hfssSubtract(fid, 'PASS2', 'L6',1)
    hfssSubtract(fid, 'PASS2', 'L6_1',1)
    hfssSubtract(fid, 'PASS2', 'L7',1)
    hfssSubtract(fid, 'PASS2', 'L7_1',1)
    hfssSubtract(fid, 'PASS2', 'L8',1)
    hfssSubtract(fid, 'PASS2', 'L8_1',1)    
    hfssSubtract(fid, 'PASS2', 'C9',1)
    hfssSubtract(fid, 'PASS2', 'lead12',1)    
    hfssSubtract(fid, 'PASS2', 'lead13',1)        
    hfssSubtract(fid, 'PASS2', 'lead14',1)    
    hfssSubtract(fid, 'PASS2', 'lead15',1)    
    
	hfssSubtract(fid, 'PASS3', 'L0',1)
    hfssSubtract(fid, 'PASS3', 'L0_1',1)
    hfssSubtract(fid, 'PASS3', 'L1',1)
    hfssSubtract(fid, 'PASS3', 'L1_1',1)
    hfssSubtract(fid, 'PASS3', 'L2',1)
    hfssSubtract(fid, 'PASS3', 'L2_1',1)    
    hfssSubtract(fid, 'PASS3', 'C9',1)
    hfssSubtract(fid, 'PASS3', 'under_1',1)    
    hfssSubtract(fid, 'PASS3', 'under_2',1)        
    hfssSubtract(fid, 'PASS3', 'leadp3',1)    
    hfssSubtract(fid, 'PASS3', 'leadp4',1)  
        
	hfssSubtract(fid, 'PASS4', 'L0',1)
    hfssSubtract(fid, 'PASS4', 'L0_1',1)
    hfssSubtract(fid, 'PASS4', 'L1',1)
    hfssSubtract(fid, 'PASS4', 'L1_1',1)
    hfssSubtract(fid, 'PASS4', 'L2',1)
    hfssSubtract(fid, 'PASS4', 'L2_1',1)    
    hfssSubtract(fid, 'PASS4', 'C9',1)
    hfssSubtract(fid, 'PASS4', 'under_1',1)    
    hfssSubtract(fid, 'PASS4', 'under_2',1)        
    hfssSubtract(fid, 'PASS4', 'leadp3',1)    
    hfssSubtract(fid, 'PASS4', 'leadp4',1) 