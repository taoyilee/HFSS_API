function export_snp(filename, tmpfile, subdir)    
    addpath('..');
    init_hfssapi;		
    runAndExit = 0;     
    iconized = false ;    
    nowait = false; 
    [~, name, ~] = fileparts(filename);                    
    x = fileread('run.vbs');                                                
    x = regexprep(x, 'HFSS_FILENAME', name);   
    x = regexprep(x, 'SUBDIR', subdir);
    delete(['G:\HFSS_SIMULATIONS\T65_SYM_CT\' subdir '/' name '.lock']);
    file_out = fopen(tmpfile,'w+') ;                                  
    fprintf(file_out,'%s',x);
    fclose(file_out);
    hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
    hfssExecuteScript(hfssExePath, tmpfile,iconized, runAndExit, nowait);  
    deinit_hfssapi;
end