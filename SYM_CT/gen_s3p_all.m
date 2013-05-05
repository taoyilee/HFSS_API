function gen_s2p_all()    
    path1 = 'G:\HFSS_SIMULATIONS\T65_SYM\EM0';
    disp(['Listing all ' path1 ' .....']);
    file1 = ls([path1 '/*.hfss']);    
    gen_s2p_all_wh(path1, file1,'EM0');
%    gen_s3p_all_wh(path2, file2,'EM1');  
%    gen_s3p_all_wh(path3, file3,'EM2');            
end