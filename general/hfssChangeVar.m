% ----------------------------------------------------------------------------
% function hfssChangeVar(fid, Name,variable)
%
% Description :
% -------------
% Creates VB Script necessary to chanage a global variable in HFSS
%
% Parameters :
% ------------
% fid      - file identifier of the HFSS script file.
% Name     - variable name
% variable - value
%
% Example :
% ---------
% fid = fopen('Dipole.vbs', 'wt');
% ...
% hfssChangeVar(fid, 'W', 2.07);
% ----------------------------------------------------------------------------
% ----------------------------------------------------------------------------
% This file is part of HFSS-MATLAB-API.
%
% HFSS-MATLAB-API is free software; you can redistribute it and/or modify it 
% under the terms of the GNU General Public License as published by the Free 
% Software Foundation; either version 2 of the License, or (at your option) 
% any later version.
%
% HFSS-MATLAB-API is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
% or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License 
% for more details.
%
% You should have received a copy of the GNU General Public License along with
% Foobar; if not, write to the Free Software Foundation, Inc., 59 Temple 
% Place, Suite 330, Boston, MA  02111-1307  USA
%
% Copyright 2012, Tao-Yi Lee (michael@rfvlsi.ee.nctu.edu.tw)
% ----------------------------------------------------------------------------
function hfssChangeVar(fid, Name,variable)
    fprintf(fid, 'oProject.ChangeProperty Array("NAME:AllTabs", Array("NAME:ProjectVariableTab", Array("NAME:PropServers",  _\n');
    fprintf(fid, '"ProjectVariables"), Array("NAME:ChangedProps", Array("NAME:$%s", "Value:=", "%s"))))\n',Name, variable);
