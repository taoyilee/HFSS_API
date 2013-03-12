function [tmpDataFiles replot] = dual_fr4_wh(tmpScriptFile, fid, W,outdir)        
    param = ['W' num2str(W)];
    projectname = [outdir param '.hfss'];        
    tmpDataFiles = [outdir 'TL-' param '.s2p'];
    tmpDataFilem = [outdir 'TL-' param '.mat'];                
    solfreq = 24; %  GHz
    swp = 40; % GHz
    swpname = 'SWP';
    solname = 'Setup';
    disp(['Creating the VBS control File ...@ ' tmpScriptFile ]); 
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
            copyfile([outdir 'nominal.hfss'], projectname)            
            hfssOpenProject(fid, projectname)
            hfssSetDesign(fid, 'design');
            hfssSetEditor(fid, '3d Modeler')            
            hfssChangeVar(fid, 'LineW', [num2str(W) 'mil']);           
            hfssSaveProject(fid, projectname, true);
            hfssSolveSetup(fid, solname); 
            hfssSaveProject(fid, projectname, true);
            disp(['Project saved to ' projectname]);        
            % Export the Network data as an m-file.
            hfssExportNetworkData(fid, tmpDataFiles, solname, swpname,'s');
            hfssExportNetworkData(fid, tmpDataFilem, solname, swpname);    
            hfssSaveProject(fid, projectname, true);
            replot = 1;
        else
            hfssOpenProject(fid, projectname)
            hfssSetDesign(fid, 'design');
            hfssSetEditor(fid, '3d Modeler');
            hfssSolveSetup(fid, solname); 
            hfssSaveProject(fid, projectname, true);
            disp(['Project saved to ' projectname]);        
            % Export the Network data as an m-file.
            hfssExportNetworkData(fid, tmpDataFiles, solname, swpname,'s');
            hfssExportNetworkData(fid, tmpDataFilem, solname, swpname); 
            replot = 1;
        end        
    else
        disp(['Solution data ' tmpDataFiles ' exists, skipping HFSS.....(delete ' tmpDataFiles ' to force re-simulation)']);
        replot = 0;
    end
end