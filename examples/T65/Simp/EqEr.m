function [erp thp] = EqEr(er1, th1, er2,th2)
    disp(['T1 = ' num2str(th1) ' T2 = ' num2str(th2)  ]);
    disp(['ER1 = ' num2str(er1) ' ER2 = ' num2str(er2)  ]);
    if(er1 ==0)
        thp = th2;
        erp = er2;
    else    
    thp = th1 + th2;
    erp = thp/(th1/er1 + th2/er2);
    end
    disp(['ERP = ' num2str(erp) ' THP = ' num2str(thp)  ]);
end
