function sn = t40_m2za_za_wh(tmpScriptFile, fid, OD, M11_W, M11_S, NT)
        var_fp =  [num2str(OD) ',' num2str(M11_W) ',' num2str(M11_S) ];
        param = hfssProcess(fid,'./t40me6X2Z.csv','./t40imd6X2Z.csv' ,'6X2Z', 'var_T40_ind', var_fp);
        %var_T40_ind(fid);
        hfssCreateVar(fid, 'VIA_H', '$M11_Z+$M11_T-($M9_Z+$M9_T)');
        disp(['Creating the Script File ...@ ' tmpScriptFile ]);       
        % hfss_indn(fid,X, Y, Z,  OD, S, NT, W, lead, Thickness1,Thickness2, material,serial)        
        sn = 0;
        sn = hfss_m2za_za(fid,'0' ,'0' ,'$M11_Z','$OD', '$M11_S', NT, '$M11_W', '$lead','$M9_T','$M11_T', '$VIA_H','T40_ME0d021', sn);
        projectname = ['G:\HFSS_SIMULATIONS\t40_m2za_za\' param 'NT' num2str(NT) '.hfss'];
        disp(['Project saved to ' projectname]);        
        hfssInsertSolution(fid, 'Setup30G', 24, 0.02, 25);
        hfssEditSolution(fid, 'Setup30G', '-1');
        hfssInterpolatingSweep(fid, 'SWP30G', 'Setup30G', 0.1, 30, 512, 30, 0.2);
        hfssSolveSetup(fid, 'Setup30G'); 
        
        % Export the Network data as an m-file.
        tmpDataFiles = ['G:\HFSS_SIMULATIONS\t40_m2za_za\m2za_za-' param 'NT' num2str(NT) '.s1p'];
        tmpDataFilem = ['G:\HFSS_SIMULATIONS\t40_m2za_za\m2za_za-' param 'NT' num2str(NT) '.mat'];
        hfssExportNetworkData(fid, tmpDataFiles, 'Setup30G', 'SWP30G','s');
        hfssExportNetworkData(fid, tmpDataFilem, 'Setup30G', 'SWP30G');
        hfssSaveProject(fid, projectname, true);
