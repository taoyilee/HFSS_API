% Description:
% ------------
clear all;
% add paths to the required m-files.
try
    addpath('..');
    init_hfssapi;		
    runAndExit = true ; 
    % runAndExit = false ; % debug
    iconized = true ;
    tmpScriptFile = 'E:\temp\dualfr4.vbs';
    nowait = false; % true if your're NCHC
    serial = 0;
    % Create a new temporary HFSS script file.	
    W = 10:20;

    % dlmwrite('G:\HFSS_SIMULATIONS\t65_xfm\summary.csv', ...
	%	'OD, W, S, NT, L(5.8G),Q(5.8G),L(10.6G),Q(10.6G),L(24G),Q(24G)','delimiter','');
	iter = 1;
	total = length(W);
	time = 0;
	outdir = 'E:\HFSS_SIMULATIONS\Dual_FR4\';
    if(~exist(outdir,'dir'))
        mkdir(outdir);
    end
    fid = fopen(tmpScriptFile, 'w+');  
    fclose(fid);    
    hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);            
	iter = 1;
	total = length(W);
	time = 0;
    for i=1:length(W)   
        tic; % start stopwatch                   
                    fid = fopen(tmpScriptFile, 'w+');
                    disp(['---- Interation #' num2str(iter) ' of ' num2str(total) ' (' ...
                    num2str(100*iter/total) '%) Starts ----']);                
                    disp(['ETA : ' num2str(((total-iter)*time)/3600) ' hours to finish']);
                    [tmpDataFiles replot] = dual_fr4_wh(tmpScriptFile, fid, W(i), outdir);    
                    % Close the HFSS Script File.
                    fclose(fid);
                    try
                        disp('Script received, simulation start ...');                        
                        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);                      
                        time = toc; % stop stopwatch
                        disp(['Time Elapsed : ' num2str(time/60) ' min.']); % report simulation time for current iter.                        
                        time = (time*iter + time)/(iter+1); % compute average simulation time
                    catch e
                        disp(['*** Iteration failed->W' num2str(W(i))]);
                        disp('Continuing ...');
                        time = toc; % stop stopwatch
                        disp(['Time Elapsed : ' num2str(time/60) ' min.']); % report simulation time for current iter.                        
                        time = (time*iter + time)/(iter+1); % compute average simulation time
                    end
                    iter = iter + 1;
                    fclose all;
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