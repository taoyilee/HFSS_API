function gen_s3p_all()    
    path1 = 'G:\HFSS_SIMULATIONS\T65_SYM_CT\EM0';
    path2 = 'G:\HFSS_SIMULATIONS\T65_SYM_CT\EM1';
    path3 = 'G:\HFSS_SIMULATIONS\T65_SYM_CT\EM2';
    disp(['Listing all ' path1 ' .....']);
    file1 = ls([path1 '/*.hfss']);    
    file2 = ls([path2 '/*.hfss']);
    file3 = ls([path3 '/*.hfss']);
    gen_s3p_all_wh(path1, file1,'EM0');
    gen_s3p_all_wh(path2, file2,'EM1');  
    gen_s3p_all_wh(path3, file3,'EM2');   
     
    
end