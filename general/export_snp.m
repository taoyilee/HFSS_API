function export_snp(filename, N, design, hfss_path)    
    addpath('..');    
    runAndExit = true;     
    iconized = false ;    
    nowait = false; 
    [~, name, ~] = fileparts(filename);                    
    x = fileread('run.vbs');                                                
    x = regexprep(x, 'HFSS_FILENAME', name);     
    disp(['HFSS_PROJECT PATH = ' hfss_path]);
    x = regexprep(x, 'HFSS_DIR',  strrep(hfss_path, '\', '\\'));    
    x = regexprep(x, 'DESIGN_NAME', design);       
    x = regexprep(x, '<N>', num2str(N));          
    tmpfile = ['temp' name '.vbs'];
    file_out = fopen(tmpfile,'w+') ;                                  
    fprintf(file_out,'%s',x);
    fclose(file_out);
    hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
    hfssExecuteScript(hfssExePath, tmpfile, iconized, runAndExit, nowait);      
    delete(tmpfile);
end