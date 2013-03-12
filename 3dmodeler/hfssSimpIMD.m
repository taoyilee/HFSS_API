function hfssSimpIMD(csvfile)
    % $W and $L are assumed to be defined
    csv = textread(csvfile,'%s', 'delimiter',',');
    zi = 0;
    % mtrlname = '';
    name = cell2mat(csv(5));
	eq_d = str2double(cell2mat(csv(6)));
    eq_er = str2double(cell2mat(csv(7)));
    disp(['IMD->' name ' =>' num2str(eq_er) ' T=' num2str(eq_d)]);
    for i = 2:length(csv)/4-2
        name = cell2mat(csv(4*i+1));
        thickness = str2double(cell2mat(csv(4*i+2)));
        permittivity = str2double(cell2mat(csv(4*i+3)));
        disp(['IMD->' name ' er = ' num2str(permittivity) ' T=' num2str(thickness) 'nm']);
        eq_doer = eq_d/eq_er;
        eq_d = eq_d + thickness;         
        eq_er = eq_d/(thickness/permittivity + eq_doer);
        disp(['eqv. er = ' num2str(eq_er) ' T_tot = ' num2str(eq_d)]);
        
        for j=i+1:length(csv)/4-2            
            namej = cell2mat(csv(4*j+1));
            fptr = fopen(['IMD_6X1Z1U' name '_' namej '.csv'], 'wt');
            fprintf(fptr, 'Name, Thickness(nm), Er, Z\n');
            fprintf(fptr, '%s,%f,%f,%f\n', [name 'EQ'], eq_d, eq_er, 1);                
            for k=i+1:j
                namek = cell2mat(csv(4*k+1));
                thickness1 = str2double(cell2mat(csv(4*k+2)));
                permittivity1 = str2double(cell2mat(csv(4*k+3)));                
                fprintf(fptr, '%s,%f,%f,%f\n', namek, thickness1, permittivity1,k-i+1);
            end
            eqj_d = 0;
            eqj_er = 1;
            for k=j+1:length(csv)/4-1
                % namek = cell2mat(csv(4*k+1));
                thicknessk = str2double(cell2mat(csv(4*k+2)));
                permittivityk = str2double(cell2mat(csv(4*k+3)));       
                eqj_doer = eqj_d/eqj_er;    
                eqj_d = eqj_d + thicknessk;         
                eqj_er = eqj_d/(thicknessk/permittivityk + eqj_doer);                         
            end
            fprintf(fptr, '%s,%f,%f,%f\n',  [cell2mat(csv(4*(j+1)+1)) 'EQ'], eqj_d, eqj_er,j-i+2);
            fclose(fptr);
        end        
    end	         
