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

Name:       conf_grid.m
Purpose:    Prepare TephraProb computation grids usable with TEPHRA2
Author:     S???bastien Biass
Created:    April 2015
Updates:    April 2015
            Octobre 2016: Fixed a bug for crossing of equator
Copyright:  S???bastien Biass, University of Geneva, 2015
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

function conf_grid
% Check that you are located in the correct folder!
if ~exist(fullfile(pwd, 'tephraProb.m'), 'file')
    errordlg(sprintf('You are located in the folder:\n%s\nIn Matlab, please navigate to the root of the TephraProb\nfolder, i.e. where tephraProb.m is located. and try again.', pwd), ' ')
    return
end

global h

scr = get(0,'ScreenSize');
w   = 500;
ht   = 500;
h.fig = figure(...
    'position', [scr(3)/2-w/2 scr(4)/2-ht/2 w ht],...
    'Color', [.25 .25 .25],...
    'Resize', 'off',...
    'Tag', 'Configuration',...
    'Toolbar', 'none',...
    'Menubar', 'none',...
    'Name', 'TephraProb: Make Grid',...
    'NumberTitle', 'off');

h.grd = uipanel(...
    'units', 'normalized',...
    'position', [.025 .025 .95 .95],...
    'title', 'Grid parameters',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [.9 .5 0],...
    'HighlightColor', [.9 .5 0],...
    'BorderType', 'line');

%% Button groups Panel 2

% Utm zones
h.grd_utm_panel = uibuttongroup(...
    'parent', h.grd,...
    'units', 'normalized',...
    'position', [.72 .65 .25 .3],...
    'title', 'Utm zone',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [.5 .5 .5],...
    'HighlightColor', [.3 .3 .3],...
    'BorderType', 'line');

        h.grd_description2 = uicontrol(...
            'parent', h.grd_utm_panel,...
            'style', 'text',...
            'units', 'normalized',...
            'position', [.05 .60 .9 .35],...
            'HorizontalAlignment', 'left',...
            'BackgroundColor', [.25 .25 .25],...
            'ForegroundColor', [1 1 1],...
            'String', 'Is your grid crossing utm zones?');

        h.grd_utm_no = uicontrol(...
           'style', 'radiobutton',...
           'parent', h.grd_utm_panel,...
           'units', 'normalized',...
           'position', [.2 .32 .6 .25],...
           'string', 'No',...
           'ForegroundColor', [1 1 1],...
           'BackgroundColor', [.25 .25 .25]);


        h.grd_utm_yes = uicontrol(...
           'style', 'radiobutton',...
           'parent', h.grd_utm_panel,...
           'units', 'normalized',...
           'position', [.2 .075 .6 .25],...
           'string', 'Yes',...
           'ForegroundColor', [1 1 1],...
           'BackgroundColor', [.25 .25 .25]);

% Equator
h.grd_eq_panel = uibuttongroup(...
    'parent', h.grd,...
    'units', 'normalized',...
    'position', [.72 .33 .25 .3],...
    'title', 'Equator',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [.5 .5 .5],...
    'HighlightColor', [.3 .3 .3],...
    'BorderType', 'line');

        h.grd_description3 = uicontrol(...
            'parent', h.grd_eq_panel,...
            'style', 'text',...
            'units', 'normalized',...
            'position', [.05 .60 .9 .35],...
            'HorizontalAlignment', 'left',...
            'BackgroundColor', [.25 .25 .25],...
            'ForegroundColor', [1 1 1],...
            'String', 'Is your grid crossing the equator?');

        h.grd_eq_no = uicontrol(...
           'style', 'radiobutton',...
           'parent', h.grd_eq_panel,...
           'units', 'normalized',...
           'position', [.2 .32 .6 .25],...
           'string', 'No',...
           'ForegroundColor', [1 1 1],...
           'BackgroundColor', [.25 .25 .25]);


        h.grd_eq_yes = uicontrol(...
           'style', 'radiobutton',...
           'parent', h.grd_eq_panel,...
           'units', 'normalized',...
           'position', [.2 .075 .6 .25],...
           'string', 'Yes',...
           'ForegroundColor', [1 1 1],...
           'BackgroundColor', [.25 .25 .25]);

