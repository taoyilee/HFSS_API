function hfsssubsimd(fid, imd, tool, num)
        cells = cell(num);
        cells{1} = tool;        
        for i=2:num
            cells{i} = strcat(tool, '_', num2str(i-1));
        end
        hfssSubtract(fid, imd, cells,1);