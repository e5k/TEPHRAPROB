%{
 ______                __                     ____               __        
/\__  _\              /\ \                   /\  _`\            /\ \       
\/_/\ \/    __   _____\ \ \___   _ __    __  \ \ \_\ \_ __   ___\ \ \____  
   \ \ \  /'__`\/\ '__`\ \  _ `\/\`'__\/'__`\ \ \ ,__/\`'__\/ __`\ \ '__`\ 
    \ \ \/\  __/\ \ \_\ \ \ \ \ \ \ \//\ \_\.\_\ \ \/\ \ \//\ \_\ \ \ \_\ \
     \ \_\ \____\\ \ ,__/\ \_\ \_\ \_\\ \__/.\_\\ \_\ \ \_\\ \____/\ \_,__/
      \/_/\/____/ \ \ \/  \/_/\/_/\/_/ \/__/\/_/ \/_/  \/_/ \/___/  \/___/ 
                   \ \_\                                                   
                    \/_/                                                   
___________________________________________________________________________

Name:       dwind_ECMWF.m
Purpose:    Download NetCDF wind files from the ECMWF ERA-Interim database
Author:     Sebastien Biass
Created:    April 2015
Updates:    April 2015
Copyright:  Sebastien Biass, University of Geneva, 2015
License:    GNU GPL3

This file is part of TephraProb

TephraProb is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    TephraProb is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with TephraProb.  If not, see <http://www.gnu.org/licenses/>.
%}


function dwind_ECMWF
% Check that you are located in the correct folder!
if ~exist([pwd, filesep, 'tephraProb.m'], 'file')
    errordlg(sprintf('You are located in the folder:\n%s\nIn Matlab, please navigate to the root of the TephraProb\nfolder, i.e. where tephraProb.m is located. and try again.', pwd))
    return
end

global yrs mts ;     % Strings for popup menus

%%%%%%%%%%%%%%%%%%%%%%%
scr = get(0,'ScreenSize');
wd   = 500;
h    = 400;
w.fig = figure(...
    'position', [scr(3)/2-wd/2 scr(4)/2-h/2 wd h],...
    'Color', [.25 .25 .25],...
    'Resize', 'off',...
    'Tag', 'Configuration',...
    'Toolbar', 'none',...
    'Menubar', 'none',...
    'Name', 'TephraProb: Download ERA-INTERIM wind profiles',...
    'NumberTitle', 'off');

w.wind1 = uipanel(...
    'units', 'normalized',...
    'position', [.025 .025 .95 .95],...
    'title', 'ECMWF ERA-Interim Reanalysis',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [.9 .5 0],...
    'HighlightColor', [.9 .5 0],...
    'BorderType', 'line');

% Coordinates
w.wind2 = uipanel(...
    'Parent', w.wind1,...
    'units', 'normalized',...
    'position', [.03 .7 .94 .27],...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [.5 .5 .5],...
    'HighlightColor', [.3 .3 .3],...
    'Title', 'Coordinates of the volcano',...
    'BorderType', 'line');

w.wind2_text_note = uicontrol(...
    'parent', w.wind2,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.55 .2 .4 .66],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Note: Latitudes and longitudes are expressed as negative numbers in southern and western hemispheres, respectively.');

w.wind2_text_lat = uicontrol(...
    'parent', w.wind2,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .6 .2 .2],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Latitude:');

w.wind2_text_lon = uicontrol(...
    'parent', w.wind2,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .2 .2 .2],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Longitude:');

w.wind2_lat = uicontrol(...
    'parent', w.wind2,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.3 .55 .2 .3],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);


w.wind2_lon = uicontrol(...
    'parent', w.wind2,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.3 .15 .2 .3],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);

% Time range
w.wind3 = uipanel(...
    'Parent', w.wind1,...
    'units', 'normalized',...
    'position', [.03 .04 .55 .64],...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [.5 .5 .5],...
    'HighlightColor', [.3 .3 .3],...
    'Title', 'Time range',...
    'BorderType', 'line');

w.wind3_start = uicontrol(...
    'parent', w.wind3,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.32 .8 .25 .15],...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Start');

w.wind3_end = uicontrol(...
    'parent', w.wind3,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.62 .8 .25 .15],...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'End');

% Sets years
y1 = 1979;
y2 = date; y2 = str2double(y2(end-3:end));
yn = y2 - y1;
for i = 1:yn+1
    yrs{i} = num2str(y1+i-1);
end
% Set months
mts = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'};
% Set day
% dys = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31'};
% % Set hours
% hrs = {'00 Z', '06 Z', '12 Z', '18 Z'};
w.wind3_s_year = uicontrol(...
    'Style', 'popupmenu',...
    'Parent', w.wind3,...
    'units', 'normalized',...
    'position', [.35 .7 .285 .15],...
    'ForegroundColor', [.75 .75 .75],...
    'BackgroundColor', [.35 .35 .35],...
    'String', yrs);

w.wind3_e_year = uicontrol(...
    'Style', 'popupmenu',...
    'Parent', w.wind3,...
    'units', 'normalized',...
    'position', [.65 .7 .285 .15],...
    'ForegroundColor', [.75 .75 .75],...
    'BackgroundColor', [.35 .35 .35],...
    'String', yrs);

w.wind3_year = uicontrol(...
    'parent', w.wind3,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.075 .68 .25 .15],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Year:');

w.wind3_s_month = uicontrol(...
    'Style', 'popupmenu',...
    'Parent', w.wind3,...
    'units', 'normalized',...
    'position', [.35 .53 .285 .15],...
    'ForegroundColor', [.75 .75 .75],...
    'BackgroundColor', [.35 .35 .35],...
    'String', mts);

