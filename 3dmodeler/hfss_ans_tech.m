function hfss_ans_tech(csvfile)
    csv = textread(csvfile,'%s', 'delimiter',',');
    cols = 6;
    via = 1;
    metal = 1;
    for i = 1:length(csv)/cols-1                  
        name{i} = cell2mat(csv(cols*i+1));            
        if(name{i}(1:2) == 'VI')                          
            gdsv(via) = str2double(cell2mat(csv(cols*i+5)));
            colorv{via} = cell2mat(csv(cols*i+6));	  
            disp([num2str(gdsv(via)) ' ' name{i} ' ' colorv{via} ' ' num2str(Z_pos(via)+thickness(via)) ' ' num2str(Z_pos(via+1)-Z_pos(via)-thickness(via)) ' // ' name{via} '	-	dg']);                
            via = via +1;
        else            
            thickness(metal) = str2double(cell2mat(csv(cols*i+2)));      
            Z_pos(metal) = str2double(cell2mat(csv(cols*i+4)));
            gds(metal) = str2double(cell2mat(csv(cols*i+5)));
            color{metal} = cell2mat(csv(cols*i+6));	      
            disp([num2str(gds(metal)) ' ' name{i} ' ' color{metal} ' ' num2str(Z_pos(metal)) ' ' num2str(thickness(metal)) ' // ' name{metal} '	-	dg']);                
            metal = metal +1;
        end    
    end	         
end
