% Description:
% ------------
clear all;
% add paths to the required m-files.
try
    init_hfssapi;	
	runAndExit = false ;    iconized = true ;    nowait = false; % true if your're NCHC
    serial = 0;
    % Create a new temporary HFSS script file.	
	OD = 125; M11_W = 5;  M11_S = 2; NT =2;
    %for i=1:length(OD)
        fid = fopen(tmpScriptFile, 'w+');
        t40_m2za_za_wh(tmpScriptFile, fid, OD, M11_W, M11_S, NT);    
        % Close the HFSS Script File.
        fclose(fid);
        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);
    %end
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