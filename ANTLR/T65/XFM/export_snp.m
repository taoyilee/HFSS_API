function export_snp(filename, tmpfile, subdir)    
    addpath('..');
    init_hfssapi;		
    runAndExit = true;     
    iconized = false ;    
    nowait = false; 
    [~, name, ~] = fileparts(filename);               
%     try                        
        x = fileread('run.vbs');                                                
        x = regexprep(x, 'HFSS_FILENAME', name);   
        x = regexprep(x, 'SUBDIR', subdir);
        file_out = fopen(tmpfile,'w+') ;                                  
        fprintf(file_out,'%s',x);
        fclose(file_out);
        hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
        hfssExecuteScript(hfssExePath, tmpfile,iconized, runAndExit, nowait);
%     catch e
%         disp(['*** Iteration failed->' filename]);
%         disp('Continuing ...');                       
%     end      
    deinit_hfssapi;
end