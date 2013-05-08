function run_local(filename, N, DESIGN_NAME, hfss_path)    
    [path, name, ~] = fileparts(filename);           
    if(~exist([path '\' name '.s'  num2str(N) 'p'],'file'))
        disp(['Procssing -> ' filename  ' .....']);
        try                                   
            hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
            cmd = [hfssExePath ' -ng -Batchsolve -Local ' DESIGN_NAME '  "' filename '"'];
            disp(['COMMAND -> ' cmd]);
            [status, result] = system(cmd);
            disp([num2str(status) result]);
            export_snp(filename, N, DESIGN_NAME, hfss_path)  ;
        catch e
            disp(['*** Iteration failed (local)->' filename]);
            disp('Continuing ...');                       
        end
    else
        disp(['Skipping vbs -> ' filename  ' .....']);
    end      
end