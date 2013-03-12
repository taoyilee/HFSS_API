function hfssME(fid, prefix, csvfile, z)
    csv = textread(csvfile,'%s', 'delimiter',',');

    cols = 4;
    mtrlname = '';
        for i = 1:length(csv)/cols-1
        name = [prefix cell2mat(csv(cols*i+1))];
        thickness = str2double(cell2mat(csv(cols*i+2))); % angstroms
        thickness = thickness/10; % to nm
        conductivity = str2double(cell2mat(csv(cols*i+3)));
        Z_pos = str2double(cell2mat(csv(cols*i+4))); % angstroms
        Z_pos = Z_pos/10; % convert to nm
        if(i ~= (length(csv)/cols-1))
            Z_pos_1 = str2double(cell2mat(csv(cols*(i+1)+4)))/10;
            hfssCreateVar(fid, ['VIA' num2str(i-1) '_T'], [num2str(Z_pos_1 - Z_pos - thickness) ' nm']);
            hfssCreateVar(fid, ['VIA' num2str(i-1) '_Z'], [num2str(Z_pos + thickness) ' nm']);
        end
        hfssCreateVar(fid, [name '_T'], [num2str(thickness) ' nm']);
        hfssCreateVar(fid, [name '_Z'], [num2str(Z_pos) ' nm']);
       
        
        material_name = ['ME'  strrep(num2str(conductivity), '.','d')];
        via_name = ['VIA'  strrep(num2str(conductivity), '.','d')];
        conductivity = 1/(conductivity*thickness*1e-9);
        
        % disp(['ME "'  material_name '" created; Bulk Cond = ' num2str(conductivity) '(S/m) Thickness = ' num2str(thickness) ' nm']);
        if(isempty(findstr(mtrlname, material_name)))
            hfssAddMaterial(fid, material_name, 1,conductivity,0);
            hfssAddMaterial(fid, via_name, 1,conductivity,0);
        end
        mtrlname = char([mtrlname material_name]);     
        end	         
