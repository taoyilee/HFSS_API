function run_hfss_em(dir,N, DESIGN_NAME, ip)        
    addpath('..');    
    path = [dir '/*.hfss'];
    disp(['Listing all ' path ' .....']);
    file = ls(path);
    nfiles = size(file,1);
    if(nfiles >= 1)        
        for i=1:nfiles
            cur_file = [dir '\' file(i,:)];                                      
            disp(['Sending  ' cur_file ' to ' ip '........']);
            disp('');
            run_em(cur_file, N, DESIGN_NAME, dir, ip)         
        end   
    else
        disp('Nothing to do .....¦A·|£}£}');
    end
end