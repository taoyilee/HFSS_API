function export_snp(filename, N, design, hfss_path)    
    addpath('..');    
    runAndExit = true;     
    iconized = false ;    
    nowait = false; 
    [~, name, ~] = fileparts(filename);                    
    vbsTemplate = [fileparts(mfilename('fullpath')) '\run.vbs'];
    disp(['*** ' datestr(now) '*** VBS_TEMPATE PATH = ' vbsTemplate]);
    x = fileread(vbsTemplate);                                                
    x = regexprep(x, 'HFSS_FILENAME', name);     
    disp(['*** ' datestr(now) '*** HFSS_PROJECT PATH = ' hfss_path]);
    x = regexprep(x, 'HFSS_DIR',  strrep(hfss_path, '\', '\\'));    
    x = regexprep(x, 'DESIGN_NAME', design);       
    x = regexprep(x, '<N>', num2str(N));          
    tmpfile = ['temp' name '.vbs'];
    file_out = fopen(tmpfile,'w+') ;                                  
    fprintf(file_out,'%s',x);
    fclose(file_out);
    hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
    try
        hfssExecuteScript(hfssExePath, tmpfile, iconized, runAndExit, nowait);      
        error(lastwarn)
        delete(tmpfile);
    catch e
        disp(['*** ' datestr(now) ' *** SNP export failed']);
        tmpLogFile = ['temp' name '.log'];
        logMessage = fileread(tmpLogFile);
        disp(['*** ' datestr(now) ' *** Log Message']);
        disp(logMessage);
        disp(e.Message);
        delete(tmpfile);
    end    
end