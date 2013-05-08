function run_em(filename, N, DESIGN_NAME, hfss_path, machine)
    [path, name, ext] = fileparts(filename);           
    if(~exist([path '\' name '.s' num2str(N) 'p'],'file'))
        disp(['Procssing -> ' filename  ' .....']);
        try                                   
            hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
            cmd = [hfssExePath ' -ng -Remote -machinelist list="' machine '"   '...
            ' -batchsolve ' DESIGN_NAME '  "' path '\' name '.hfss"'];            
            disp(['COMMAND -> ' cmd]);
            [status, result] = system(cmd);
            disp([num2str(status) result]);
            export_snp(filename, N, DESIGN_NAME, hfss_path)  ;
        catch e
            disp(['*** Iteration failed->' filename]);
            disp(e.message)
            disp('Continuing ...');                       
        end
%     else
%         disp(['Skipping vbs -> ' filename  ' .....']);
    end      
end