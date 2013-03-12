function t65gsg_wh(tmpScriptFile, fid, outdir)
        projectname = [outdir 'T65_GSG.hfss'];        
        % delete([ projectname '.lock'])
        % disp(['removing '  projectname '.lock']);
        % delete([ projectname '.auto'])
        % disp(['removing '  projectname '.auto']);
        tmpDataFiles = [outdir 'T65_GSG.s1p'];
        tmpDataFilem = [outdir 'T65_GSG.mat'];
            hfssOpenProject(fid, [outdir 'empty.hfss'])
            hfssSetDesign(fid, 'BEOL_6X1Z1U');
            hfssSetEditor(fid, '3d Modeler')
            % hfssCreateVar(fid, 'VIA_H', '$M11_Z+$M11_T-($M9_Z+$M9_T)');            
            %hfssChangeVar(fid, 'OD', [num2str(OD) 'um']);
            %hfssChangeVar(fid, 'M11_W',[num2str(M11_W) 'um']);
            %hfssChangeVar(fid, 'M11_S',[num2str(M11_S) 'um']);
            %hfssCreateVar(fid, 'M9_W',[num2str(M9_W) 'um']);
            %hfssCreateVar(fid, 'M9_S',[num2str(M9_S) 'um']);
            % hfssChangeVar(fid, 'NT',num2str(NT));            
            disp(['Creating the Script File ...@ ' tmpScriptFile ]);       
            % hfss_indn(fid,X, Y, Z,  OD, S, NT, W, lead, Thickness1,Thickness2, material,serial)        
            % sn = 0;
            hfssCreateVar(fid, 'GPAD_W','65um');
            hfssCreateVar(fid, 'SPAD_W','55um');
            hfssCreateVar(fid, 'VIA_ENC','5um');
            hfssCreateVar(fid, 'GS_PITCH','100um');            
            hfssCreateVar(fid, 'GPAD_X','$GS_PITCH-25um');            
            % S_UTM/RDL
            hfssBoxN(fid, 'S_UTM', {'-$SPAD_W/2', '0', '$M9_Z'}, {'$SPAD_W', '$SPAD_W', '$M9_T'},'ME0d041');
            hfssBoxN(fid, 'V_S', {'-$SPAD_W/2+$VIA_ENC', '$VIA_ENC', '$VIA11_Z'}, ...
                    {'$SPAD_W-2*$VIA_ENC', '$SPAD_W-2*$VIA_ENC', '$VIA11_T'},'VIA0d041');
            hfssBoxN(fid, 'S_RDL', {'-$SPAD_W/2', '0', '$M10_Z'}, {'$SPAD_W','$SPAD_W', '$M10_T'},'ME0d0218');
            hfssBoxN(fid, 'S_RDLS', {'-$SPAD_W/2', '0', '$M10_Z'}, {'$SPAD_W','$SPAD_W', '$M10_T+2.5um'},'ME0d0218');
            % G_UTM/RDL
            hfssBoxN(fid, 'V_M9P', {'$GPAD_X+$VIA_ENC', '$VIA_ENC', '$VIA11_Z'}, ...
                    {'$GPAD_W-2*$VIA_ENC', '$GPAD_W-2*$VIA_ENC', '$VIA11_T'},'VIA0d041');
            hfssBoxN(fid, 'G_UTMP', {'$GPAD_X', '0', '$M9_Z'}, {'$GPAD_W', '$GPAD_W', '$M9_T'},'ME0d041');
            hfssBoxN(fid, 'G_RDLP', {'$GPAD_X', '0', '$M10_Z'}, {'$GPAD_W', '$GPAD_W', '$M10_T'},'ME0d0218');
            hfssBoxN(fid, 'G_RDLPS', {'$GPAD_X', '0', '$M10_Z'}, {'$GPAD_W', '$GPAD_W', '$M10_T+2.5um'},'ME0d0218');
            % G_UTM/RDL
            hfssBoxN(fid, 'V_M9N', {'-$GPAD_X-$VIA_ENC', '$VIA_ENC', '$VIA11_Z'}, ...
                    {'-$GPAD_W+2*$VIA_ENC', '$GPAD_W-2*$VIA_ENC', '$VIA11_T'},'VIA0d041');
            hfssBoxN(fid, 'G_UTMN', {'-$GPAD_X', '0', '$M9_Z'}, {'-$GPAD_W', '$GPAD_W', '$M9_T'},'ME0d041');
            hfssBoxN(fid, 'G_RDLN', {'-$GPAD_X', '0', '$M10_Z'}, {'-$GPAD_W', '$GPAD_W', '$M10_T'},'ME0d0218');
            hfssBoxN(fid, 'G_RDLNS', {'-$GPAD_X', '0', '$M10_Z'}, {'-$GPAD_W', '$GPAD_W', '$M10_T+2.5um'},'ME0d0218');
            % M8
            hfssBoxN(fid, 'V_M8P', {'$GPAD_X+$VIA_ENC', '$VIA_ENC', '$VIA10_Z'}, ...
                    {'$GPAD_W-2*$VIA_ENC', '$GPAD_W-2*$VIA_ENC', '$VIA10_T'},'VIA0d1399');
            hfssBoxN(fid, 'G_M8P', {'$GPAD_X', '0', '$M8_Z'}, {'$GPAD_W', '$GPAD_W', '$M8_T'},'ME0d1399');
            
            hfssBoxN(fid, 'V_M7P', {'$GPAD_X+$VIA_ENC', '$VIA_ENC', '$VIA7_Z'}, ...
                    {'$GPAD_W-2*$VIA_ENC', '$GPAD_W-2*$VIA_ENC', '$VIA7_T+$VIA8_T+$MCB_T+$MCT_T+$VIA9_T'},'VIA0d1399');
            hfssBoxN(fid, 'G_M7P', {'$GPAD_X', '0', '$M7_Z'}, {'$GPAD_W', '$GPAD_W', '$M7_T'},'ME0d1399');
            
            hfssBoxN(fid, 'V_M6P', {'$GPAD_X+$VIA_ENC', '$VIA_ENC', '$VIA6_Z'}, ...
                    {'$GPAD_W-2*$VIA_ENC', '$GPAD_W-2*$VIA_ENC', '$VIA6_T'},'VIA0d1399');
            hfssBoxN(fid, 'G_M6P', {'$GPAD_X', '0', '$M6_Z'}, {'$GPAD_W', '$GPAD_W', '$M6_T'},'ME0d1399');
            
            hfssBoxN(fid, 'V_M8N', {'-$GPAD_X-$VIA_ENC', '$VIA_ENC', '$VIA10_Z'}, ...
                    {'-$GPAD_W+2*$VIA_ENC', '$GPAD_W-2*$VIA_ENC', '$VIA10_T'},'VIA0d1399');
            hfssBoxN(fid, 'G_M8N', {'-$GPAD_X', '0', '$M8_Z'}, {'-$GPAD_W', '$GPAD_W', '$M8_T'},'ME0d1399');
            
            hfssBoxN(fid, 'V_M7N', {'-$GPAD_X-$VIA_ENC', '$VIA_ENC', '$VIA7_Z'}, ...
                    {'-$GPAD_W+2*$VIA_ENC', '$GPAD_W-2*$VIA_ENC', '$VIA7_T+$VIA8_T+$MCB_T+$MCT_T+$VIA9_T'},'VIA0d1399');
            hfssBoxN(fid, 'G_M7N', {'-$GPAD_X', '0', '$M7_Z'}, {'-$GPAD_W', '$GPAD_W', '$M7_T'},'ME0d1399');
            
            hfssBoxN(fid, 'V_M6N', {'-$GPAD_X-$VIA_ENC', '$VIA_ENC', '$VIA6_Z'}, ...
                    {'-$GPAD_W+2*$VIA_ENC', '$GPAD_W-2*$VIA_ENC', '$VIA6_T'},'VIA0d1399');
            hfssBoxN(fid, 'G_M6N', {'-$GPAD_X', '0', '$M6_Z'}, {'-$GPAD_W', '$GPAD_W', '$M6_T'},'ME0d1399');

            
            hfssSubtract(fid, {'IMD_6c','IMD_6d','IMD_7a'}, {'V_M6P','V_M6N'},1);              
            hfssSubtract(fid, {'IMD_7c','IMD_8a','IMD_8b','IMD_8c','IMD_8d'}, {'V_M7P','V_M7N'},1);              
            hfssSubtract(fid, {'IMD_8d','IMD_8e','IMD_8f'}, {'G_M8P', 'G_M8N'},1);  
            hfssSubtract(fid, {'IMD_8g','IMD_9a'}, {'V_M8P', 'V_M8N'},1);  
            hfssSubtract(fid, {'PASS1','PASS2','PASS3','PASS4'}, {'V_S','V_M9P','V_M9N'},1);  
            hfssSubtract(fid, {'IMD_9a','IMD_9b','IMD_9c'}, {'S_UTM','G_UTMP','G_UTMN'},1);  
            hfssSubtract(fid, {'PASS5','PASS6'}, {'S_RDL','G_RDLP','G_RDLN'},1);  
            hfssSubtract(fid, {'PASS6'}, {'S_RDLS','G_RDLPS','G_RDLNS'},0);  
            
            hfssPolylineN(fid, 'PerfE', ...
                {'-$GPAD_X-$GPAD_W', '$SPAD_W/2', '$M10_Z+$M10_T+20um'; ...
                '-$GPAD_X-$GPAD_W', '$SPAD_W/2', '$M10_Z+$M10_T'; ...
                    '-$GPAD_X', '$SPAD_W/2', '$M10_Z+$M10_T';...
                    '-$GPAD_X', '$SPAD_W/2', '$M10_Z+$M10_T+5um';...
                    '$GPAD_X', '$SPAD_W/2', '$M10_Z+$M10_T+5um';...
                    '$GPAD_X', '$SPAD_W/2', '$M10_Z+$M10_T';...
                    '$GPAD_X+$GPAD_W', '$SPAD_W/2', '$M10_Z+$M10_T';...
                    '$GPAD_X+$GPAD_W', '$SPAD_W/2', '$M10_Z+$M10_T+20um';
                    '-$GPAD_X-$GPAD_W', '$SPAD_W/2', '$M10_Z+$M10_T+20um'});
        hfssAssignPE(fid, 'PerfE_GSG',{ 'PerfE'});
        posi = {'-$SPAD_W/2', '$SPAD_W/2', '$M10_Z+$M10_T'} ;
        hfssRectangleN(fid, 'PORT1', 'y', posi ,'5um','$SPAD_W');
        hfssAssignLumpedPortDTerm(fid, 'PORT1', posi, '', '1');
        hfssDeleteBoundaries(fid, 'PerfE_T1');     
        % sn = hfss_indn(fid,'0' ,'0' ,'$M11_Z','$OD', '$M11_S', NT, '$M11_W', '$lead',  sn);
        hfssInsertSolution(fid, 'Setup30G', 24, 0.02, 25);
        hfssEditSolution(fid, 'Setup30G', '-1');
        hfssInterpolatingSweep(fid, 'SWP30G', 'Setup30G', 0.1, 30, 512, 30, 0.2);
        disp(['Saving project to ' projectname '...']);
        hfssSaveProject(fid, projectname, true);        
        disp(['Project saved to ' projectname]);        
        % Export the Network data as an m-file.
        hfssSolveSetup(fid, 'Setup30G'); 
        hfssSaveProject(fid, projectname, true);
        disp(['Project saved to ' projectname]);        
        hfssExportNetworkData(fid, tmpDataFiles, 'Setup30G', 'SWP30G','s');
        hfssExportNetworkData(fid, tmpDataFilem, 'Setup30G', 'SWP30G');