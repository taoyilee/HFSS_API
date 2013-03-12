function gen_s4p_all()    
    path1 = 'G:\HFSS_SIMULATIONS\T65_XFM_HK_ANTLR\EM1';
    disp(['Listing all ' path1 ' .....']);
    file1 = ls([path1 '/*.hfss']);    
    gen_s4p_all_wh(path1, file1,'EM1');  
    path1 = 'G:\HFSS_SIMULATIONS\T65_XFM_HK_ANTLR\EM2';
    disp(['Listing all ' path1 ' .....']);
    file1 = ls([path1 '/*.hfss']);    
    gen_s4p_all_wh(path1, file1,'EM2');  
end