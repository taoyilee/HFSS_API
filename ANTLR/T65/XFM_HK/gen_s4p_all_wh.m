function gen_s4p_all_wh(path1, file1,subdir)    
    nfiles1 = length(file1);
    try
        for i=1:nfiles1
            [~, name, ~] = fileparts(file1(i,:));
            snp = [path1 '\' name '.s4p'];
            disp(['Procssing -> ' snp  ' .....']);
            if(~exist(snp,'file'))            
                export_snp(snp, 'run_em1.vbs',subdir); 
            else
                disp(['Skipping vbs -> ' snp  ' .....']);
            end      
        end    
    catch e
        disp(['*** Iteration failed->' snp]);
        disp('Continuing ...');                       
    end
end