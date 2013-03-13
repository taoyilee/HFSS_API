function serial = hfss_xfmmam9N(fid,X , Y, Z, Z2, WI, WO, S, R_OP,L_OP, OD,Thickness1, Thickness2, VIAH,serial)
    hfssCreateVar(fid, 'PI', strcat(WI, '+', S));   
    hfssCreateVar(fid, 'PO', strcat(WO, '+', S));
    hfssCreateVar(fid, 'PI9', '$M9_W+$M9_S');   
    hfssCreateVar(fid, 'PO9', '$M9_W+$M9_S');
    hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
    hfssCreateVar(fid, 'VIA_ENC', strcat('(', WI, '-$VIA_W)/2'));
    serial = hfss_xfm_halfudN(fid,X , Y, Z, WO, strcat(R_OP,'+2*$PO+2*', S),L_OP, OD,Thickness2,serial, 'T40_ME0d021');
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO'), Y, Z, WI, strcat(R_OP,'+2*',S), '0', strcat(OD,'-2*$PO'),Thickness2,serial, 'T40_ME0d021');
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO+$PI'), Y, Z, WO, R_OP, '0', strcat(OD, '-2*($PO+$PI)'),Thickness2,serial, 'T40_ME0d021');
    
    serial = hfss_xfm_halfudN(fid,X , Y, '$M9_Z' , '$M9_W', strcat(R_OP,'+2*$PO+2*', S) ,L_OP, OD,'$M9_T',serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO9'), Y, '$M9_Z', '$M9_W', strcat(R_OP,'+2*',S), '0', strcat(OD,'-2*$PO9'),'$M9_T', serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO9+$PI9'), Y, '$M9_Z', '$M9_W', R_OP, '0', strcat(OD, '-2*($PO9+$PI9)'),'$M9_T',serial, 'T40_ME0d022');
    
    serial = hfss_xfm_halfudN(fid,X , Y, '$M8_Z' , '$M9_W', strcat(R_OP,'+2*$PO+2*', S) ,L_OP, OD,'$M8_T',serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO9'), Y, '$M8_Z', '$M9_W', strcat(R_OP,'+2*', S), '0', strcat(OD,'-2*$PO9'),'$M8_T', serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO9+$PI9'), Y, '$M8_Z', '$M9_W', R_OP, '0', strcat(OD, '-2*($PO9+$PI9)'),'$M8_T',serial, 'T40_ME0d022');
    
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$VIA_ENC') , Y, '$VIA9_Z' , '$VIA_W', strcat(R_OP,'+2*$PO+2*', S) ,L_OP, strcat(OD, '-2*$VIA_ENC'),VIAH,serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO+$VIA_ENC'), Y, '$VIA9_Z', '$VIA_W', strcat(R_OP,'+2*',S), '0', strcat(OD,'-2*$PO9-2*$VIA_ENC'),VIAH, serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO9+$PI9+$VIA_ENC'), Y, '$VIA9_Z', '$VIA_W' , R_OP, '0', strcat(OD, '-2*($PO9+$PI9)-2*$VIA_ENC'),VIAH,serial, 'T40_ME0d022');
    
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$VIA_ENC') , Y, '$VIA8_Z' , '$VIA_W', strcat(R_OP,'+2*$PO+2*', S) ,L_OP, strcat(OD, '-2*$VIA_ENC'),'$VIA8_T',serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO9+$VIA_ENC'), Y, '$VIA8_Z', '$VIA_W', strcat(R_OP,'+2*',S), '0', strcat(OD,'-2*$PO-2*$VIA_ENC'),'$VIA8_T', serial, 'T40_ME0d022');
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO9+$PI9+$VIA_ENC'), Y, '$VIA8_Z', '$VIA_W' , R_OP, '0', strcat(OD, '-2*($PO9+$PI9)-2*$VIA_ENC'),'$VIA8_T',serial, 'T40_ME0d022');
    
    serial = hfss_xfm_cross_viaN(fid,X , Y, Z, WO, strcat('2*', S, '+', WI), R_OP, Thickness2, '-$VIA8_T-$VIA9_T-$M11_T-$M8_T-$M9_T',serial,'T40_ME0d021'); % under pass
    hfssMirror(fid, {['C' num2str(serial-1)]}, [0 0 0], [0 -1 0], '')
    
    serial = hfss_xfm_cross_viaN(fid,X , Y, Z2, '$M9_W' , strcat('2*', '$M9_S','+', '$M9_W'), R_OP, Thickness1, '0', serial,'T40_ME0d022'); % under pass
    serial = hfss_xfm_cross_viaN(fid,X , Y, '$M8_Z', '$M9_W', strcat('2*', '$M9_S','+', '$M9_W'), R_OP, Thickness1, '0', serial,'T40_ME0d022'); % under pass
    
    hfssBoxN(fid, 'gap1', {'0',strcat('-', R_OP, '/2'),'$M9_Z'}, {'$M9_W',strcat('-$PO-','$M11_S'),'$M9_T'}, 'T40_ME0d022');
    hfssBoxN(fid, 'gap2', {'0',strcat(R_OP, '/2'),'$M9_Z'}, {'$M9_W',strcat('$PO+','$M11_S'),'$M9_T'},'T40_ME0d022');
    
    hfssBoxN(fid, 'gap3', {'0',strcat('-', R_OP, '/2'),'$M8_Z'}, {'$M9_W',strcat('-$PO-','$M11_S'),'$M8_T'}, 'T40_ME0d022');
    hfssBoxN(fid, 'gap4', {'0',strcat(R_OP, '/2'),'$M8_Z'}, {'$M9_W',strcat('$PO+','$M11_S'),'$M8_T'},'T40_ME0d022');
    serial = serial + 1;
    
    % leads 
    % lead 1
    hfssBoxN(fid, 'under_1', {strcat('-', S, '-$lead'),strcat(R_OP, '/2+', S),'$M11_Z'}, {'$M11_S+$PO+$lead',WI,'$M11_T'},'T40_ME0d021');
    % lead 2
    hfssBoxN(fid, 'under_2', {strcat('-', S, '-$lead'),strcat('-', R_OP, '/2-',S),'$M11_Z'}, {'$M11_S+$PO+$lead',strcat('-', WI),'$M11_T'},'T40_ME0d021');
    
    serial = hfss_lead(fid,strcat('-', S),strcat(R_OP, '/2+', S),'$M9_Z', '-$LEAD',  WO, '$M9_T',WO, '$VIA9_T', serial);
    serial = hfss_lead(fid,strcat('-', S),strcat('-',R_OP, '/2-', S),'$M9_Z', '-$LEAD', strcat('-', WO), '$M9_T', WO, '$VIA9_T', serial); 
    serial = hfss_lead(fid,strcat('-', S),strcat(R_OP, '/2+', S),'$M8_Z', '-$LEAD',  WO, '$M8_T',WO, '$VIA8_T', serial);
    serial = hfss_lead(fid,strcat('-', S),strcat('-',R_OP, '/2-', S),'$M8_Z', '-$LEAD', strcat('-', WO), '$M8_T', WO, '$VIA8_T', serial); 
    
    serial =  hfss_lead(fid,OD,strcat(L_OP, '/2'),'$M9_Z', '$LEAD',  WI, '$M9_T', WI, '$VIA9_T', serial);
    serial =  hfss_lead(fid,OD,strcat(L_OP, '/2'),'$M8_Z', '$LEAD',  WI, '$M8_T', WI, '$VIA8_T', serial);
    hfssBoxN(fid, 'leadp3', {OD,strcat(L_OP, '/2'),'$M11_Z'}, {'$LEAD',WI,'$M11_T'},'T40_ME0d021');
    serial =  hfss_lead(fid,OD,strcat('-',L_OP, '/2'),'$M9_Z', '$LEAD', strcat('-', WI), '$M9_T', WI, '$VIA9_T', serial);
    serial =  hfss_lead(fid,OD,strcat('-',L_OP, '/2'),'$M8_Z', '$LEAD', strcat('-', WI), '$M8_T', WI, '$VIA8_T', serial);
    hfssBoxN(fid, 'leadp4', {OD,strcat('-', L_OP, '/2'),'$M11_Z'}, {'$LEAD',strcat('-', WI),'$M11_T'},'T40_ME0d021');

    % Guardring
    hfssCreateVar(fid, 'GR_W', [num2str(8) 'um']);
    hfssBoxN(fid, 'GR_L', {'-$WE/2+$move_x' ,'-$LE/2','$M6_Z'}, {'$GR_W','$LE','$M6_T'},'T40_ME0d289');
    hfssBoxN(fid, 'GR_R', {'$WE/2+$move_x' ,'-$LE/2','$M6_Z'}, {'-$GR_W','$LE','$M6_T'},'T40_ME0d289');
    
    hfssBoxN(fid, 'GR_T', {'-$WE/2+$move_x+$GR_W' ,'-$LE/2','$M6_Z'}, {'$WE-2*$GR_W','$GR_W','$M6_T'},'T40_ME0d289');
    hfssBoxN(fid, 'GR_D', {'-$WE/2+$move_x+$GR_W' ,'$LE/2','$M6_Z'}, {'$WE-2*$GR_W','-$GR_W','$M6_T'},'T40_ME0d289');

    
    % ports
    hfssCreateVar(fid, 'PORT_H', '$M8_Z-$M6_Z-$M6_T');
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
    
    hfssSubtract(fid, {'IMD_8a', 'IMD_8b','IMD_8c','IMD_8d','IMD_9a', 'IMD_9b','IMD_9c', 'PASS1', 'PASS2', 'PASS3', 'PASS4'}, ...
        {'L6', 'L6_1','L7', 'L7_1','L8', 'L8_1','L9', 'L9_1',...
        'L10', 'L10_1','L11', 'L11_1',...
        'L0', 'L0_1','L1', 'L1_1','L2', 'L2_1',...
        'L3', 'L3_1','L4', 'L4_1','L5', 'L5_1',...
        'under_1', 'under_2','leadp3', 'leadp4',...
        'gap1', 'gap2','gap3', 'gap4',...
        'lead21', 'lead22','lead24', 'lead26',...
        'lead19', 'lead20','lead23', 'lead25',...
        'C15', 'C16','C17',...
        'L12', 'L12_1','L13', 'L13_1','L14', 'L14_1'},1);