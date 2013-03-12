function hfssEmpty(fid)
    W = 100;
    L = 100;
    H = 100;
    hfssNewProject(fid);
    hfssInsertDesign(fid, 'Design');
    hfssSetUnit(fid, 'um');