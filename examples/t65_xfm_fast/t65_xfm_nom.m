function t65_xfm_nom(tmpScriptFile, fid, OD, M9_WI,  M9_WO, M9_S,outdir)            
    projectname = [outdir 'nominal.hfss'];
    solfreq = 24; %  GHz
    swp = 40; % GHz
    swpname = ['SWP' num2str(swp) 'G'];
    solname = ['Setup' num2str(solfreq) 'G'];        
        if(exist([ projectname '.lock'],'file'))
            delete([ projectname '.lock'])
            disp(['removing '  projectname '.lock']);
        end
        if(exist([ projectname '.auto'],'file'))
            delete([ projectname '.auto'])
            disp(['removing '  projectname '.auto']);
        end                         
        if(~exist(projectname,'file'))         
            copyfile([outdir 'empty.hfss'], projectname)            
            hfssOpenProject(fid, projectname)
            hfssSetDesign(fid, 'BEOL_6X1Z1U');
            hfssSetEditor(fid, '3d Modeler')            
            hfssChangeVar(fid, 'OD', [num2str(OD) 'um']);
            hfssCreateVar(fid, 'L_OP', [num2str(10) 'um']);
            hfssCreateVar(fid, 'R_OP', [num2str(22) 'um']);      
            hfssChangeVar(fid, 'M9_WI',[num2str(M9_WI) 'um']);
            hfssChangeVar(fid, 'M9_WO',[num2str(M9_WO) 'um']);
            hfssChangeVar(fid, 'M9_S',[num2str(M9_S) 'um']);
            disp(['Creating the Script File ...@ ' tmpScriptFile ]);         
            serial = 0;
            hfss_xfmM9(fid,'0' ,'0' ,'$M9_Z','$M8_Z', '$M9_WI', '$M9_WO', '$M9_S', '$R_OP','$L_OP', '$OD','$M9_T','$M8_T', serial);       
            hfssSaveProject(fid, projectname, true);    
            hfssInsertSolution(fid, solname, solfreq, 0.02, 25);
            hfssEditSolution(fid, solname, '-1', solfreq, 0.02, 25);
            hfssInterpolatingSweep(fid, swpname, solname, 0.1, swp, 512, swp, 0.2);
            hfssSaveProject(fid, projectname, true);
            disp(['Nominal Case saved to ' projectname]);
        else
            disp(['Nominal Case Exists =>' projectname '....']);
        end        
end