function [tmpDataFiles replot sn] = t65ind_wh(tmpScriptFile, fid, OD, M9_W, M9_S, NT,outdir)
        param = ['D' num2str(OD) 'W' num2str(M9_W) 'S' num2str(M9_S)];
        tmpDataFiles = [outdir 'L-' param 'NT' num2str(NT) '.s1p'];
        tmpDataFilem = [outdir 'L-' param 'NT' num2str(NT) '.mat'];
    if(~exist(tmpDataFiles,'file'))
        projectname = [outdir param 'NT' num2str(NT) '.hfss'];        
        if(exist([ projectname '.lock'],'file'))
            delete([ projectname '.lock'])
            disp(['removing '  projectname '.lock']);
        end
        if(exist([ projectname '.auto'],'file'))
            delete([ projectname '.auto'])
            disp(['removing '  projectname '.auto']);
        end

        if(~exist(projectname,'file'))         
            hfssOpenProject(fid, [outdir 'empty.hfss'])
            hfssSetDesign(fid, 'BEOL_6X1Z1U');
            hfssSetEditor(fid, '3d Modeler')
            % hfssCreateVar(fid, 'VIA_H', '$M11_Z+$M11_T-($M9_Z+$M9_T)');            
            hfssChangeVar(fid, 'OD', [num2str(OD) 'um']);
            hfssCreateVar(fid, 'M9_W',[num2str(M9_W) 'um']);
            hfssCreateVar(fid, 'M9_S',[num2str(M9_S) 'um']);
            hfssChangeVar(fid, 'NT',num2str(NT));            
            disp(['Creating the Script File ...@ ' tmpScriptFile ]);       
            % hfss_indn(fid,X, Y, Z,  OD, S, NT, W, lead, Thickness1,Thickness2, material,serial)        
            sn = 0;
            sn = hfss_indn(fid,'0' ,'0' ,'$M9_Z','$OD', '$M9_S', NT, '$M9_W', '$lead',  sn);
            hfssInsertSolution(fid, 'Setup40G', 24, 0.02, 25);
            hfssEditSolution(fid, 'Setup40G', '-1');
            hfssInterpolatingSweep(fid, 'SWP40G', 'Setup40G', 0.1, 40, 512, 40, 0.2);
            hfssSaveProject(fid, projectname, true);
        else
            hfssOpenProject(fid, projectname)
            hfssSetDesign(fid, 'BEOL_6X1Z1U');
            hfssSetEditor(fid, '3d Modeler');
        end
        
        hfssSolveSetup(fid, 'Setup40G'); 
        hfssSaveProject(fid, projectname, true);
        disp(['Project saved to ' projectname]);        
        % Export the Network data as an m-file.
        hfssExportNetworkData(fid, tmpDataFiles, 'Setup40G', 'SWP40G','s');
        hfssExportNetworkData(fid, tmpDataFilem, 'Setup40G', 'SWP40G');    
        replot = 1;
    else
        disp(['Solution data ' tmpDataFiles ' exists, skipping.']);
        replot = 1;
    end