function run_em1(filename)    
    [path, name, ~] = fileparts(filename);           
    if(~exist([path '\' name '.s3p'],'file'))
        disp(['Procssing -> ' filename  ' .....']);
        try                                   
            hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
            cmd = [hfssExePath ' -ng  -Batchsolve -Remote -machinelist list="140.113.218.38"  '...
            'BEOL6X1Z1U  "' filename '"'];
            disp(['COMMAND -> ' cmd]);
            [status, result] = system(cmd);
            disp([num2str(status) result]);
            export_snp(filename, 'run_em1.vbs','EM1'); 
        catch e
            disp(['*** Iteration failed->' filename]);
            disp('Continuing ...');                       
        end
    else
        disp(['Skipping vbs -> ' filename  ' .....']);
    end      
end