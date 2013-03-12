% ----------------------------------------------------------------------------
% function hfssAssignLumpedPort(fid, Name, ObjName, iLStart, iLEnd, Units, 
%                               [Resistance = 50.0], [Reactance = 0.0])
% 
% Description :
% -------------
% Create the necessary VB Script to assign a Lumped Port to a given Object.
%
% Parameters :
% ------------
% fid     - file identifier of the HFSS script file.
% Name    - name of the lumped port (appears under 'Boundaries' in HFSS).
% ObjName - name of the (sheet-like) object to which the lumped port is to 
%           be assigned.
% iLStart - (vector) starting point of the integration line. Specify as
%           [x, y, z].
% iLEnd   - (vector) ending point of the integration line. Specify as
%           [x, y, z].
% Units   - specify as 'meter', 'in', 'cm' (defined in HFSS).
% [Resistance] - (scalar, optional) the port resistance (defaults to 
%                50.0 Ohms)
% [Reactance]  - (scalar, optional) the port reactance (defaults to 
%                0.0 Ohms)
% 
% Note :
% ------
% Integration Lines are mandatory in lumped ports.
%
% Example :
% ---------
% fid = fopen('myantenna.vbs', 'wt');
% ... 
% hfssAssignLumpedPort(fid, 'LumpedPort', 'GapSource', [-gapL/2, 0, 0], ...
%	                 [gapL/2, 0, 0], 'meter', 75, 0);
%
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
% Copyright 2004, Vijay Ramasami (rvc@ku.edu)
% ----------------------------------------------------------------------------

function hfssAssignLumpedPortDTerm(fid, Name, posi, ref,portn, Resistance, Reactance)

% arguments processor.
if (nargin < 5)
	error('Not Enough Arguments !');
elseif (nargin < 6)
	Resistance = [];
	Reactance = [];
elseif (nargin < 7)
	Reactance = [];
end;

% Setup default arguments.
if isempty(Resistance)
	Resistance = 50.0;
end;

if isempty(Reactance)
	Reactance = 0.0;
end;

% The usual fprintf stuff.
fprintf(fid, '\n');
fprintf(fid, 'Dim faceid%s\n', Name);
fprintf(fid, 'faceid = oEditor.GetFaceByPosition(Array("NAME:Parameters", _\n');
fprintf(fid, '"BodyName:=", "%s", "XPosition:=", "%s", "YPosition:=", _\n', Name,posi{1});
fprintf(fid, '"%s", "ZPosition:=", "%s"))\n',posi{2},posi{3});

fprintf(fid, 'Set oModule = oDesign.GetModule("BoundarySetup")\n');
fprintf(fid, 'oModule.AutoIdentifyPorts Array("NAME:Faces", faceid), false, Array("NAME:ReferenceConductors",  _\n');
fprintf(fid, '  "%s"), "%s", true\n', ref, portn);
%fprintf(fid, 'oModule.EditLumpedPort "%s", Array("NAME:%s", "RenormalizeAllTerminals:=", true, "TerminalIDList:=", Array( _\n',portn,portn);
%fprintf(fid, '%s), "ShowReporterFilter:=", false, "FullResistance:=", "%f", "FullReactance:=",  _\n',portn,Resistance);
%fprintf(fid, '  "%f")\n', Reactance);
