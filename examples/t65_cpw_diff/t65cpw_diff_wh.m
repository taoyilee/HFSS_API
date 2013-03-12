function [tmpDataFiles replot sn] = t65cpw_diff_wh(tmpScriptFile, fid, M9_W, M9_GS,M9_SS,M9_L, GND_H, GND_F,outdir)
    param = ['W' num2str(M9_W) 'GS' num2str(M9_GS) 'SS' num2str(M9_SS)  'L' num2str(M9_L) 'H' num2str(GND_H) 'F' num2str(GND_F)];
    tmpDataFiles = [outdir 'CPWDIFF-' param '.s4p'];
    tmpDataFilem = [outdir 'CPWDIFF-' param '.mat'];
    solfreq = 24; %  GHz
    swp = 40; % GHz
    swpname = ['SWP' num2str(swp) 'G'];
    solname = ['Setup' num2str(solfreq) 'G'];
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
                        
            hfssChangeVar(fid, 'M9_W',[num2str(M9_W) 'um']);
            hfssChangeVar(fid, 'M9_GS',[num2str(M9_GS) 'um']);
            hfssChangeVar(fid, 'M9_SS',[num2str(M9_SS) 'um']);
            hfssChangeVar(fid, 'M9_L',[num2str(M9_L) 'um']);            
            hfssChangeVar(fid, 'GND_H',[num2str(GND_H) 'um']);
            hfssChangeVar(fid, 'GND_F',[num2str(GND_F) 'um']);
            disp(['Creating the Script File ...@ ' tmpScriptFile ]);     
            hfssSaveProject(fid, projectname, true);
            sn = 0;
            sn = hfss_cpwn(fid,'$M9_W', '$M9_GS','$M9_SS','$M9_L','$GND_H', '$GND_F', sn);
            hfssInsertSolution(fid, solname, solfreq, 0.02, 25);
            hfssEditSolution(fid, solname, '-1', solfreq, 0.02, 25);
            hfssInterpolatingSweep(fid, swpname, solname, 0.1, swp, 512, 30, 0.2);
            hfssSaveProject(fid, projectname, true);
        else
            hfssOpenProject(fid, projectname)
            hfssSetDesign(fid, 'BEOL_6X1Z1U');
            hfssSetEditor(fid, '3d Modeler');
        end
        
        hfssSolveSetup(fid, solname); 
        hfssSaveProject(fid, projectname, true);
        disp(['Project saved to ' projectname]);        
        % Export the Network data as an m-file.
        hfssExportNetworkData(fid, tmpDataFiles, solname, swpname,'s');
        hfssExportNetworkData(fid, tmpDataFilem, solname, swpname);    
        replot = 1;
    else
        disp(['Solution data ' tmpDataFiles ' exists, skipping.']);
        replot = 1;
    end