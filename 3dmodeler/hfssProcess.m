function [param hfssfile]= hfssProcess(fid,csv_me, csv_diel, beol, var_f, var_fp, dry, outdir, pjname)
    hfssNewProject(fid);
    hfssInsertDesign(fid, ['BEOL_' beol] , 'driven terminal'); % type 2: driven terminal
    hfssSetUnit(fid, 'um');  
    
    param = eval( [var_f '(fid,' var_fp ')']);
    %we = OD + 2*lead + M11_S;
    %le = OD + 2*lead + M11_S;
    %w = we + encl;
    %l = le + encl;
    % h = 200;
    %x0 = -lead-M11_S + w/2 - encl/2;
    % Create the Dielectrics.
    if(dry)
        hfssIMD_dry(fid, '', csv_diel, 0);
    else
        hfssIMD(fid, '', csv_diel, 0);
    end
    % Create the Metals
    hfssME(fid, '', csv_me ,0);
    hfssfile = [outdir pjname];
    hfssSaveProject(fid, hfssfile, true);