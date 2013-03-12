function run_hfss_em1()    
    addpath('..');
    dir = 'G:\HFSS_SIMULATIONS\T65_XFM_HK_ANTLR\EM1';
    % Create a new temporary HFSS script file.	
    path = [dir '/*.hfss'];
    disp(['Listing all ' path ' .....']);
    file = ls(path);
    nfiles = size(file,1);
    if(nfiles >= 1)        
        for i=1:nfiles
            cur_file = [dir '\' file(i,:)];                           
            disp(['Delegating ' cur_file ' to EM1']);
            run_em1(cur_file)   
        end   
    else
        disp('Nothing to do .....¦A·|£}£}');
    end
end