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

Name:       dwind_NOAA.m
Purpose:    Download NetCDF wind files from the NOAA NCEP/NCAR database
Author:     S�bastien Biass
Created:    April 2015
Updates:    April 2015
Copyright:  S�bastien Biass, University of Geneva, 2015
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


function dwind_NOAA
% Check that you are located in the correct folder!
if ~exist([pwd, filesep, 'tephraProb.m'], 'file')
    errordlg(sprintf('You are located in the folder:\n%s\nIn Matlab, please navigate to the root of the TephraProb\nfolder, i.e. where tephraProb.m is located. and try again.', pwd))
    return
end

global project_param 

global yrs mts dys hrs;     % Strings for popup menus

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
    'Name', 'TephraProb: Download NOAA wind profiles',...
    'NumberTitle', 'off');

w.wind1 = uipanel(...
    'units', 'normalized',...
    'position', [.025 .025 .95 .95],...
    'title', 'NOAA NCEP/NCAR Reanalysis',...
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
    'position', [.55 .1 .4 .66],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Note: Latitudes are expressed as N/S. Longitudes are expressed as E only!');

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
y1 = 1948;
y2 = date; y2 = str2double(y2(end-3:end));
yn = y2 - y1;
for i = 1:yn+1
    yrs{i} = num2str(y1+i-1);
end
% Set months
mts = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'};
% Set day
dys = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31'};
% Set hours
hrs = {'00 Z', '06 Z', '12 Z', '18 Z'};
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

w.wind3_s_day = uicontrol(...
    'Style', 'popupmenu',...
    'Parent', w.wind3,...
    'units', 'normalized',...
    'position', [.35 .36 .285 .15],...
    'ForegroundColor', [.75 .75 .75],...
    'BackgroundColor', [.35 .35 .35],...
    'String', dys);

w.wind3_e_day = uicontrol(...
    'Style', 'popupmenu',...
    'Parent', w.wind3,...
    'units', 'normalized',...
    'position', [.65 .36 .285 .15],...
    'ForegroundColor', [.75 .75 .75],...
    'BackgroundColor', [.35 .35 .35],...
    'String', dys);

w.wind3_day = uicontrol(...
    'parent', w.wind3,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.075 .34 .25 .15],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Day:');

w.wind3_s_hour = uicontrol(...
    'Style', 'popupmenu',...
    'Parent', w.wind3,...
    'units', 'normalized',...
    'position', [.35 .19 .285 .15],...
    'ForegroundColor', [.75 .75 .75],...
    'BackgroundColor', [.35 .35 .35],...
    'String', hrs);

w.wind3_e_hour = uicontrol(...
    'Style', 'popupmenu',...
    'Parent', w.wind3,...
    'units', 'normalized',...
    'position', [.65 .19 .285 .15],...
    'ForegroundColor', [.75 .75 .75],...
    'BackgroundColor', [.35 .35 .35],...
    'String', hrs);

w.wind3_hour = uicontrol(...
    'parent', w.wind3,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.075 .17 .25 .15],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Hour:');

w.wind3_last_data = uicontrol(...
    'parent', w.wind3,...
    'style', 'text',...
    'units', 'normalized',...
    'position', [.075 .0 .9 .15],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'String', 'Last available data:        ');

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

% Sets last available data
pge = urlread('http://www.esrl.noaa.gov/psd/cgi-bin/db_search/DBSearch.pl?Dataset=NCEP+Reanalysis+Pressure+Level&Variable=Geopotential+height&group=0&submit=Search');
s = strfind(pge, '1948/1/1');
e = strfind(pge, '18:00:00');
set(w.wind3_last_data, 'String', [get(w.wind3_last_data, 'String'), pge(s+18:e+8)]);

% Callback functions
    % Main panel
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
    tmp.dy_s    =   dys{get(w.wind3_s_day, 'Value')};
    tmp.dy_e    =   dys{get(w.wind3_e_day, 'Value')};
    tmp.hr_s    =   hrs{get(w.wind3_s_hour, 'Value')};
    tmp.hr_e    =   hrs{get(w.wind3_e_hour, 'Value')};
    tmp.folder  =   ['WIND', filesep, tmp.name, filesep];

%     eval(['project_param.winddata_', tmp.name, ' = tmp;']);
%     save([project_param.proj_path, filesep, project_param.proj_name, filesep, project_param.proj_name, '.mat'], 'project_param');

    % Create folder

    if exist(tmp.folder, 'dir') == 7
        choice = questdlg('This name is already taken. Overwrite?', ...
        '', 'Yes','No','No');
        switch choice
            case 'Yes'
                rmdir(tmp.folder, 's');
                mkdir(tmp.folder);
                mkdir([tmp.folder, filesep, 'nc_output_files', filesep]);
                %mkdir([tmp.folder, filesep, 'tmp', filesep]);
                mkdir([tmp.folder, filesep, 'txt_output_files', filesep]);
                %mkdir([tmp.folder, filesep, 'dl', filesep]);
                dlmwrite([tmp.folder, filesep,'.ncep'], '.ncep');
                download(w);
            case 'No'
        end
    else
        mkdir(tmp.folder);
        mkdir([tmp.folder, filesep, 'nc_output_files', filesep]);
        %mkdir([tmp.folder, filesep, 'tmp', filesep]);
        mkdir([tmp.folder, filesep, 'txt_output_files', filesep]);
        %mkdir([tmp.folder, filesep, 'dl', filesep]);
        dlmwrite([tmp.folder, filesep,'.ncep'], '.ncep');
        download(w);
    end
    
%    save([tmp.folder, tmp.name, '.mat'], tmp);
    
end

% Download WIND
function w = download(w, varargin)
global tmp

% If the downloading was interupted, this bit restarts it
if isempty(varargin)
    group_start = 1;
    c = 1;
    count = 1;
else                                                                        % VARARGIN = number of files already downloaded
    dw_files = varargin{1};                                     
    if      dw_files < 17
        group_start = 1;
    elseif  dw_files >= 17 && dw_files < 34
        group_start = 2;
    elseif  dw_files >= 34
        group_start = 3;
    end
    
    if mod(dw_files, 17) == 0
        c = 1;
    else
        c = mod(dw_files, 17);
    end
    
    count = dw_files;
end
    

hour_start = tmp.hr_s(1,1:2);
hour_end = tmp.hr_e(1,1:2);
month_list = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};