%% Text Panel 2 
h.grd_description = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.05 .94 .6 .05],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'FontWeight', 'bold',...
    'String', 'Please enter the parameters of your grid:');

h.grd_txt_min_easting = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .865 .4 .04],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Minimum easting (UTM):');

h.grd_txt_max_easting = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .75 .4 .05],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Maximum easting (UTM):');

h.grd_txt_min_northing = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .645 .4 .05],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Minimum northing (UTM):');

h.grd_txt_max_northing = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .545 .4 .05],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Maximum northing (UTM):');

h.grd_txt_utm_zone = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .440 .4 .05],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'UTM zone (ex. -18):',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   

h.grd_txt_vent_zone = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .335 .4 .05],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Vent zone (ex. -18):',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   

h.grd_txt_resolution = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .235 .4 .05],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Grid resolution (m):');    

h.grd_txt_elev = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .13 .4 .05],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Mean elevation (m asl):');   

h.grd_txt_name = uicontrol(...
    'parent', h.grd,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.1 .03 .4 .05],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Grid name:');

%% Textboxes Panel 2
h.grd_grid_min_easting = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .85 .275 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);

h.grd_grid_max_easting = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .745 .275 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);

h.grd_grid_min_northing = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .595+0.05 .275 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);

h.grd_grid_max_northing = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .485+0.055 .275 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);


%% Textboxes for UTM zones
h.grd_grid_zone = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .375+0.06 .275 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   


h.grd_grid_zone_W = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .375+0.06 .125 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'String', 'W zone',...
    'Visible', 'off',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   


h.grd_grid_zone_E = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.547 .375+0.06 .125 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'String', 'E zone',...
    'Visible', 'off',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   


h.grd_grid_zone_N = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4  .4725 .125 .065],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'String', 'N zone',...
    'Visible', 'off',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   

h.grd_grid_zone_S = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .403 .125 .065],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'String', 'S zone',...
    'Visible', 'off',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');     

h.grd_grid_zone_NW = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .4725 .125 .065],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'String', 'NW zone',...
    'Visible', 'off',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');      

h.grd_grid_zone_NE = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.547 .4725 .125 .065],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'String', 'NE zone',...
    'Visible', 'off',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   

h.grd_grid_zone_SE = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.547 .403 .125 .065],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'String', 'SE zone',...
    'Visible', 'off',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   

h.grd_grid_zone_SW = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .403 .125 .065],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'String', 'SW zone',...
    'Visible', 'off',...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   

%%

h.grd_vent_zone = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .265+0.065 .275 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35],...
    'Tooltip', 'The zone should be positive in the Northen hemisphere and negative in the Southern');   

h.grd_grid_resolution = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .155+.07 .275 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);

h.grd_grid_elevation = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .045+.075 .275 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);

h.grd_grid_name = uicontrol(...
    'parent', h.grd,...
    'style', 'edit',...
    'unit', 'normalized',...
    'position', [.4 .015 .275 .075],...
    'HorizontalAlignment', 'left',...
    'ForegroundColor', [1 1 1],...
    'BackgroundColor', [.35 .35 .35]);


%% Buttons - Panel 2
h.button_grd_next = uicontrol(...
    'parent', h.grd,...
    'Style', 'pushbutton',...
    'units', 'normalized',...
    'position', [.72 .05 .25 .08],...
    'BackgroundColor', [.3 .3 .3],...
    'ForegroundColor', [.9 .5 .0],...
    'String', 'Generate grid');

h.button_grd_map = uicontrol(...
    'parent', h.grd,...
    'Style', 'pushbutton',...
    'units', 'normalized',...
    'position', [.72 .23 .25 .05],...
    'BackgroundColor', [.3 .3 .3],...
    'ForegroundColor', [.9 .5 .0],...
    'String', 'Plot grid');

h.button_grd_manage = uicontrol(...
    'parent', h.grd,...
    'Style', 'pushbutton',...
    'units', 'normalized',...
    'position', [.72 .155 .25 .05],...
    'BackgroundColor', [.3 .3 .3],...
    'ForegroundColor', [.9 .5 .0],...
    'String', 'Load');


%% Callbacks and SelectionChange functions

