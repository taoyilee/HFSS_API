% Description:
% ------------
clear all;
% add paths to the required m-files.
try
    init_hfssapi;
    runAndExit = false ;
    iconized = true ;
    nowait = true;
    serial = 0;
        lead = 20; OD = 100;
        encl = 30;
        h = 100;
        y0 = 0;
        z0 = 0;
        % Create a new temporary HFSS script file.
        fid = fopen(tmpScriptFile, 'wt');
        hfssProcess(fid,'./t40me7X2Z.csv','./t40imd.csv' ,'7X2Z',lead,OD,encl,y0,z0,h);      
        hfssCreateVar(fid, 'VIA_H', '$M11_Z+$M11_T-($M9_Z+$M9_T)');
        hfssCreateVar(fid, 'L_OP', [num2str(10) 'um']);
        hfssCreateVar(fid, 'R_OP', [num2str(22) 'um']);
        disp(['Creating the Script File ...@ ' tmpScriptFile ]);       
        % function hfss_xfm_halfud(fid,X , Y, Z, W, R_OP,L_OP, OD,Thickness)
        % serial = hfss_xfmN(fid,X , Y, Z, Z2, WI, WO, S, R_OP,L_OP, OD,Thickness,serial)
        serial = hfss_xfmN(fid,'0' ,'0' ,'$M11_Z','$M9_Z', '$WI', '$WO', '$M11_S', '$R_OP','$L_OP', '$OD','$M9_T','$M11_T', '$VIA_H', serial);
        projectname = ['./' mfilename(1) '.hfss'];
        disp(['Project saved to ' projectname]);
        
        hfssInsertSolution(fid, 'Setup30G', 24, 0.02, 25);
        hfssEditSolution(fid, 'Setup30G', '-1');
        hfssInterpolatingSweep(fid, 'SWP30G', 'Setup30G', 0.1, 30, 512, 30, 0.2);
        %hfssSolveSetup(fid, 'Setup30G'); 
        hfssSaveProject(fid, projectname, true);
        % Export the Network data as an m-file.
        %hfssExportNetworkData(fid, tmpDataFile, 'Setup150MHz', 'Sweep100to200MHz');
        % Close the HFSS Script File.
        fclose(fid);
        hfssExecuteScript(hfssExePath, tmpScriptFile,iconized,runAndExit,nowait);
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