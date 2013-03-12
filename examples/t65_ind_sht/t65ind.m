% Description:
% ------------
clear all;
% add paths to the required m-files.
try
    addpath('..');
    init_hfssapi;	
	% runAndExit = false ; % debug
    runAndExit = true ;
    iconized = true ;    nowait = false; % true if your're NCHC
    serial = 0;
    % Create a new temporary HFSS script file.	
	OD = 60:5:150; 
    % M11_W = 5;  M11_S = 2;
    M9_W = 3:1:5;  M9_S = 4:5;
    % NT =1:3;
    NT = 1:3;
    outdir = 'G:\HFSS_SIMULATIONS\t65_ind_sheet\';
    if(~exist(outdir,'dir'))
        mkdir(outdir);
    end
    dlmwrite([outdir 'summary.csv'], ...
		'OD, W, S, NT, L(5.8G),Q(5.8G),L(10.6G),Q(10.6G),L(24G),Q(24G)','delimiter','');
	iter = 1;
	total = length(OD)*length(M9_W)*length(M9_S)*length(NT);
	time = 0;
	
    var_fp =  [num2str(OD(1)) ',' num2str(M9_W(1)) ',' num2str(M9_S(1)) ',' num2str(NT(1))  ];
    if(~exist([outdir '/empty.hfss'],'file'))
        fid = fopen(tmpScriptFile, 'w+');    
        param = hfssProcess(fid,'../T65/t65me6X1Z1U.csv','../T65/IMD_6X1Z1UIMD_8g_IMD_9c.csv' ,'6X1Z1U', 'var_T65_ind', var_fp,0,outdir);
        fclose(fid);
        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);
    end
    
    for i=1:length(OD)
        for j=1:length(M9_W)
            for k=1:length(M9_S)
                for l=1:length(NT)
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
                        [tmpDataFiles replot] = t65ind_sht_wh(tmpScriptFile, fid, OD(i), M9_W(j), M9_S(k), NT(l),outdir);    
                        % Close the HFSS Script File.
                        fclose(fid);
                        try
                            disp('Script received, simulation start ...');                        
                            hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);                        
                            plotL(tmpDataFiles,OD(i), M9_W(j), M9_S(k), NT(l), replot);
                            time = toc; % stop stopwatch
                            disp(['Time Elapsed : ' num2str(time/60) ' min.']); % report simulation time for current iter.                        
                            time = (time*iter + time)/(iter+1); % compute average simulation time
                        catch e
                            disp(['*** Iteration failed-> OD' num2str(OD(i)) 'W' num2str(M9_W(j)) 'S' num2str(M9_S(k)) 'NT' num2str(NT(l))]);
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