set(h.button_grd_next, 'callback', {@but_grd_next})
set(h.button_grd_map, 'callback', {@disp_grid})
set(h.button_grd_manage, 'callback', {@manage_grid})

set(h.grd_utm_panel,'SelectionChangeFcn',{@UTM_SelectionChangeFcn});
set(h.grd_eq_panel,'SelectionChangeFcn',{@UTM_SelectionChangeFcn});

% Adapt display accross plateforms
set_display


function but_grd_next(~, ~)
global h

if check_values == 1
    go = 1;
    if exist(fullfile('GRID', get(h.grd_grid_name, 'String')), 'dir')
        choice = questdlg('This name already exists. Overwrite?','','Yes','No','No');
        switch choice
            case 'No'
                go = 0;
            case 'Yes'
                rmdir(fullfile('GRID', get(h.grd_grid_name, 'String')), 's');
                go = 1;
        end
    end

    if go == 1
        tmp_grid = make_struct(h);
        make_grid(tmp_grid, 0, 1);
    end
else
    errordlg('Please fill up all parameters for your grid', '');
end
    
    
% Check if crosses UTM zones and/or equator
function UTM_SelectionChangeFcn(hObject, ~)
global h

% Sets the display of UTM zones textboxes
if  get(h.grd_utm_no, 'Value') == 1 && get(h.grd_eq_no, 'Value') == 1           % Do not cross utm zones nor equator
    set(h.grd_grid_zone, 'Visible', 'on')
    
    set(h.grd_grid_zone_E, 'Visible', 'off')
    set(h.grd_grid_zone_W, 'Visible', 'off')
       
    set(h.grd_grid_zone_NW, 'Visible', 'off')
    set(h.grd_grid_zone_NE, 'Visible', 'off')
    set(h.grd_grid_zone_SW, 'Visible', 'off')
    set(h.grd_grid_zone_SE, 'Visible', 'off')
    set(h.grd_grid_zone_N, 'Visible', 'off')
    set(h.grd_grid_zone_S, 'Visible', 'off')
    
elseif get(h.grd_utm_no, 'Value') == 0 && get(h.grd_eq_no, 'Value') == 1        % Cross utm zones but not equator
    set(h.grd_grid_zone_E, 'Visible', 'on')
    set(h.grd_grid_zone_W, 'Visible', 'on')
    
    set(h.grd_grid_zone, 'Visible', 'off')
    set(h.grd_grid_zone_NW, 'Visible', 'off')
    set(h.grd_grid_zone_NE, 'Visible', 'off')
    set(h.grd_grid_zone_SW, 'Visible', 'off')
    set(h.grd_grid_zone_SE, 'Visible', 'off')
    set(h.grd_grid_zone_N, 'Visible', 'off')
    set(h.grd_grid_zone_S, 'Visible', 'off')

elseif get(h.grd_utm_no, 'Value') == 1 && get(h.grd_eq_no, 'Value') == 0        % Cross equator but not utm zones
    set(h.grd_grid_zone_N, 'Visible', 'on')
    set(h.grd_grid_zone_S, 'Visible', 'on')
    
    set(h.grd_grid_zone, 'Visible', 'off')
    set(h.grd_grid_zone_NW, 'Visible', 'off')
    set(h.grd_grid_zone_NE, 'Visible', 'off')
    set(h.grd_grid_zone_SW, 'Visible', 'off')
    set(h.grd_grid_zone_SE, 'Visible', 'off')
    set(h.grd_grid_zone_E, 'Visible', 'off')
    set(h.grd_grid_zone_W, 'Visible', 'off')
    
elseif get(h.grd_utm_no, 'Value') == 0 && get(h.grd_eq_no, 'Value') == 0        % Cross both equator and utm zones
    set(h.grd_grid_zone_NW, 'Visible', 'on')
    set(h.grd_grid_zone_NE, 'Visible', 'on')
    set(h.grd_grid_zone_SW, 'Visible', 'on')
    set(h.grd_grid_zone_SE, 'Visible', 'on')
    
    set(h.grd_grid_zone, 'Visible', 'off')
    set(h.grd_grid_zone_E, 'Visible', 'off')
    set(h.grd_grid_zone_W, 'Visible', 'off')
    set(h.grd_grid_zone_N, 'Visible', 'off')
    set(h.grd_grid_zone_S, 'Visible', 'off')    
