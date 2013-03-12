function gen_s3p_all_wh(path1, file1,subdir)    
    nfiles1 = length(file1);
    for i=1:nfiles1
        [~, name, ~] = fileparts(file1(i,:));
        snp = [path1 '\' name '.s2p'];
        disp(['Procssing -> ' snp  ' .....']);
        if(~exist(snp,'file'))            
            try                                   
                export_snp(snp, 'run_em1.vbs',subdir); 
            catch e
                disp(['*** Iteration failed->' snp]);
                disp('Continuing ...');                       
            end
        else
            disp(['Skipping vbs -> ' snp  ' .....']);
        end      
    end    
end