% -------------------------------------------------------------------------- %
% function hfssSetEditor(fid, editor)
%
% Description :
% -------------
% This function creates the VB Script necessary to select an editor for model editing
% 
% Parameters :
% ------------
% fid		- file identifier for the VBScript file.
% editor	- in 99% cases, this parameter is "3dModeler"
%
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

function hfssSetEditor(fid, editor)
	fprintf(fid, 'Set oEditor = oDesign.SetActiveEditor("%s")\n', editor);
