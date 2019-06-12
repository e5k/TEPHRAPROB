#!/usr/bin/env python
from ecmwfapi import ECMWFDataServer
import calendar
import os
## Enter the required data below

# Time of dataset
year_start  = 2004
year_end    = 2018
month_start = 1
month_end   = 12
# Area
north       = 64.25
south       = 63.5
west        = 19.25
east        = 20
# Output folder, i.e. replace by your project name
out_path    = 'WIND/hekla_interim_0418/nc/'

CLASS 		= "ei"
DATASET 	= "interim"

##################################################
#os.mkdir(out_path)
#os.mkdir(out_path+"nc_output_files")
#os.mkdir(out_path+"txt_output_files")
server = ECMWFDataServer()
count  = 1
for year in range(year_start, year_end+1):
    if len(range(year_start, year_end+1)) == 1:
        mt_start = month_start
        mt_end = month_end
    else:
        if year == year_start:
            mt_start = month_start
            mt_end = 12
        elif year == year_end:
            mt_start = 1
            mt_end = month_end
        else:
            mt_start = 1
            mt_end = 12
    for month in range(mt_start, mt_end+1):
        lastday1=calendar.monthrange(year,month)
        lastday=lastday1[1]
        bdate="%s%02d01"%(year,month)
        edate="%s%02d%s"%(year,month,lastday)

        print("######### ERA-interim  #########")
        print('Accessing wind data from ', bdate,' to ',edate,' (YYYYMMDD)')
        print("################################")
        
        server.retrieve({
            'dataset'   : DATASET,
            'date'      : "%s/to/%s"%(bdate,edate),
            'time'      : "00/06/12/18",
            'step'      : "0",
            'stream'    : "oper",
            'levtype'   : "pl",
            'levelist'  : "all",
            'type'      : "an",
            'class'     : CLASS,
            'grid'      : "0.25/0.25",
            'param'     : "129/131/132/156",
            'area'      : "%3.2f/%3.2f/%3.2f/%3.2f"%(north, west, south, east),
            'format'    : 'netcdf',
            'target'    : "%s%05d_%s_%04d.nc"%(out_path, count, calendar.month_abbr[month],year)
        }) 
        
        count = count + 1