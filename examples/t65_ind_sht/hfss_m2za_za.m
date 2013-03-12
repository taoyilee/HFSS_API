function serial = hfss_m2za_za(fid,X, Y, Z,  OD, S, NT, W, lead, Thickness1,Thickness2, viah, material,serial)
        hfssCreateVar(fid, 'NT', num2str(NT));
        hfssCreateVar(fid, 'M11_P',  strcat(W, '+', S));
        inductor_in1 = strcat('L', num2str(serial));
        serial = serial +1;
        hfssUDP(fid, 'inductor_open',inductor_in1 , 11, {'Xpos', 'Ypos', 'Zpos','OD', 'S','NT', 'W', 'lead','Thickness' ,'maskGrid' ,'DIV'},...
            {X, Y, Z,  OD, S, '$NT', W, lead, Thickness2, '$grid', '3.14'},  hfssgetmaterial(material),{'255','0','0'});     
        
        inductor_in2 = strcat('L', num2str(serial));
        serial = serial +1;
        hfssUDP(fid, 'inductor_open',inductor_in2 , 11, {'Xpos', 'Ypos', 'Zpos','OD', 'S','NT', 'W', 'lead','Thickness' ,'maskGrid' ,'DIV'},...
            {X, Y, '$M9_Z' ,  OD, S, '$NT', W, lead, '$M9_T', '$grid', '3.14'},  hfssgetmaterial('T40_ME0d022'),{'255','0','0'});             
        
        inductor_in3 = strcat('L', num2str(serial));
        serial = serial +1;
        hfssUDP(fid, 'inductor',inductor_in3 , 11, {'Xpos', 'Ypos', 'Zpos','OD', 'S','NT', 'W', 'lead','Thickness' ,'maskGrid' ,'DIV'},...
            {X, Y, '$M8_Z',  OD, S, '$NT', W, lead, '$M8_T', '$grid', '3.14'},  hfssgetmaterial('T40_ME0d022'),{'255','0','0'});     
                       
        
        % port
        hfssBoxN(fid, 'port_1', {strcat(OD,'+$LEAD+$M11_P'),'0','$M8_Z'}, {'0.1um',strcat('-',W),'$M11_Z-$M8_Z+$M11_T'});
        hfssAssignMaterial(fid, 'port_1','T40_ME0d022',0);            
        
        hfssBoxN(fid, 'port_3', {strcat(OD,'+$LEAD+$M11_P'),S,'$M8_Z'}, {'0.1um',W,'$M11_Z-$M8_Z+$M11_T'});
        hfssAssignMaterial(fid, 'port_3','T40_ME0d022',0);            
       
        % port vias
        hfssCreateVar(fid, 'VIAW', [num2str(2) 'um']);
        hfssCreateVar(fid, 'VIAS', [num2str(2) 'um']);
        hfssCreateVar(fid, 'VIAEN', '($M11_W - $VIAW)/2');
        hfssCreateVar(fid, 'VIAP', '$VIAW+$VIAS');
            % M8 - M9
        hfssBoxN(fid, 'via_1', {strcat(OD,'+', S, '+$VIAEN'), strcat(S, '+$VIAEN') ,'$M8_Z+$M8_T'}, {'$VIAW','$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_1','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_1'}, {'$VIAP','0','0'},8, '');
        
        hfssBoxN(fid, 'via_2', {strcat(OD,'+', S, '+$VIAEN'), '-$VIAEN' ,'$M8_Z+$M8_T'}, {'$VIAW','-$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_2','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_2'}, {'$VIAP','0','0'},8, '');
            % M9 - AP
        hfssBoxN(fid, 'via_3', {strcat(OD,'+', S, '+$VIAEN'), strcat(S, '+$VIAEN') ,'$M9_Z+$M9_T'}, {'$VIAW','$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_3','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_3'}, {'$VIAP','0','0'},8, '');
        
        hfssBoxN(fid, 'via_4', {strcat(OD,'+', S, '+$VIAEN'), '-$VIAEN' ,'$M9_Z+$M9_T'}, {'$VIAW','-$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_4','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_4'}, {'$VIAP','0','0'},8, '');
        hfsssubsimd(fid, 'IMD_8d', 'via_1', 8);
        hfsssubsimd(fid, 'IMD_8d', 'via_2', 8);
        hfsssubsimd(fid, 'IMD_9a', 'via_1', 8);
        hfsssubsimd(fid, 'IMD_9a', 'via_2', 8);
        hfsssubsimd(fid, 'PASS1', 'via_3', 8);
        hfsssubsimd(fid, 'PASS2', 'via_3', 8);
        hfsssubsimd(fid, 'PASS2', 'via_4', 8);
        hfsssubsimd(fid, 'PASS1', 'via_4', 8);
        
            % vias
            
            % M8 - M9
        hfssBoxN(fid, 'via_5', {'$VIAEN', '-20um' ,'$M8_Z+$M8_T'}, {'$VIAW','$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_5','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_5'}, {'0','$VIAP','0'},10, '');
        
        hfssBoxN(fid, 'via_6', {'$M11_P+$VIAEN', '-20um' ,'$M8_Z+$M8_T'}, {'$VIAW','$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_6','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_6'}, {'0', '$VIAP','0'},10, '');
            % M9 - AP
        hfssBoxN(fid, 'via_7', {'$VIAEN', '-20um' ,'$M9_Z+$M9_T'}, {'$VIAW','$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_7','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_7'}, {'0','$VIAP','0'},10, '');
        
        hfssBoxN(fid, 'via_8', {'$M11_P+$VIAEN', '-20um' ,'$M9_Z+$M9_T'}, {'$VIAW','$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_8','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_8'}, {'0','$VIAP','0'},10, '');
        hfsssubsimd(fid, 'IMD_8d', 'via_5', 10);
        hfsssubsimd(fid, 'IMD_8d', 'via_6', 10);
        hfsssubsimd(fid, 'IMD_9a', 'via_5', 10);
        hfsssubsimd(fid, 'IMD_9a', 'via_6', 10);
        hfsssubsimd(fid, 'PASS1', 'via_7', 10);
        hfsssubsimd(fid, 'PASS1', 'via_8', 10);
        hfsssubsimd(fid, 'PASS2', 'via_7', 10);
        hfsssubsimd(fid, 'PASS2', 'via_8', 10);
        % vias
            
            % M8 - M9
        hfssBoxN(fid, 'via_9', {'42um' ,'-$OD/2+$VIAEN', '$M8_Z+$M8_T'}, {'$VIAW','$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_9','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_9'}, {'$VIAP','0','0'},12, '');
        
        hfssBoxN(fid, 'via_10', {'42um' ,'-$OD/2+$M11_P+$VIAEN','$M8_Z+$M8_T'}, {'$VIAW','$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_10','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_10'}, {'$VIAP','0','0'},11, '');
        
        hfsssubsimd(fid, 'IMD_8d', 'via_9', 12);
        hfsssubsimd(fid, 'IMD_8d', 'via_10', 11);
        hfsssubsimd(fid, 'IMD_9a', 'via_9', 12);
        hfsssubsimd(fid, 'IMD_9a', 'via_10', 11);
            % M9 - AP
        hfssBoxN(fid, 'via_11', {'42um' ,'-$OD/2+$VIAEN', '$M9_Z+$M9_T'}, {'$VIAW','$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_11','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_11'}, {'$VIAP','0','0'},12, '');
        
        hfssBoxN(fid, 'via_12', {'42um' ,'-$OD/2+$M11_P+$VIAEN','$M9_Z+$M9_T'}, {'$VIAW','$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_12','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_12'}, {'$VIAP','0','0'},11, '');
        hfsssubsimd(fid, 'PASS1', 'via_11', 12);
        hfsssubsimd(fid, 'PASS1', 'via_12', 11);
        hfsssubsimd(fid, 'PASS2', 'via_11', 12);
        hfsssubsimd(fid, 'PASS2', 'via_12', 11);
        
        % vias
            
            % M8 - M9
        hfssBoxN(fid, 'via_13', {'42um' ,'$OD/2-$VIAEN', '$M8_Z+$M8_T'}, {'$VIAW','-$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_13','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_13'}, {'$VIAP','0','0'},10, '');
        
        hfssBoxN(fid, 'via_14', {'42um' ,'$OD/2-$M11_P-$VIAEN','$M8_Z+$M8_T'}, {'$VIAW','-$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_14','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_14'}, {'$VIAP','0','0'},10, '');
        hfsssubsimd(fid, 'IMD_8d', 'via_13', 10);
        hfsssubsimd(fid, 'IMD_8d', 'via_14', 10);
        hfsssubsimd(fid, 'IMD_9a', 'via_13', 10);
        hfsssubsimd(fid, 'IMD_9a', 'via_14', 10);
            % M9 - AP
        hfssBoxN(fid, 'via_15', {'42um' ,'$OD/2-$VIAEN', '$M9_Z+$M9_T'}, {'$VIAW','-$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_15','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_15'}, {'$VIAP','0','0'},10, '');
        
        hfssBoxN(fid, 'via_16', {'42um' ,'$OD/2-$M11_P-$VIAEN','$M9_Z+$M9_T'}, {'$VIAW','-$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_16','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_16'}, {'$VIAP','0','0'},10, '');
        hfsssubsimd(fid, 'PASS1', 'via_15', 10);
        hfsssubsimd(fid, 'PASS1', 'via_16', 10);
        hfsssubsimd(fid, 'PASS2', 'via_15', 10);        
        hfsssubsimd(fid, 'PASS2', 'via_16', 10);
        % vias            
            % M8 - M9
        hfssBoxN(fid, 'via_17', {'$OD - $VIAEN', '$M11_S + $M11_P +$VIAEN' ,'$M8_Z+$M8_T'}, {'-$VIAW','$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_17','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_17'}, {'0','$VIAP','0'},3, '');
        
        hfssBoxN(fid, 'via_18', {'$OD - $M11_P -$VIAEN', '$M11_S+$VIAEN' ,'$M8_Z+$M8_T'}, {'-$VIAW','$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_18','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_18'}, {'0', '$VIAP','0'},4, '');
        hfsssubsimd(fid, 'IMD_8d', 'via_17', 3);
        hfsssubsimd(fid, 'IMD_8d', 'via_18', 4);
        hfsssubsimd(fid, 'IMD_9a', 'via_17', 3);
        hfsssubsimd(fid, 'IMD_9a', 'via_18', 4);
        % M9 - AP
        hfssBoxN(fid, 'via_19', {'$OD - $VIAEN', '$M11_S + $M11_P+$VIAEN' ,'$M9_Z+$M9_T'}, {'-$VIAW','$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_19','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_19'}, {'0','$VIAP','0'},3, '');
        
        hfssBoxN(fid, 'via_20', {'$OD - $M11_P - $VIAEN', '$M11_S+$VIAEN' ,'$M9_Z+$M9_T'}, {'-$VIAW','$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_20','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_20'}, {'0','$VIAP','0'},4, '');
        hfsssubsimd(fid, 'PASS1', 'via_19', 3);
        hfsssubsimd(fid, 'PASS1', 'via_20', 4);
        hfsssubsimd(fid, 'PASS2', 'via_19', 3);        
        hfsssubsimd(fid, 'PASS2', 'via_20', 4);
        
         % vias
            
            % M8 - M9
        hfssBoxN(fid, 'via_21', {'$OD - $VIAEN', '- $VIAEN' ,'$M8_Z+$M8_T'}, {'-$VIAW','-$VIAW','$M9_Z-$M8_Z-$M8_T'});
        hfssAssignMaterial(fid, 'via_21','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_21'}, {'0','-$VIAP','0'},5, '');
        hfsssubsimd(fid, 'IMD_8d', 'via_21', 5);
        hfsssubsimd(fid, 'IMD_9a', 'via_21', 5);
            % M9 - AP
        hfssBoxN(fid, 'via_22', {'$OD - $VIAEN', '- $VIAEN' ,'$M9_Z+$M9_T'}, {'-$VIAW','-$VIAW','$M11_Z-$M9_Z-$M9_T'});
        hfssAssignMaterial(fid, 'via_22','T40_ME0d022',0);            
        hfssDuplicateAlongLineN(fid, {'via_22'}, {'0','-$VIAP','0'},5, '');

        hfsssubsimd(fid, 'PASS1', 'via_22', 5);
        hfsssubsimd(fid, 'PASS2', 'via_22', 5);
        % create port
        
        hfssCreateVar(fid, 'PORT_H', '$M11_Z-$M8_Z+$M11_T');
        posi = {strcat(OD,'+$LEAD+$M11_P+0.1um'),'0','$M8_Z'};
        hfssRectangleN(fid, 'P1', 'x', posi , S, '$PORT_H');
        hfssAssignLumpedPortDTerm(fid, 'P1', posi, '', '1');
        hfssDeleteBoundaries(fid, 'port_3_T1');       
        hfssSubtract(fid, 'PASS3', inductor_in1,1);
        hfssSubtract(fid, 'PASS4', inductor_in1,1);
        
        hfssSubtract(fid, 'IMD_8a', inductor_in3,1);
        hfssSubtract(fid, 'IMD_8b', inductor_in3,1);
        hfssSubtract(fid, 'IMD_8c', inductor_in3,1);
        
        hfssSubtract(fid, 'IMD_8a', 'port_1',1);
        hfssSubtract(fid, 'IMD_8b', 'port_1',1);
        hfssSubtract(fid, 'IMD_8c', 'port_1',1);
        hfssSubtract(fid, 'IMD_8d', 'port_1',1);
        
        hfssSubtract(fid, 'IMD_8a', 'port_3',1);
        hfssSubtract(fid, 'IMD_8b', 'port_3',1);
        hfssSubtract(fid, 'IMD_8c', 'port_3',1);
        hfssSubtract(fid, 'IMD_8d', 'port_3',1);
        
        hfssSubtract(fid, 'IMD_9a', inductor_in2,1);
        hfssSubtract(fid, 'IMD_9b', inductor_in2,1);
        hfssSubtract(fid, 'IMD_9c', inductor_in2,1);
        
        hfssSubtract(fid, 'IMD_9a', 'port_1',1);
        hfssSubtract(fid, 'IMD_9b', 'port_1',1);
        hfssSubtract(fid, 'IMD_9c', 'port_1',1);        
        
        hfssSubtract(fid, 'IMD_9a', 'port_3',1);
        hfssSubtract(fid, 'IMD_9b', 'port_3',1);
        hfssSubtract(fid, 'IMD_9c', 'port_3',1);        
        hfssSubtract(fid, 'PASS1', 'port_1',1);
        hfssSubtract(fid, 'PASS2', 'port_1',1);
        hfssSubtract(fid, 'PASS3', 'port_1',1);
        hfssSubtract(fid, 'PASS4', 'port_1',1);
        hfssSubtract(fid, 'PASS1', 'port_3',1);
        hfssSubtract(fid, 'PASS2', 'port_3',1);
        hfssSubtract(fid, 'PASS3', 'port_3',1);        
        hfssSubtract(fid, 'PASS4', 'port_3',1);
        serial = serial +1;