end

guidata(hObject, h);

% Opens the manage grid panel
function manage_grid(~, ~)
global h

[fl, pth] = uigetfile('*.mat');

if fl == 0
    return
else
    load(fullfile(pth,fl));
end

% Updates fields
set(h.grd_grid_name, 'String', tmp.name);
set(h.grd_grid_min_easting, 'String', num2str(tmp.min_east));
set(h.grd_grid_max_easting, 'String', num2str(tmp.max_east));
set(h.grd_grid_min_northing, 'String', num2str(tmp.min_north));
set(h.grd_grid_max_northing, 'String', num2str(tmp.max_north));
set(h.grd_grid_resolution, 'String', num2str(tmp.res));
set(h.grd_vent_zone, 'String', tmp.vent_zone)

% Added the option for mean grid elevation as well as backwards
% compatibility
if isfield(tmp, 'elevation')
    set(h.grd_grid_elevation, 'String', num2str(tmp.elevation));
else
    set(h.grd_grid_elevation, 'String', '0');
end

if isfield(tmp, 'zone')
    set(h.grd_grid_zone, 'Visible', 'on', 'String', tmp.zone);
    set(h.grd_grid_zone_W, 'Visible', 'off');
    set(h.grd_grid_zone_E, 'Visible', 'off');
    set(h.grd_grid_zone_NW, 'Visible', 'off');
    set(h.grd_grid_zone_SW, 'Visible', 'off');
    set(h.grd_grid_zone_NE, 'Visible', 'off');
    set(h.grd_grid_zone_SE, 'Visible', 'off');
    set(h.grd_grid_zone_N, 'Visible', 'off');
    set(h.grd_grid_zone_S, 'Visible', 'off');
    set(h.grd_utm_no, 'Value', 1); set(h.grd_eq_no, 'Value', 1)
    set(h.grd_utm_no, 'Value', 1); set(h.grd_utm_no, 'Value', 1)

elseif isfield(tmp, 'zone_W')
    set(h.grd_grid_zone, 'Visible', 'off');
    set(h.grd_grid_zone_W, 'Visible', 'on', 'String', tmp.zone_W);
    set(h.grd_grid_zone_E, 'Visible', 'on', 'String', tmp.zone_E);
    set(h.grd_grid_zone_NW, 'Visible', 'off');
    set(h.grd_grid_zone_SW, 'Visible', 'off');
    set(h.grd_grid_zone_NE, 'Visible', 'off');
    set(h.grd_grid_zone_SE, 'Visible', 'off');
    set(h.grd_grid_zone_N, 'Visible', 'off');
    set(h.grd_grid_zone_S, 'Visible', 'off');
    set(h.grd_utm_no, 'Value', 0); set(h.grd_eq_no, 'Value', 1)
    set(h.grd_utm_no, 'Value', 0); set(h.grd_utm_yes, 'Value', 1)
    
elseif isfield(tmp, 'zone_N')
    set(h.grd_grid_zone, 'Visible', 'off');
    set(h.grd_grid_zone_W, 'Visible', 'off');
    set(h.grd_grid_zone_E, 'Visible', 'off');
    set(h.grd_grid_zone_NW, 'Visible', 'off');
    set(h.grd_grid_zone_SW, 'Visible', 'off');
    set(h.grd_grid_zone_NE, 'Visible', 'off');
    set(h.grd_grid_zone_SE, 'Visible', 'off');
    set(h.grd_grid_zone_N, 'Visible', 'on', 'String', tmp.zone_N);
    set(h.grd_grid_zone_S, 'Visible', 'on', 'String', tmp.zone_S);
    set(h.grd_utm_no, 'Value', 1); set(h.grd_eq_yes, 'Value', 1)
    set(h.grd_utm_no, 'Value', 0); set(h.grd_utm_no, 'Value', 1)
    
