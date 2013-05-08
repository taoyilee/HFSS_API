function gen_sNp_all(path1, N)        
    disp(['Listing all ' path1 ' .....']);
    file1 = ls([path1 '/*.hfss']);    
    gen_sNp_all_wh(path1, N, file1,'EM0'); 
end