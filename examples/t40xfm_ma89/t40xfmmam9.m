% Description:
% ------------
clear all;
% add paths to the required m-files.
try
    addpath('..');
    init_hfssapi;
	runAndExit = true ;    iconized = true ;    nowait = false; % true if your're NCHC
    serial = 0;
    % Create a new temporary HFSS script file.	
	OD = 100:5:120;
    M11_W = 4;  M11_S = 2;
    M9_W = 4.25;  M9_S = 1.5;
    %dlmwrite('G:\HFSS_SIMULATIONS\t40xfmmam9\summary.csv', ...
	%	'OD, W, S, NT, L(5.8G),Q(5.8G),L(10.6G),Q(10.6G),L(24G),Q(24G)','delimiter','');
	iter = 1;
	total = length(OD)*length(M11_W)*length(M11_S);
	time = 0;
    outdir = 'G:\HFSS_SIMULATIONS\t40xfmma89\';
    var_fp =  [num2str(OD(1)) ',' num2str(M11_W(1)) ',' num2str(M11_S(1)) ];
    if(~exist([outdir '/empty.hfss'],'file'))
        fid = fopen(tmpScriptFile, 'w+');    
        param = hfssProcess(fid,'../T40/t40me6X2Z.csv','../T40/t40imd6X2Z.csv' ,'6X2Z', 'var_T40_xfm', var_fp,0,outdir);
        fclose(fid);
        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);
    end
    for i=1:length(OD)
        for j=1:length(M11_W)
            for k=1:length(M11_S)
                        tic; % start stopwatch
                    fid = fopen(tmpScriptFile, 'w+');
                    disp(['---- Interation #' num2str(iter) ' of ' num2str(total) ' (' ...
                        num2str(100*iter/total) '%) Starts ----']);                
                    disp(['ETA : ' num2str(((total-iter)*time)/3600) ' hours to finish']);
                    [tmpDataFiles replot] = t40xfmmam9_wh(tmpScriptFile, fid, OD(i), M11_W(j), M11_S(k), M9_W, M9_S, outdir);    
                    % Close the HFSS Script File.
                    fclose(fid);
                    try
                        disp('Script received, simulation start ...');                        
                        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);                        
                        %plotL(tmpDataFiles,OD(i), M11_W(j), M11_S(k),
                        %NT(l), replot);
                        time = toc; % stop stopwatch
                        disp(['Time Elapsed : ' num2str(time/60) ' min.']); % report simulation time for current iter.                        
                        time = (time*iter + time)/(iter+1); % compute average simulation time
                    catch e
                        disp(['*** Iteration failed-> OD' num2str(OD(i)) 'W' num2str(M11_W(j)) 'S' num2str(M11_S(k)) 'NT' num2str(NT(l))]);
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