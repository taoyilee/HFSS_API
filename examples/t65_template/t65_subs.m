% Description:
% ------------
clear all;
% add paths to the required m-files.

    addpath('..');
    init_hfssapi;	
	% runAndExit = false ; % debug
    runAndExit = true ;
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
	outdir = 'G:\HFSS_SIMULATIONS\t65_templates_new\';
    if(~exist(outdir,'dir'))
        mkdir(outdir);
    end
    var_fp =  [num2str(OD(1)) ',' num2str(M11_W(1)) ',' num2str(M11_S(1)) ',' num2str(NT(1))  ];    
        csvfile = ls('../T65/t65imd6X1Z1U.csv');
       
         
         fid = fopen(tmpScriptFile, 'w+');      
            param = hfssProcess(fid,'../T65/t65me6X1Z1U.csv','../T65/t65imd6X1Z1U.csv','6X1Z1U', 'var_T65_ind', var_fp,0,outdir, 't65imd6X1Z1U.hfss');
            fclose(fid);
            hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);
        

    % remove all the added paths.
    deinit_hfssapi;