elseif isfield(tmp, 'zone_NW')
    set(h.grd_grid_zone, 'Visible', 'off');
    set(h.grd_grid_zone_W, 'Visible', 'off');
    set(h.grd_grid_zone_E, 'Visible', 'off');
    set(h.grd_grid_zone_NW, 'Visible', 'on', 'String', tmp.zone_NW);
    set(h.grd_grid_zone_SW, 'Visible', 'on', 'String', tmp.zone_SW);
    set(h.grd_grid_zone_NE, 'Visible', 'on', 'String', tmp.zone_NE);
    set(h.grd_grid_zone_SE, 'Visible', 'on', 'String', tmp.zone_SE);
    set(h.grd_grid_zone_N, 'Visible', 'off');
    set(h.grd_grid_zone_S, 'Visible', 'off');
    set(h.grd_utm_no, 'Value', 0); set(h.grd_eq_yes, 'Value', 1)
    set(h.grd_utm_no, 'Value', 0); set(h.grd_utm_yes, 'Value', 1)
end

% Main panel / Plot grid button
function disp_grid(hObject, eventdata)
global h

if check_values == 1
    tmp_grid = make_struct(h);
    make_grid(tmp_grid, 1, 0);
else
    errordlg('Please fill up all parameters for your grid', '')
end

% Checks if all values are filled
function check = check_values
global h

if  isempty(get(h.grd_grid_min_easting, 'String')) ||...
    isempty(get(h.grd_grid_max_easting, 'String')) ||...
    isempty(get(h.grd_grid_min_northing, 'String')) || ...
    isempty(get(h.grd_grid_max_northing, 'String')) || ...
    isempty(get(h.grd_grid_name, 'String'))
    check = 0;
elseif get(h.grd_utm_no, 'Value') == 1 &&...
    get(h.grd_eq_no, 'Value') == 1 &&...
    isempty(get(h.grd_grid_zone, 'String'))
    check = 0;
elseif  get(h.grd_utm_no, 'Value') == 0 &&...
        get(h.grd_eq_no, 'Value') == 1
    if  isempty(get(h.grd_grid_zone_E, 'String')) ||...
        isempty(get(h.grd_grid_zone_W, 'String'))      
        check = 0;
    else
        check = 1;
    end    
elseif  get(h.grd_utm_no, 'Value') == 1 &&...
        get(h.grd_eq_no, 'Value') == 0
    if  isempty(get(h.grd_grid_zone_N, 'String')) || ...
        isempty(get(h.grd_grid_zone_S, 'String'))
        check = 0;
    else
        check = 1;
    end
elseif  get(h.grd_utm_no, 'Value') == 0 &&...
        get(h.grd_eq_no, 'Value') == 0
    if  isempty(get(h.grd_grid_zone_NE, 'String')) ||...
        isempty(get(h.grd_grid_zone_NW, 'String')) ||...
        isempty(get(h.grd_grid_zone_SE, 'String')) ||...
        isempty(get(h.grd_grid_zone_SW, 'String'))    
        check = 0;
    else
        check = 1;
    end
else
    check = 1;
end

function tmp_grid = make_struct(h)
tmp_grid = struct;
tmp_grid.name       = get(h.grd_grid_name, 'String');
tmp_grid.cross_zn   = get(h.grd_utm_yes, 'Value');
tmp_grid.cross_eq   = get(h.grd_eq_yes, 'Value');
tmp_grid.min_east   = str2double(get(h.grd_grid_min_easting, 'String'));
tmp_grid.max_east   = str2double(get(h.grd_grid_max_easting, 'String'));
tmp_grid.min_north  = str2double(get(h.grd_grid_min_northing, 'String'));
tmp_grid.max_north  = str2double(get(h.grd_grid_max_northing, 'String'));
tmp_grid.res        = str2double(get(h.grd_grid_resolution, 'String'));
tmp_grid.vent_zone  = str2double(get(h.grd_vent_zone, 'String'));
tmp_grid.elevation  = str2double(get(h.grd_grid_elevation, 'String'));

if get(h.grd_utm_yes, 'Value') == 0 && get(h.grd_eq_yes, 'Value') == 0
    tmp_grid.zone   = str2double(get(h.grd_grid_zone, 'String'));
elseif get(h.grd_utm_yes, 'Value') == 1 && get(h.grd_eq_yes, 'Value') == 0
    tmp_grid.zone_W = str2double(get(h.grd_grid_zone_W, 'String'));
    tmp_grid.zone_E = str2double(get(h.grd_grid_zone_E, 'String'));
