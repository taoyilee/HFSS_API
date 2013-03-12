function t65ind_nom(tmpScriptFile, fid, OD, NT, M9_W, M9_S,outdir)
    solfreq = 24; %  GHz
    swp = 40; % GHz
    swpname = ['SWP' num2str(swp) 'G'];
    solname = ['Setup' num2str(solfreq) 'G'];        
    projectname = [outdir 'nominal.hfss'];
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
        % hfssCreateVar(fid, 'VIA_H', '$M11_Z+$M11_T-($M9_Z+$M9_T)');            
        hfssChangeVar(fid, 'OD', [num2str(OD) 'um']);
        hfssChangeVar(fid, 'M9_W',[num2str(M9_W) 'um']);
        hfssChangeVar(fid, 'M9_S',[num2str(M9_S) 'um']);
        hfssCreateVar(fid, 'M9_P',  '$M9_W+$M9_S');
        hfssCreateVar(fid, 'VIA_W', [num2str(2)  'um']);
        hfssCreateVar(fid, 'LEAD_X', '$OD');
        hfssCreateVar(fid, 'LEAD_L', '$lead+$M9_P');
        hfssCreateVar(fid, 'VIA_ENC', '($M9_W - $VIA_W)/2');
        hfssCreateVar(fid, 'PORT_H', '$M9_T');
        hfssChangeVar(fid, 'NT',num2str(NT));            
        disp(['Creating the Script File ...@ ' tmpScriptFile ]);       
        % hfss_indn(fid,X, Y, Z,  OD, S, NT, W, lead, Thickness1,Thickness2, material,serial)        
        sn = 0;        
        sn = hfss_indn(fid,'0' ,'0' ,'$M9_Z','$OD', '$M9_S', '$NT', '$M9_W', '$lead', sn);
        hfssSaveProject(fid, projectname, true);
        hfssInsertSolution(fid, solname, solfreq, 0.02, 25);
        hfssEditSolution(fid, solname, '-1', solfreq, 0.02, 25);
        hfssInterpolatingSweep(fid, swpname, solname, 0.1, swp, 512, swp, 0.2);
        hfssSaveProject(fid, projectname, true);
    else
        disp(['Nominal Case Exists =>' projectname '....']);
    end
end