% msg = msgbox('Downloading wind can take time... Please be patient!');
% waitfor(msg);

% Find tid variable
pge = urlread('http://www.esrl.noaa.gov/psd/cgi-bin/db_search/DBSearch.pl?Dataset=NCEP+Reanalysis+Pressure+Level&Variable=Geopotential+height&group=0&submit=Search');
fnd = strfind(pge, 'tid=');
tid = pge(fnd(1)+4:fnd(1)+8);

str1 = 'http://www.esrl.noaa.gov/psd/cgi-bin/DataAccess.pl?DB_dataset=NCEP+Reanalysis+Pressure+Level&DB_variable=Geopotential+height&DB_statistic=Individual+Obs&DB_tid=';
str2 = '&DB_did=2&DB_vid=14';

% Find nc variable
pge = urlread(strcat(str1, tid, str2));
fnd = strfind(pge, 'y4.nc');
nc = pge(fnd(1)+6:fnd(1)+10);

try
    % Waitbar
    wtb = waitbar(0, '', 'Name', 'Downloading wind...', 'Color', [.25 .25 .25],...
        'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
    wtb1 = uicontrol('Parent', wtb,...
    'style', 'text',...
    'units', 'normalized',...
    'Position', [.05 .68 .9 .28],...
    'HorizontalAlignment', 'left',...
    'BackgroundColor', [.25 .25 .25],...
    'ForegroundColor', [1 1 1],...
    'string', 'Downloading wind, please wait...');
    setappdata(wtb,'canceling',0);
    set(findobj(wtb,'type','patch'), ...
    'edgecolor',[0 0 0],'facecolor',[.9 .5 .0]);

    %count = 1;
    for i = group_start:3
       k=1;   
       if i==1
           group = 'gheight';
           name = 'hgt';
           vid = '14';
           unit = 'm';
       elseif i==2
           group = 'uwind';
           name = 'uwnd';
           vid = '18';
           unit = 'm%2Fs';
       elseif i==3
           group = 'vwind';
           name = 'vwnd';
           vid = '19';
            unit = 'm%2Fs';
%        elseif i==4
%            group = 'relhum';
%            name = 'rhum';
%            vid = '16';
%            unit = '%25';
%        elseif i==5
%            group = 'temp';
%            name = 'air';
%            vid = '13';
%            unit = 'degK';
       end

       
       for k=1:1*10^9
                while c<18
                    % Check for Cancel button press
                    if getappdata(wtb1,'canceling')
                        ME = 'Cancel';
                        break
                    end 
                   tic;
                   a=[1000, 925, 850, 700, 600, 500, 400, 300, 250, 200, 150, 100, 70, 50, 30, 20, 10];
                   j=a(c);
                   j=num2str(j);
                   level = j;

                   str1 = 'http://www.esrl.noaa.gov/psd/cgi-bin/GrADS.pl?dataset=NCEP+Reanalysis+Pressure+Level&DB_did=2&file=%2FDatasets%2Fncep.reanalysis%2Fpressure%2F';
                   str2 = '.1948.nc+';
                   str3 = '.%25y4.nc+';
                   str21 = '&variable=';
                   str4 = '&DB_vid=';
                   str5 = '&DB_tid=';
                   str20 = '&units=';
                   str6 = '&longstat=Individual+Obs&DB_statistic=Individual+Obs&stat=&lat-begin=';
                   str7 = '&lat-end=';
                   str8 = '&lon-begin=';
                   str9 = '&lon-end=';
                   str10 = '&dim0=level&level+units=millibar&level=';
                   str11 = '&dim1=time&year_begin=';
                   str12 = '&mon_begin=';
                   str13 = '&day_begin=';
                   str14 = '&hour_begin=';
                   str15 = '+Z&year_end=';
                   str16 = '&mon_end=';
                   str17 = '&day_end=';
                   str18 = '&hour_end=';
                   str19 = '+Z&X=lon&Y=lat&output=file&bckgrnd=black&use_color=on&cint=&range1=&range2=&scale=100&submit=Create+Plot+or+Subset+of+Data';

                   page = strcat(str1,name,str2,name,str3,nc,str21,name,str4,vid,str5,tid,str20,unit,str6,tmp.lat,str7,tmp.lat,str8,tmp.lon,str9,tmp.lon,str10,j,str11,tmp.yr_s,str12,char(month_list(str2num(tmp.mt_s))),str13,tmp.dy_s,str14,hour_start,str15,tmp.yr_e,str16,char(month_list(str2num(tmp.mt_e))),str17,tmp.dy_e,str18,hour_end,str19);

                   [content, statut] = urlread(page);
                   if statut == 0
                       statut
                       page
                       break
                   else
                       c=c+1;

                       folder = 'Public/www/';
                       firs = strfind(content,'ftp.cdc.noaa.gov/Public/www/');
                       last = strfind(content,'>FTP a copy of the file');

                       url1 = content(1,firs:last-1);
                       mid = strfind(url1, 'X');
                       url = url1(1,mid:length(url1));

                       ftpobj = ftp('ftp.cdc.noaa.gov');
                       cd(ftpobj, folder);
                       mget(ftpobj, url, [tmp.folder, filesep, 'dl']);

%                        yr1 = tmp.yr_s(:,length(tmp.yr_s)-1:length(tmp.yr_s));
%                        yr2 = tmp.yr_e(:,length(tmp.yr_e)-1:length(tmp.yr_e));

                       filename = strcat(group,'_',j,'mb','.nc');
                       pth = [tmp.folder, 'nc_output_files', filesep, filename];
                       movefile([tmp.folder, 'dl', filesep, url], pth);
                       
                       % Updates Waitbar
                       elapsT = toc;
                       T(count) = elapsT;
                       remain_time = mean(T)*(51-count);
                       if remain_time < 60
                           tm = [num2str(round(remain_time)), ' seconds'];
                       else
                           tm = [num2str(round(remain_time/60)), ' minutes'];
                       end
                       waitbar(count/51, wtb);
                       %set(wtb1, 'String', sprintf('Downloading file %i/85 - %s %s mb \nRemaining time: about %s', count, group, level, tm));
                       count = count+1;
                   end
               end

               if statut == 1;
                   break
               end
       end
       c = 1;
       j = [];
    end
catch ME
   
end

if exist('ME', 'var')
    delete(gcf)
    if strcmp(ME, 'Cancel')
    else
        
        %delete(wtb)
        %choice = questdlg('There was an error trying to download wind data. Try again?', '', 'No', 'Yes', 'Yes');
        choice = 'Yes';
        switch choice
            case 'Yes'
                nbfl = length(dir([tmp.folder, filesep, 'nc_output_files', filesep, '*.nc']));
                download(w, nbfl);
%             case 'No'
%                 delete(choice);
        end
    end
    if exist('ftpobj')
        close(ftpobj);
    end
    
else
    rmdir([tmp.folder, 'dl'], 's');
    delete(wtb);
    msg = msgbox('Your wind files have been downloaded');
    waitfor(msg);
    process_wind(tmp.folder);
end
