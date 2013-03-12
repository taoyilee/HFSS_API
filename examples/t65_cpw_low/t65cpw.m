% CPW in CMOS 65 nm
clear all;
% add paths to the required m-files.
try
    addpath('..');
    init_hfssapi;	
	% runAndExit = false ; % debug
    runAndExit = true ;
    iconized = true ;    nowait = false; % true if your're NCHC
    serial = 0;
	outdir = 'G:\HFSS_SIMULATIONS\t65_cpw_low\';
    if(~exist(outdir,'dir'))
        mkdir(outdir);
    end
    M9_W = 4;
    % M9_S = 3:1:11;
    M9_S = 4:0.5:9;
    
    GND_H = 1.5;
    GND_F = 0.5;
    % M9_L = 10:5:100;
    M9_L = 15;
    dlmwrite([outdir 'summary.csv'], ...
		'W, S, L, dbS11(5.8G),dbS21(5.8G),dbS11(10.6G),dbS21(10.6G),dbS11(24G),dbS21(24G)','delimiter','');
	iter = 1;
	total = length(M9_W)*length(M9_S)*length(M9_L);
	time = 0;
    var_fp =  [num2str(M9_W(1)) ',' num2str(M9_S(1)) ',' num2str(M9_L(1))  ',' num2str(GND_H(1)) ',' num2str(GND_F(1))];
    if(~exist([outdir '/empty.hfss'],'file'))
        fid = fopen(tmpScriptFile, 'w+');    
        param = hfssProcess(fid,'../T65/t65me6X1Z1U.csv','../T65/IMD_6X1Z1UIMD_8g_IMD_9c.csv' ,'6X1Z1U', 'var_T65_cpw', var_fp,0,outdir);
        fclose(fid);
        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);
    end    
    for i=1:length(M9_W)
        for j=1:length(M9_S)
            for k=1:length(M9_L)                
                        tic; % start stopwatch
                        if(exist([outdir 'empty.hfss.lock'],'file'))
                            delete([outdir 'empty.hfss.lock'])
                        end
                        if(exist([outdir 'empty.hfss.auto'],'file'))
                            delete([outdir 'empty.hfss.auto'])
                        end
                        fid = fopen(tmpScriptFile, 'w+');
                        disp(['---- Interation #' num2str(iter) ' of ' num2str(total) ' (' ...
                            num2str(100*iter/total) '%) Starts ----']);                
                        disp(['ETA : ' num2str(((total-iter)*time)/3600) ' hours to finish']);
                        [tmpDataFiles replot] = t65cpw_wh(tmpScriptFile, fid, M9_W(i), M9_S(j), M9_L(k), GND_H(1), GND_F(1),outdir);    
                        % Close the HFSS Script File.
                        fclose(fid);
                        try
                            disp('Script received, simulation start ...');                        
                            hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);                        
                            plotS11S21(tmpDataFiles,M9_W(i), M9_S(j), M9_L(k), GND_H(1), GND_F(1), replot);
                            time = toc; % stop stopwatch
                            disp(['Time Elapsed : ' num2str(time/60) ' min.']); % report simulation time for current iter.                        
                            time = (time*iter + time)/(iter+1); % compute average simulation time
                        catch e
                            disp(['*** Iteration failed-> W' num2str(M9_W(i)) 'S' num2str(M9_S(j)) 'L' num2str(M9_L(k))]);
                            disp(['**** exception: ' e.message]);
                            disp('Continuing ...');
                            time = toc; % stop stopwatch
                            disp(['Time Elapsed : ' num2str(time/60) ' min.']); % report simulation time for current iter.                        
                            time = (time*iter + time)/(iter+1); % compute average simulation time
                        end
                        iter = iter + 1;
                        fclose all;
            end
        end
    end
    % remove all the added paths.
    deinit_hfssapi;
catch exception
    disp('**** Error Caught **** Stack =');
    disp('Caller Stack =');
    err = struct2cell(exception.stack);
    % Show Caller Stack 
    disp(err(2:3,:));
    % Show the error thrown
    disp(exception.message);
    % Close file
    fclose(fid);
    % Deinitialize paths
    deinit_hfssapi;
end