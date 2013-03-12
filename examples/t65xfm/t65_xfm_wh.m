function [tmpDataFiles replot] = t65_xfm_wh(tmpScriptFile, fid, OD, M9_W, M9_S,outdir)        
    param = ['D' num2str(OD) 'W' num2str(M9_W) 'S' num2str(M9_S)];
    projectname = [outdir param '.hfss'];        
    tmpDataFiles = [outdir 'XFM-' param '.s4p'];
    tmpDataFilem = [outdir 'XFM-' param '.mat'];                
    solfreq = 24; %  GHz
    swp = 40; % GHz
    swpname = ['SWP' num2str(swp) 'G'];
    solname = ['Setup' num2str(solfreq) 'G'];
    
    if(~exist(tmpDataFiles,'file'))         
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
            hfssChangeVar(fid, 'OD', [num2str(OD) 'um']);
            hfssCreateVar(fid, 'L_OP', [num2str(10) 'um']);
            hfssCreateVar(fid, 'R_OP', [num2str(22) 'um']);      
            hfssChangeVar(fid, 'M9_W',[num2str(M9_W) 'um']);
            hfssChangeVar(fid, 'M9_S',[num2str(M9_S) 'um']);
            disp(['Creating the Script File ...@ ' tmpScriptFile ]);         
            serial = 0;
            hfss_xfmM9(fid,'0' ,'0' ,'$M9_Z','$M8_Z', '$WI', '$WO', '$M9_S', '$R_OP','$L_OP', '$OD','$M9_T','$M8_T', '$M9_T', serial);       
            hfssInsertSolution(fid, solname, 24, 0.02, 25);
            hfssEditSolution(fid, solname, '-1', 24, 0.02, 25);
            hfssInterpolatingSweep(fid, swpname, solname, 0.1, 30, 512, 30, 0.2);
            hfssSaveProject(fid, projectname, true);
            hfssSolveSetup(fid, solname); 
            hfssSaveProject(fid, projectname, true);
            disp(['Project saved to ' projectname]);        
            % Export the Network data as an m-file.
            hfssExportNetworkData(fid, tmpDataFiles, solname, swpname,'s');
            hfssExportNetworkData(fid, tmpDataFilem, solname, swpname);    
            replot = 1;
        else
            hfssOpenProject(fid, projectname)
            hfssSetDesign(fid, 'BEOL_6X1Z1U');
            hfssSetEditor(fid, '3d Modeler');
            replot = 1;
        end        
    else
        disp(['Solution data ' tmpDataFiles ' exists, skipping HFSS.....(delete ' tmpDataFiles ' to force re-simulation)']);
        replot = 0;
    end
end