elseif get(h.grd_utm_yes, 'Value') == 0 && get(h.grd_eq_yes, 'Value') == 1
    tmp_grid.zone_N = str2double(get(h.grd_grid_zone_N, 'String'));
    tmp_grid.zone_S = str2double(get(h.grd_grid_zone_S, 'String'));
elseif get(h.grd_utm_yes, 'Value') == 1 && get(h.grd_eq_yes, 'Value') == 1
    tmp_grid.zone_NW = str2double(get(h.grd_grid_zone_NW, 'String'));
    tmp_grid.zone_NE = str2double(get(h.grd_grid_zone_NE, 'String'));
    tmp_grid.zone_SW = str2double(get(h.grd_grid_zone_SW, 'String'));
    tmp_grid.zone_SE = str2double(get(h.grd_grid_zone_SE, 'String'));
end

function make_grid(tmp, dsp, sve)
% dsp:          choose if display map or not
% sve:          choose if save or not


% Case 1: Do not cross zone nor equator
if tmp.cross_zn == 0 && tmp.cross_eq == 0
    [TL_lat, TL_lon] = utm2ll(tmp.min_east, tmp.max_north, tmp.zone);
    [TR_lat, TR_lon] = utm2ll(tmp.max_east, tmp.max_north, tmp.zone);
    [BL_lat, BL_lon] = utm2ll(tmp.min_east, tmp.min_north, tmp.zone);
    [BR_lat, BR_lon] = utm2ll(tmp.max_east, tmp.min_north, tmp.zone);
    
    min_lat          = min([TL_lat, BL_lat]);
    max_lat          = max([TR_lat, BR_lat]);
    min_lon          = min([BL_lon, BR_lon]);
    max_lon          = max([TL_lon, TR_lon]);
   
% Case 2: Cross utm zones
elseif tmp.cross_zn == 1 && tmp.cross_eq == 0 

    [TL_lat, TL_lon] = utm2ll(tmp.min_east, tmp.max_north, tmp.zone_W);
    [TR_lat, TR_lon] = utm2ll(tmp.max_east, tmp.max_north, tmp.zone_E);
    [BL_lat, BL_lon] = utm2ll(tmp.min_east, tmp.min_north, tmp.zone_W);
    [BR_lat, BR_lon] = utm2ll(tmp.max_east, tmp.min_north, tmp.zone_E);
    
    min_lat          = min([TL_lat, BL_lat]);
    max_lat          = max([TR_lat, BR_lat]);
    min_lon          = min([BL_lon, BR_lon]);
    max_lon          = max([TL_lon, TR_lon]);
    
    
% Case 3: Cross equator
elseif tmp.cross_zn == 0 && tmp.cross_eq == 1
    
    [TL_lat, TL_lon] = utm2ll(tmp.min_east, tmp.max_north, tmp.zone_N);
    [TR_lat, TR_lon] = utm2ll(tmp.max_east, tmp.max_north, tmp.zone_N);
    [BL_lat, BL_lon] = utm2ll(tmp.min_east, tmp.min_north, tmp.zone_S);
    [BR_lat, BR_lon] = utm2ll(tmp.max_east, tmp.min_north, tmp.zone_S);
    
    min_lat          = min([TL_lat, BL_lat]);
    max_lat          = max([TR_lat, BR_lat]);
    min_lon          = min([BL_lon, BR_lon]);
    max_lon          = max([TL_lon, TR_lon]);
    
% Case 4: Cross both utm zones and equator
elseif tmp.cross_zn == 1 && tmp.cross_eq == 1  
    
    [TL_lat, TL_lon] = utm2ll(tmp.min_east, tmp.max_north, tmp.zone_NW);
    [TR_lat, TR_lon] = utm2ll(tmp.max_east, tmp.max_north, tmp.zone_NE);
    [BL_lat, BL_lon] = utm2ll(tmp.min_east, tmp.min_north, tmp.zone_SW);
    [BR_lat, BR_lon] = utm2ll(tmp.max_east, tmp.min_north, tmp.zone_SE);
    
    min_lat          = min([TL_lat, BL_lat]);
    max_lat          = max([TR_lat, BR_lat]);
    min_lon          = min([BL_lon, BR_lon]);
    max_lon          = max([TL_lon, TR_lon]);

