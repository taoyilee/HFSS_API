% Description:
% ------------
clear all;
% add paths to the required m-files.
try
    addpath('..');
    init_hfssapi;		
    runAndExit = true ;
    tmpScriptFile = 'G:\temp\t65_ind_sym.vbs';
    % runAndExit = false ; % debug
    iconized = true ;    nowait = false; % true if your're NCHC
    serial = 0;
    % Create a new temporary HFSS script file.	
	% OD = 70:5:80; % :10:200; 
    OD = 90;
    % M11_W = 5;  M11_S = 2;
    M9_W = 2:1:5;  M9_S = 2:5;
    outdir = 'G:\HFSS_SIMULATIONS\t65_ind_sym\';
    if(~exist(outdir,'dir'))
        mkdir(outdir);
    end
    dlmwrite([outdir 'summary.csv'], ...
		'OD, W, S, NT, L(5.8G),Q(5.8G),L(10.6G),Q(10.6G),L(24G),Q(24G)','delimiter','');
	iter = 1;
	total = length(OD)*length(M9_W)*length(M9_S);
	time = 0;
    for i=1:length(OD)
        for j=1:length(M9_W)
             for k=1:length(M9_S)
                    tic; % start stopwatch
                    fid = fopen(tmpScriptFile, 'w+');
                    disp(['---- Interation #' num2str(iter) ' of ' num2str(total) ' (' ...
                        num2str(100*iter/total) '%) Starts ----']);                
                    disp(['ETA : ' num2str(((total-iter)*time)/3600) ' hours to finish']);
                    [tmpDataFiles replot] = t65ind_wh(tmpScriptFile, fid, OD(i), M9_W(j), M9_S(k),outdir);    
                    % Close the HFSS Script File.
                    fclose(fid);
                    try
                        disp('Script received, simulation start ...');                        
                        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait,'');                        
                        plotL(tmpDataFiles,OD(i), M9_W(j), M9_S(k), 2, replot);
                        time = toc; % stop stopwatch
                        disp(['Time Elapsed : ' num2str(time/60) ' min.']); % report simulation time for current iter.                        
                        time = (time*iter + time)/(iter+1); % compute average simulation time
                    catch e
                        disp(['*** Iteration failed-> OD' num2str(OD(i)) 'W' num2str(M9_W(j)) 'S' num2str(M9_S(k)) 'NT2']);
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