w.wind3_e_month = uicontrol(...
    'Style', 'popupmenu',...
    'Parent', w.wind3,...
    'units', 'normalized',...
    'position', [.65 .53 .285 .15],...
    'ForegroundColor', [.75 .75 .75],...
    'BackgroundColor', [.35 .35 .35],...
    'String', mts);

w.wind3_months = uicontrol(...
    'parent', w.wind3,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.075 .51 .25 .15],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Month:');

w.wind4 = uipanel(...
    'Parent', w.wind1,...
    'units', 'normalized',...
    'position', [.61 .43 .36 .25],...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [.5 .5 .5],...
    'HighlightColor', [.3 .3 .3],...
    'Title', 'Output',...
    'BorderType', 'line');

w.wind4_txt = uicontrol(...
    'parent', w.wind4,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .65 .8 .25],...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Dataset name:');

w.wind4_name = uicontrol(...
    'parent', w.wind4,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.1 .25 .8 .35],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);

w.wind5 = uipanel(...
    'Parent', w.wind1,...
    'units', 'normalized',...
    'position', [.61 .04 .36 .35],...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [.5 .5 .5],...
    'HighlightColor', [.3 .3 .3],...
    'BorderType', 'line');


w.wind5_but_download = uicontrol(...
    'parent', w.wind5,...
    'Style', 'pushbutton',...
    'units', 'normalized',...
    'position', [.05 .05 .9 .9],...
    'BackgroundColor', [.3 .3 .3],...
    'ForegroundColor', [.9 .5 .0],...
    'String', 'Download');

set(w.wind5_but_download, 'callback', {@but_wind5_download, w})
% Adapt display accross plateforms
set_display
    
% Function for DOWNLOAD button in main panel
function w =  but_wind5_download(~, ~, w)
global yrs mts dys hrs     % Strings for popup menus
global tmp
%load(fl2l);

if isempty(get(w.wind4_name, 'String')) || isempty(get(w.wind2_lon, 'String')) || isempty(get(w.wind2_lat, 'String'))
    errordlg('Please fill up all fields');
else
    % Retrieve data and stores it in a structure
    tmp = struct;

    tmp.lat     =   get(w.wind2_lat, 'String');
    tmp.lon     =   get(w.wind2_lon, 'String');
    tmp.name    =   get(w.wind4_name, 'String');

    tmp.yr_s    =   yrs{get(w.wind3_s_year, 'Value')};
    tmp.yr_e    =   yrs{get(w.wind3_e_year, 'Value')};
    tmp.mt_s    =   mts{get(w.wind3_s_month, 'Value')};
    tmp.mt_e    =   mts{get(w.wind3_e_month, 'Value')};

    tmp.folder  =   ['WIND', filesep, tmp.name, filesep];

    % Create folder

    if exist(tmp.folder, 'dir') == 7
        choice = questdlg('This name is already taken. Overwrite?', ...
        '', 'Yes','No','No');
        switch choice
            case 'Yes'
                rmdir(tmp.folder, 's');
                mkdir(tmp.folder);
                mkdir([tmp.folder, filesep, 'nc_output_files', filesep]);
                mkdir([tmp.folder, filesep, 'txt_output_files', filesep]);
                dlmwrite([tmp.folder, filesep,'.ncep'], '.ncep');
                download(w);
            case 'No'
        end
    else
        mkdir(tmp.folder);
        mkdir([tmp.folder, filesep, 'nc_output_files', filesep]);
        mkdir([tmp.folder, filesep, 'txt_output_files', filesep]);
        download(w);
    end
end

% Download WIND
function w = download(w, varargin)
global tmp

txt = fileread('download_ECMWF_tmp.py');

txt_new = strrep(txt, 'var_year_start', tmp.yr_s);
txt_new = strrep(txt_new, 'var_year_end', tmp.yr_e);
txt_new = strrep(txt_new, 'var_month_start', tmp.mt_s);
txt_new = strrep(txt_new, 'var_month_end', tmp.mt_e);
txt_new = strrep(txt_new, 'var_north', num2str(str2double(tmp.lat)+1));
txt_new = strrep(txt_new, 'var_south', num2str(str2double(tmp.lat)-1));
txt_new = strrep(txt_new, 'var_west', num2str(str2double(tmp.lon)-1));
txt_new = strrep(txt_new, 'var_east', num2str(str2double(tmp.lon)+1));
txt_new = strrep(txt_new, 'var_out', strrep(tmp.folder, '\', '/'));

vent.lat = tmp.lat;
vent.lon = tmp.lon;

save([tmp.folder, 'vent'], 'vent', '-mat');

fid = fopen('download_ECMWF.py', 'w');
fprintf(fid, '%s', txt_new);
fclose(fid);

% Calculate number of files
yr_s = str2double(tmp.yr_s);
yr_e = str2double(tmp.yr_e);
mt_s = str2double(tmp.mt_s);
mt_e = str2double(tmp.mt_e);

if yr_e - yr_s == 0
   nb_files = length(mt_s:mt_e);
elseif yr_e - yr_s == 0
   nb_files = length(mt_s:12) + length(1:mt_e);
else
   nb_files = length(mt_s:12) + length(1:mt_e) + (yr_e-yr_s-1)*12;
end

% Download wind
%stat = system('python download_ECMWF.py &', '-echo')

%if stat == 0

!python download_ECMWF.py

    h = waitbar(0,'Dowloading ECMWF files...');
    while length(dir([tmp.folder, 'nc_output_files', filesep, '*.nc'])) < nb_files
        l = length(dir([tmp.folder, 'nc_output_files', filesep, '*.nc']));
        waitbar(l/nb_files);
        pause(5);
    end

    close(h);
%end

delete('download_ECMWF.py');