end

 
[min_e, min_n]   = ll2utm(min_lat, min_lon, tmp.vent_zone);
[max_e, max_n]   = ll2utm(max_lat, max_lon, tmp.vent_zone);

% Correction for the southern hemisphere
if tmp.cross_eq == 1 
    if tmp.vent_zone < 0
        max_n = max_n+1e7;
    else
        min_n = -(1e7-min_n);
    end
end

x_vec = min_e : tmp.res : max_e;
y_vec = min_n : tmp.res : max_n;


%% Create the mesh
[utmx, utmy] = meshgrid(x_vec, y_vec);      % Create easting and northing matrices      
%[lat, lon]   = utm2ll(utmx, utmy, ones(size(utmx)).*tmp.vent_zone);
utmy         = flipud(utmy);             % Symetry

%% Convert into lat/lon and create 3-columns grid in UTM
[lat, lon, utm, dat] = fill_matrix(utmx, utmy, tmp.vent_zone, tmp);



%% Save matrices
if sve == 1
    write_matrix(tmp, lat, lon, utm, utmx, utmy, dat);
end

%% Display map
if dsp == 1
    display_map(lat, lon);
end

function display_map(lat, lon)
% Display the grid extent on a map
figure;
h1 = fill([min(min(lon)); max(max(lon)); max(min(lon)); min(max(lon))], [max(max(lat)); max(max(lat)); min(min(lat)); min(min(lat))], 'r'); 
set(h1, 'FaceAlpha', .3);
hold on;
%plot(lon, lat, 'xr')
plot_google_map('maptype', 'terrain', 'MapScale', 1);
xlabel('Longitude');
ylabel('Latitude');
axis equal

function write_matrix(tmp, lat, lon, utm, utmx, utmy, dat)
% Saving data
mkdir(fullfile('GRID', tmp.name));
out_name = fullfile('GRID',tmp.name,tmp.name);
wb = waitbar(0,'Writing grid...');
save([out_name, '.mat'], 'tmp');
waitbar(1 / 7);
dlmwrite([out_name, '.utm'], utm, 'delimiter', ' ', 'precision', '%.0f');
waitbar(2 / 7);
writeIt(dat, [out_name, '.dat']);
waitbar(3 / 7);
writeIt(utmx, [out_name, '_utmx.dat']);
waitbar(4 / 7);
writeIt(utmy, [out_name, '_utmy.dat']);
waitbar(5 / 7);
writeIt(lat, [out_name, '_lat.dat']);
waitbar(6 / 7);
writeIt(lon, [out_name, '_lon.dat']);
waitbar(7 / 7);
close(wb);
msgbox('Your grid is ready!');

function [lat, lon, utm, dat] = fill_matrix(utmx, utmy, zone_max, tmp)
% Shapes data into final output

col = size(utmx, 2);	% Number of columns
lin = size(utmx, 1);	% Number of lines

% Preparing coordinate matrix in Lat/Lon
lat = zeros(lin, col);
lon = zeros(lin, col);
zone_mat = ones(size(utmx)).*zone_max;

wb       = waitbar(0,'Filling matrix...');

% Note: got rid of one loop, but UTM2ll does not work with matrices
for i = 1:lin
    [LT, LN] = utm2ll(utmx(i,:), utmy(i,:), zone_mat(i,:));	% Calculate lat/lon coordinate for each point
    
    lat(i,:) = LT;	% Fills up lat matrix
    lon(i,:) = LN;	% Fills up lon matrix
    waitbar(i / lin);
end
close(wb)

utm         = zeros(numel(utmy),3);	% Final XYZ utm matrix (for TEPHRA2 calculations)
utm(:,3)    = ones(numel(utmy),1).*tmp.elevation; 
dat         = zeros(lin, col);      % Final M*N matrix (for map display)

% Filling up final XYZ utm matrix
j = 1;
wb       = waitbar(0,'Making calculation grid...');
for i = 1:lin
    utm(j:i*col,1) = shiftdim(utmx(i,:));
    utm(j:i*col,2) = shiftdim(utmy(i,:));
    j = i*col+1;
    waitbar(i / lin);
end
close(wb)
