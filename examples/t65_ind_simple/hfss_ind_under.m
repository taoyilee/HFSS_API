function  hfss_ind_under(fid, OD, S, NT, W)

        hfssBoxN(fid, 'under_1', ...
                {[OD, '-', W, '-(' NT '-1)*$M9_P'], S ,'$M8_Z'}, {strcat('$NT*$M9_P+', W), W, '$M8_T'},'ME0d022' ); % under pass
        hfssBoxN(fid, 'via_1', ...
                {[OD, '-', W, '-(' NT '-1)*$M9_P'], S,'$VIA8_Z'}, {W, W, '$VIA8_T'},'ME0d022' ); % via 1
        hfssBoxN(fid, 'via_2', ...
               {strcat(OD, '+', S), S,'$VIA8_Z'}, {W, W, '$VIA8_T'},'ME0d022' ); % via 2           
        % hfssSubtract(fid, {'IMD_9aEQ'},  {'under_1', 'via_1', 'via_2'},1);            
        hfssSubtract(fid, {'IMD_9aEQ','IMD_1aEQ'}, {'via_2', 'via_1'},1);