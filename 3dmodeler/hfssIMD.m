function hfssIMD(fid, prefix, csvfile,z)
    % $W and $L are assumed to be defined
    csv = textread(csvfile,'%s', 'delimiter',',');
    zi = z;
    mtrlname = '';
        for i = 1:length(csv)/4-1
        name = [prefix cell2mat(csv(4*i+1))];
        thickness = str2double(cell2mat(csv(4*i+2)));   % angstroms
        thickness = thickness/10;
        hfssCreateVar(fid, [name '_T'], [num2str(thickness) ' nm']);
        hfssCreateVar(fid, [name '_Z'], [num2str(zi) ' nm']);
        
        %hfssBox(fid, name , [-w/2, -l/2, zi/1000], [w, l, thickness/1000], 'um');
        permittivity = str2double(cell2mat(csv(4*i+3)));
        material_name = ['IMD'  strrep(num2str(permittivity), '.','d')];
        disp(['IMD "'  material_name '" created; Thickness = ' num2str(thickness) ' nm;  Er=' num2str(permittivity)]);
        if(isempty(findstr(mtrlname , [material_name 'salt'])))
            hfssAddMaterial(fid, material_name, permittivity,0,0);
        end
        mtrlname = char([mtrlname material_name 'salt']);
        hfssBoxN(fid, name , {'-$W/2+$move_x', '-$L/2+$move_y', ['$' name '_Z+$move_z']}, {'$W', '$L', ['$' name '_T']},material_name);
        hfssWireFrame(fid, name);
        % hfssAssignMaterial(fid, name,material_name);
        zi = zi + thickness;         
        end	         
