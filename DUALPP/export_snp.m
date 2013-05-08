function export_snp(filename, tmpfile)    
    addpath('..');
    init_hfssapi;		
    runAndExit = true;     
    iconized = false ;    
    nowait = false; 
    [~, name, ~] = fileparts(filename);                    
    x = fileread('run.vbs');                                                
    x = regexprep(x, 'HFSS_FILENAME', name);       
    file_out = fopen(tmpfile,'w+') ;                                  
    fprintf(file_out,'%s',x);
    fclose(file_out);
    hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
    hfssExecuteScript(hfssExePath, tmpfile,iconized, runAndExit, nowait);  
    deinit_hfssapi;
end