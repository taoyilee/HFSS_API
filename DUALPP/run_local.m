function run_local(filename)    
    [path, name, ~] = fileparts(filename);           
    if(~exist([path '\' name '.s3p'],'file'))
        disp(['Procssing -> ' filename  ' .....']);
        try                                   
            hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
            cmd = [hfssExePath ' -ng -Batchsolve -Local ind_dualp  "' filename '"'];
            disp(['COMMAND -> ' cmd]);
            [status, result] = system(cmd);
            disp([num2str(status) result]);
            export_snp(filename, 'run_local.vbs')  ;
        catch e
            disp(['*** Iteration failed (local)->' filename]);
            disp('Continuing ...');                       
        end
    else
        disp(['Skipping vbs -> ' filename  ' .....']);
    end      
end