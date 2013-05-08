function run_vbs(vbs_dir, out_dir)         
    addpath('..');    	
    runAndExit = true ; 
    iconized = false ;    
    nowait = false;
    % Create a new temporary HFSS script file.	
    path = [vbs_dir '/*.vbs'];
    disp(['Listing all ' path ' .....']);
    file = ls(path);
    nfiles = size(file,1);
    if(nfiles >= 1)        
        for i=1:nfiles            
            cur_file = [vbs_dir '\' file(i,:)];            
            [~, name, ~] = fileparts(cur_file);           
            if(~exist([out_dir '\' name '.hfss'],'file'))
                disp(['Procssing vbs -> ' cur_file  ' .....']);
                try                        
                    hfssExecuteScript('"C:\Program Files\Ansoft\HFSS14.0\Win64\hfss.exe"', ...
                        cur_file, iconized,runAndExit,nowait);                
                catch e
                    disp(['*** Iteration failed->' cur_file]);
                    disp(e.message)                    
                    disp('Continuing ...');                       
                end
            else
                disp(['Skipping vbs -> ' cur_file  ' .....']);
            end
        end   
    else
        disp('Nothing to do .....¦A·|£}£}');
    end    
end