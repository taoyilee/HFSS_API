function [tmpDataFiles replot] = t40ind_wh(tmpScriptFile, fid, OD, M11_W, M11_S, NT)
        outdir = 'G:\HFSS_SIMULATIONS\t40_ind\';
        param = ['D' num2str(OD) 'W' num2str(M11_W) 'S' num2str(M11_S)];
        tmpDataFiles = [outdir 'L-' param 'NT' num2str(NT) '.s1p'];
        tmpDataFilem = [outdir 'L-' param 'NT' num2str(NT) '.mat'];
    if(~exist(tmpDataFiles,'file'))
        var_fp =  [num2str(OD) ',' num2str(M11_W) ',' num2str(M11_S) ];
        param = hfssProcess(fid,'./t40me6X2Z.csv','./t40imd6X2Z.csv' ,'6X2Z', 'var_T40_ind', var_fp);
        %var_T40_ind(fid);
        hfssCreateVar(fid, 'VIA_H', '$M11_Z+$M11_T-($M9_Z+$M9_T)');
        disp(['Creating the Script File ...@ ' tmpScriptFile ]);       
        % hfss_indn(fid,X, Y, Z,  OD, S, NT, W, lead, Thickness1,Thickness2, material,serial)        
        sn = 0;
        sn = hfss_indn(fid,'0' ,'0' ,'$M11_Z','$OD', '$M11_S', NT, '$M11_W', '$lead','$M9_T','$M11_T', '$VIA_H','T40_ME0d021', sn);
        projectname = [outdir param 'NT' num2str(NT) '.hfss'];

        hfssInsertSolution(fid, 'Setup30G', 24, 0.02, 25);
        hfssEditSolution(fid, 'Setup30G', '-1');
        hfssInterpolatingSweep(fid, 'SWP30G', 'Setup30G', 0.1, 30, 512, 30, 0.2);
        hfssSolveSetup(fid, 'Setup30G'); 
        hfssSaveProject(fid, projectname, true);
        disp(['Project saved to ' projectname]);        
        % Export the Network data as an m-file.
        hfssExportNetworkData(fid, tmpDataFiles, 'Setup30G', 'SWP30G','s');
        hfssExportNetworkData(fid, tmpDataFilem, 'Setup30G', 'SWP30G');    
        replot = 1;
    else
        disp(['Solution data ' tmpDataFiles ' exists, skipping.']);
        replot = 0;
    end