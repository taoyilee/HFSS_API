function [tmpDataFiles replot sn] = t65_THz_ind_wh(tmpScriptFile, fid, M9_W, M9_S,M9_L, GND_H, GND_F,outdir)
    param = ['W' num2str(M9_W) 'S' num2str(M9_S) 'L' num2str(M9_L) 'H' num2str(GND_H) 'F' num2str(GND_F)];
    tmpDataFiles = [outdir 'CPW-' param '.s2p'];
    tmpDataFilem = [outdir 'CPW-' param '.mat'];
    solfreq = 300.0; % in gigahertz
    setup_name = ['Setup' num2str(solfreq) 'G'];
    sweep_name = ['Sweep' num2str(solfreq) 'G'];
    if(~exist(tmpDataFiles,'file'))
        projectname = [outdir param '.hfss'];        
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
            hfssSaveProject(fid, projectname, true);
            
            hfssChangeVar(fid, 'M9_W',[num2str(M9_W) 'um']);
            hfssChangeVar(fid, 'M9_S',[num2str(M9_S) 'um']);
            hfssChangeVar(fid, 'M9_L',[num2str(M9_L) 'um']);            
            hfssChangeVar(fid, 'GND_H',[num2str(GND_H) 'um']);
            hfssChangeVar(fid, 'GND_F',[num2str(GND_F) 'um']);
            disp(['Creating the Script File ...@ ' tmpScriptFile ]);                   
            sn = 0;
            sn = hfss_cpwn(fid,'$M9_W', '$M9_S','$M9_L','$GND_H', '$GND_F', sn);
            hfssInsertSolution(fid, setup_name, solfreq, 0.02, 25);
            hfssEditSolution(fid, setup_name, '-1', solfreq, 0.02, 25);
            hfssInterpolatingSweep(fid, sweep_name, setup_name, solfreq-50, solfreq+50, 512, 30, 0.2);
            hfssSaveProject(fid, projectname, true);
        else
            hfssOpenProject(fid, projectname)
            hfssSetDesign(fid, 'BEOL_6X1Z1U');
            hfssSetEditor(fid, '3d Modeler');
            hfssSaveProject(fid, projectname, true);
        end
        
        hfssSolveSetup(fid, setup_name); 
        hfssSaveProject(fid, projectname, true);
        disp(['Project saved to ' projectname]);        
        % Export the Network data as an m-file.
        hfssExportNetworkData(fid, tmpDataFiles, setup_name, sweep_name,'s');
        hfssExportNetworkData(fid, tmpDataFilem, setup_name, sweep_name);    
        replot = 1;
    else
        disp(['Solution data ' tmpDataFiles ' exists, skipping.']);
        replot = 1;
    end