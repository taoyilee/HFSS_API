% Description:
% ------------
clear all;
% add paths to the required m-files.
try
    addpath('..');
    init_hfssapi;	
	%runAndExit = false ; % debug
    runAndExit = false ;
    iconized = true ;    nowait = false; % true if your're NCHC
    serial = 0;
    % Create a new temporary HFSS script file.	
	OD = 60:5:150; 
    M11_W = 5;  M11_S = 2;
    M9_W = 5;  M9_S = 2;
    %NT =1:3;
    NT =1;
	total = length(OD)*length(M11_W)*length(M11_S)*length(NT);
	time = 0;
	parentdir = 'G:\HFSS_SIMULATIONS\';
	outdir = [parentdir 't65_gsg\'];
    if(~exist([parentdir 't65_gsg'],'dir'))
        mkdir(parentdir, 't65_gsg');
    end
    var_fp =  [num2str(OD(1)) ',' num2str(M11_W(1)) ',' num2str(M11_S(1)) ',' num2str(NT(1))];
    if(~exist([outdir '/empty.hfss'],'file'))
        fid = fopen(tmpScriptFile, 'w+');    
        param = hfssProcess(fid,'../T65/t65me6X1Z1U.csv','../T65/t65imd6X1Z1U.csv' ,'6X1Z1U', 'var_T65_ind', var_fp,0,outdir);
        fclose(fid);
        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);
    end
    if(exist([outdir 'empty.hfss.lock'],'file'))
        delete([outdir 'empty.hfss.lock'])
    end
    if(exist([outdir 'empty.hfss.auto'],'file'))
        delete([outdir 'empty.hfss.auto'])
    end
	fid = fopen(tmpScriptFile, 'w+');      
    t65gsg_wh(tmpScriptFile, fid,outdir);    	
	fclose(fid); % Close the HFSS Script File.
	hfssExecuteScript(hfssExePath,tmpScriptFile,iconized,runAndExit,nowait);                  
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
