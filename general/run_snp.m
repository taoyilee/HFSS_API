function run_snp(dir,subdir)    
    addpath('..');
    % Create a new temporary HFSS script file.	
    path = [dir '/*.hfss'];
    disp(['Listing all ' path ' .....']);
    file = ls(path);
    nfiles = size(file,1);
    if(nfiles >= 1)        
        for i=1:nfiles            
            cur_file = [dir '\' file(i,:)];   
            disp(['Delegating ' cur_file ' to LOCAL']);
            export_snp(cur_file,'run_tmp.vbs', subdir)      
        end   
    else
        disp('Nothing to do .....¦A·|£}£}');
    end
end