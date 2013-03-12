function [imdt erp] = hfssSimpIMD3(csvfile, outfile)
    % $W and $L are assumed to be defined
    csv = textread(csvfile,'%s', 'delimiter',',');
    cols = 5;
    layers = length(csv)/cols - 1 ;
    name = cell(1,layers);
    thickness = zeros(1,layers);
    permittivity = zeros(1,layers);
    group = zeros(1,layers);
    
    for i = 1:layers
        name{i} = cell2mat(csv(cols*i+1));
        thickness(i) = str2double(cell2mat(csv(cols*i+2)));       
        permittivity(i) = str2double(cell2mat(csv(cols*i+3)));
        group(i) = str2double(cell2mat(csv(cols*i+5)));
        disp(['IMD----> ' name{i} ' Er = ' num2str(permittivity(i)) ' T=' num2str(thickness(i)) ' A G=' num2str(group(i))]);
    end	         
    imdt = zeros(1,max(group));
    erp = zeros(1,max(group));    

    fptr = fopen(outfile, 'w+');
    fprintf(fptr, 'Name, Thickness (A), Rel Permittivity, Z\n');
    
	for i = 1:layers       
            num = group(i);

            [erp(num), imdt(num)] = EqEr(erp(num), imdt(num), permittivity(i), thickness(i));                
            disp(['(' num2str(num) ') T=' num2str(imdt(num)) ' ER=' num2str(erp(num)) ]);            
    end      
    group_name = cell(1,max(group));
    for i = 1:max(group)      
        tmp = find(group==i);
        group_name{i} = name{tmp(1)};
        fprintf(fptr, '%s,%f,%f,%f\n',  [group_name{i} 'EQ'], imdt(i),erp(i), i);            
    end
    fclose(fptr);
end