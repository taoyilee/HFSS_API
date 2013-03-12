function serial = hfss_xfmM9(fid,X , Y, Z, Z2, WI, WO, S, R_OP,L_OP, OD,Thickness1, Thickness2, VIAH,serial)
    hfssCreateVar(fid, 'PI', strcat(WI, '+', S));   
    hfssCreateVar(fid, 'PO', strcat(WO, '+', S));
    me9 = 'ME0d005';
    me8 = 'ME0d022';
    serial = hfss_xfm_halfudN(fid,X , Y, Z, WO, strcat(R_OP,'+2*$PO+2*', S),L_OP, OD,Thickness1,serial,me9);
    serial = hfss_xfm_halfudN(fid, strcat(X, '+$PO'), Y, Z, WI, strcat(R_OP,'+2*',S), '0', strcat(OD,'-2*$PO'),Thickness1,serial,me9);
    serial = hfss_xfm_halfudN(fid,strcat(X, '+$PO+$PI'), Y, Z, WO, R_OP, '0', strcat(OD, '-2*($PO+$PI)'),Thickness1,serial,me9);   
    serial = hfss_xfm_cross_viaN(fid,X , Y, Z2, WO, strcat('2*', S, '+', WI), R_OP, Thickness2, '$VIA10_T+$M9_T',serial,me8); % under pass
    hfssMirror(fid, {['C' num2str(serial-1)]}, [0 0 0], [0 -1 0], '')
    serial = hfss_xfm_cross_viaN(fid,X , Y, Z, WO, strcat('2*', S,'+', WI), R_OP, Thickness1, '0', serial,me9); % under pass
    hfssBoxN(fid, 'gap1', {'0',strcat('-', R_OP, '/2'),'$M9_Z'}, {'$WI',strcat('-$PO-',S),'$M9_T'}, me9);
    hfssBoxN(fid, 'gap2', {'0',strcat(R_OP, '/2'),'$M9_Z'}, {'$WI',strcat('$PO+',S),'$M9_T'},me9);
    serial = serial + 1;    
    % leads         
    % lead 1
    hfssBoxN(fid, 'under_1', {strcat('-', S, '-$lead'),strcat(R_OP, '/2+', S),'$M9_Z'}, {'$lead',WI,'$M9_T'},me9);
    hfssBoxN(fid, 'underp_1', {strcat('-', S, '-', WI),strcat(R_OP, '/2+', S),'$M8_Z'}, {strcat('2*$PI+',WI),WI,'$M8_T'},me8);
    hfssBoxN(fid, 'underp_1v1', {strcat('-', S, '-', WI),strcat(R_OP, '/2+', S),'$VIA10_Z'}, {WI,WI,'$VIA10_T'},me8);
    hfssBoxN(fid, 'underp_1v2', {'$PO' ,strcat(R_OP, '/2+', S),'$VIA10_Z'}, {WI,WI,'$VIA10_T'},me8);
    % lead 2
    hfssBoxN(fid, 'under_2', {strcat('-', S, '-$lead'),strcat('-', R_OP, '/2-',S),'$M9_Z'}, {'$lead',strcat('-', WI),'$M9_T'},me9);
    hfssBoxN(fid, 'underp_2', {strcat('-', S, '-', WI),strcat('-', R_OP, '/2-',S),'$M8_Z'}, {strcat('2*$PI+',WI),strcat('-', WI),'$M8_T'},me8);
    hfssBoxN(fid, 'underp_2v1', {strcat('-', S, '-', WI),strcat('-',R_OP, '/2-', S),'$VIA10_Z'}, {WI,strcat('-',WI),'$VIA10_T'},me8);
    hfssBoxN(fid, 'underp_2v2', {'$PO' ,strcat('-', R_OP, '/2-', S),'$VIA10_Z'}, {WI,strcat('-',WI),'$VIA10_T'},me8);
    
    hfssBoxN(fid, 'leadp3', {OD,strcat(L_OP, '/2'),'$M9_Z'}, {'$LEAD',WI,'$M9_T'},me9);
    hfssBoxN(fid, 'leadp4', {OD,strcat('-', L_OP, '/2'),'$M9_Z'}, {'$LEAD',strcat('-', WI),'$M9_T'},me9);
    me6 = 'ME0d1399';
    % Guardring
    hfssCreateVar(fid, 'GR_W', [num2str(8) 'um']);
    hfssBoxN(fid, 'GR_L', {'-$WE/2+$move_x' ,'-$LE/2','$M6_Z'}, {'$GR_W','$LE','$M6_T'}, me6);
    hfssBoxN(fid, 'GR_R', {'$WE/2+$move_x' ,'-$LE/2','$M6_Z'}, {'-$GR_W','$LE','$M6_T'},me6);
    
    hfssBoxN(fid, 'GR_T', {'-$WE/2+$move_x+$GR_W' ,'-$LE/2','$M6_Z'}, {'$WE-2*$GR_W','$GR_W','$M6_T'},me6);
    hfssBoxN(fid, 'GR_D', {'-$WE/2+$move_x+$GR_W' ,'$LE/2','$M6_Z'}, {'$WE-2*$GR_W','-$GR_W','$M6_T'},me6);

    
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
    
    hfssSubtract(fid, {'IMD_8gEQ'}, {'C3', 'underp_1v1', 'underp_1v2', 'underp_2v1', 'underp_2v2'},1);
    hfssSubtract(fid, {'IMD_9a'}, {'L0','L0_1','L1','L1_1','L2','L2_1','C3','C4','under_1','under_2',...
        'underp_1v1', 'underp_1v2', 'underp_2v1', 'underp_2v2','gap1','gap2','leadp3','leadp4'},1);
    hfssSubtract(fid, {'IMD_9b','IMD_9c'}, {'L0','L0_1','L1','L1_1','L2','L2_1','C3','C4','under_1','under_2',...
        'gap1','gap2','leadp3','leadp4'},1);
    