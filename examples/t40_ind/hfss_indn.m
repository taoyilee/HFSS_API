function serial = hfss_indn(fid,X, Y, Z,  OD, S, NT, W, lead, Thickness1,Thickness2, viah, material,serial)
        hfssCreateVar(fid, 'NT', num2str(NT));
        hfssCreateVar(fid, 'M11_P',  strcat(W, '+', S));
        inductor_in = strcat('L', num2str(serial));
        hfssUDP(fid, 'inductor',inductor_in , 11, {'Xpos', 'Ypos', 'Zpos','OD', 'S','NT', 'W', 'lead','Thickness' ,'maskGrid' ,'DIV'},...
            {X, Y, Z,  OD, S, '$NT', W, lead, Thickness2, '$grid', '3.14'},  hfssgetmaterial(material),{'255','0','0'});     
        if(NT>1)       
            % underpass 1
            hfssBoxN(fid, 'under_1', {strcat(OD, '-($NT-1)*$M11_P-', W),S,'$M9_Z'}, {strcat('$NT*$M11_P+', W),W,Thickness1});
            hfssAssignMaterial(fid, 'under_1','T40_ME0d022',0);
            % via 1 for underpass 1
            hfssBoxN(fid, 'u1_via1', {strcat(OD, '-($NT-1)*$M11_P-', W),S,'$M9_Z+$M9_T'}, {W,W,'$M11_Z-($M9_Z+$M9_T)'});
            hfssAssignMaterial(fid, 'u1_via1','T40_ME0d022',0);
            % via 2 for underpass 1
            hfssBoxN(fid, 'u1_via2', {strcat(OD, '+$M11_P-',W),S,'$M9_Z+$M9_T'}, {W,W,'$M11_Z-($M9_Z+$M9_T)'});
            hfssAssignMaterial(fid, 'u1_via2','T40_ME0d022',0);

            hfssSubtract(fid, 'IMD_9a', 'under_1',1);
            hfssSubtract(fid, 'IMD_9b', 'under_1',1);
            hfssSubtract(fid, 'IMD_9c', 'under_1',1);        
            hfssSubtract(fid, 'PASS1', 'under_1',1);
            hfssSubtract(fid, 'PASS1', 'u1_via1',1);
            hfssSubtract(fid, 'PASS1', 'u1_via2',1);
            hfssSubtract(fid, 'PASS2', 'u1_via1',1);
            hfssSubtract(fid, 'PASS2', 'u1_via2',1); 
        end
        % port
        
        hfssCreateVar(fid, 'PORT_H', Thickness2);
        posi = {strcat(OD,'+$LEAD+$M11_P'),'0','$M11_Z'};
        hfssRectangleN(fid, 'P1', 'x', posi , S, '$PORT_H');
        hfssAssignLumpedPortDTerm(fid, 'P1', posi, '', '1');
        hfssDeleteBoundaries(fid, [inductor_in '_T2']);
        

        hfssSubtract(fid, 'PASS3', inductor_in,1);
        hfssSubtract(fid, 'PASS4', inductor_in,1);
        serial = serial +1;