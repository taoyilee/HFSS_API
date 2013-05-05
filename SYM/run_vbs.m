function run_vbs()    
    dir = 'SYM_ct';
    addpath('..');
    init_hfssapi;		
    runAndExit = true ; 
    iconized = true ;    
    nowait = false;
    % Create a new temporary HFSS script file.	
    path = [dir '/*.vbs'];
    disp(['Listing all ' path ' .....']);
    file = ls(path);
    nfiles = size(file,1);
    if(nfiles >= 1)        
        for i=1:nfiles            
            cur_file = [dir '/' file(i,:)];            
            [~, name, ~] = fileparts(cur_file);           
            if(~exist(['G:\HFSS_SIMULATIONS\T65_SYM\' name '.hfss'],'file'))
                disp(['Procssing vbs -> ' cur_file  ' .....']);
                try                        
                    hfssExecuteScript(hfssExePath, cur_file, iconized,runAndExit,nowait);                
                catch e
                    disp(['*** Iteration failed->' cur_file]);
                    disp('Continuing ...');                       
                end
            else
                disp(['Skipping vbs -> ' cur_file  ' .....']);
            end
        end   
    else
        disp('Nothing to do .....¦A·|£}£}');
    end
    deinit_hfssapi;
end