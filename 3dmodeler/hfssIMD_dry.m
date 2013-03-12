function hfssIMD_dry(fid, prefix, csvfile,z)
    % $W and $L are assumed to be defined
    csv = textread(csvfile,'%s', 'delimiter',',');
    zi = z;
    mtrlname = '';
        for i = 1:length(csv)/4-1
        name = [prefix cell2mat(csv(4*i+1))];
        thickness = str2double(cell2mat(csv(4*i+2)));
        % disp(['IMD "'  name '" created; Thickness = ' num2str(thickness) ' nm']);
        hfssCreateVar(fid, [name '_T'], [num2str(thickness) ' nm']);
        hfssCreateVar(fid, [name '_Z'], [num2str(zi) ' nm']);
        
        %hfssBox(fid, name , [-w/2, -l/2, zi/1000], [w, l, thickness/1000], 'um');
        permittivity = str2double(cell2mat(csv(4*i+3)));
        material_name = ['T40_IMD'  strrep(num2str(permittivity), '.','d')];
        if(isempty(findstr(mtrlname, material_name)))
            hfssAddMaterial(fid, material_name, permittivity,0,0);
        end
        mtrlname = char([mtrlname material_name]);      
        % hfssAssignMaterial(fid, name,material_name);
        zi = zi + thickness;         
        end	         
