function export_snp(filename, N, design, hfss_path)    
    addpath('..');    
    runAndExit = true;     
    iconized = false ;    
    nowait = false; 
    [~, name, ~] = fileparts(filename);          
    lockfile = [hfss_path '\' name '.hfss.lock'];
    if(exist([hfss_path '\' name '.hfss.lock'],'file'))
        disp(['*** ' datestr(now) ' *** deleting lockfile -> ' lockfile]);
        delete(lockfile);
    end
    vbsTemplate = [fileparts(mfilename('fullpath')) '\run.vbs'];
    disp(['*** ' datestr(now) ' *** VBS_TEMPATE PATH = ' vbsTemplate]);
    x = fileread(vbsTemplate);                                                
    x = regexprep(x, 'HFSS_FILENAME', name);     
    disp(['*** ' datestr(now) ' *** HFSS_PROJECT PATH = ' hfss_path]);
    x = regexprep(x, 'HFSS_DIR',  strrep(hfss_path, '\', '\\'));    
    x = regexprep(x, 'DESIGN_NAME', design);       
    x = regexprep(x, '<N>', num2str(N));          
    tmpfile = ['temp' name '.vbs'];    
    file_out = fopen(tmpfile,'w+') ;                                  
    fprintf(file_out,'%s',x);    
    fclose(file_out);
    disp(['*** ' datestr(now) ' *** SNP Export script']);
    disp(strtrim(fileread(tmpfile)));
    disp(['*** ' datestr(now) ' *** SNP Export script (END)']);
    hfssExePath = '"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"';
    
%     try
        hfssExecuteScript(hfssExePath, [pwd '\' tmpfile], iconized, runAndExit, nowait);      
        % error(lastwarn)        
        if(~exist([path '\' name '.s' num2str(N) 'p'],'file'))        
            disp(['*** ' datestr(now) ' *** SNP Export Failed'])
        end
%     catch e
%         disp(['*** ' datestr(now) ' *** SNP export failed']);
%         tmpLogFile = ['temp' name '.log'];
%         logMessage = fileread(tmpLogFile);
%         disp(['*** ' datestr(now) ' *** Log Message']);
%         disp(strtrim(logMessage));
%         disp(e.Message);    
%     end    
    %delete(tmpfile);            
end