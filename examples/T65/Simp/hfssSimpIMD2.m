function [imdt erp] = hfssSimpIMD2(csvfile)
    % $W and $L are assumed to be defined
    csv = textread(csvfile,'%s', 'delimiter',',');
    zi = 0;
    % mtrlname = '';
    name = cell2mat(csv(5));
	eq_d = str2double(cell2mat(csv(6)));
    eq_er = str2double(cell2mat(csv(7)));
    disp(['IMD->' name ' =>' num2str(eq_er) ' T=' num2str(eq_d)]);
    imdt = zeros(1,9);
    erp = zeros(1,9);
    for i = 2:length(csv)/4-2
        name = cell2mat(csv(4*i+1));
        thickness = str2double(cell2mat(csv(4*i+2)));       
        permittivity = str2double(cell2mat(csv(4*i+3)));
        disp(['IMD----> ' name ' Er = ' num2str(permittivity) ' T=' num2str(thickness) ' A']);
        eq_doer = eq_d/eq_er;
        eq_d = eq_d + thickness;         
        eq_er = eq_d/(thickness/permittivity + eq_doer);
        disp(['eqv. er = ' num2str(eq_er) ' T_tot = ' num2str(eq_d)]);        
        disp(' ');
        
        if(strcmp(name(1:3),'IMD'))  
            num = name(5);
            numn = str2double(num);
            [erp(numn), imdt(numn)] = EqEr(erp(numn), imdt(numn), permittivity, thickness);
            disp(['IMD' num ' T=' num2str(imdt(numn)) ' ER=' num2str(erp(numn)) ]);
        end       
    end	         
