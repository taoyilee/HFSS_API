function [tmpDataFiles replot] = t40xfmmam9_wh(tmpScriptFile, fid, OD, M11_W, M11_S, M9_W, M9_S, outdir)
        param = ['D' num2str(OD) 'W' num2str(M11_W) 'S' num2str(M11_S)];
        tmpDataFiles = [outdir 'XFM-' param '.s4p'];
        tmpDataFilem = [outdir 'XFM-' param '.mat'];
    if(~exist(tmpDataFiles,'file')) 
        projectname = [outdir param '.hfss'];
        if(~exist(projectname,'file')) 
            hfssOpenProject(fid, [outdir 'empty.hfss'])
            hfssSetDesign(fid, 'BEOL_6X2Z');
            hfssSetEditor(fid, '3d Modeler');
            hfssChangeVar(fid, 'OD', [num2str(OD) 'um']);
            hfssChangeVar(fid, 'M11_W',[num2str(M11_W) 'um']);
            hfssChangeVar(fid, 'M11_S',[num2str(M11_S) 'um']);
            hfssCreateVar(fid, 'M9_W',[num2str(M9_W) 'um']);
            hfssCreateVar(fid, 'M9_S',[num2str(M9_S) 'um']);
            hfssCreateVar(fid, 'L_OP', [num2str(10) 'um']);
            hfssCreateVar(fid, 'R_OP', [num2str(22) 'um']);
            disp(['Creating the Script File ...@ ' tmpScriptFile ]);       
            serial = 0;
            hfss_xfmmam9N(fid,'0' ,'0' ,'$M11_Z','$M9_Z', '$WI', '$WO', '$M11_S', '$R_OP','$L_OP', '$OD','$M9_T','$M11_T', '$VIA9_T', serial);
            hfssInsertSolution(fid, 'Setup30G', 24, 0.02, 25);
            hfssEditSolution(fid, 'Setup30G', '-1');
            hfssInterpolatingSweep(fid, 'SWP30G', 'Setup30G', 0.1, 30, 512, 30, 0.2);
            hfssSaveProject(fid, projectname, true);
        else
            hfssOpenProject(fid, projectname)
            hfssSetDesign(fid, 'BEOL_6X2Z');
            hfssSetEditor(fid, '3d Modeler');
        end
        hfssSolveSetup(fid, 'Setup30G'); 
        hfssSaveProject(fid, projectname, true);
        disp(['Project saved to ' projectname]);        
        % Export the Network data as an m-file.
        hfssExportNetworkData(fid, tmpDataFiles, 'Setup30G', 'SWP30G','s');
        hfssExportNetworkData(fid, tmpDataFilem, 'Setup30G', 'SWP30G');    
        hfssSaveProject(fid, projectname, true);
        replot = 1;
    else
        disp(['Solution data ' tmpDataFiles ' exists, skipping.']);
        replot = 0;
    end
end