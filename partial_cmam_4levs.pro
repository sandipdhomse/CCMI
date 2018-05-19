PRO write_htap_tracer_nc_ES4,ncfile,lon,lat,p,time,vmr_ozone,tracid,vname1,vname2,vname3,syear

ncid=NCDF_CREATE(ncfile,/CLOBBER)
londim   = NCDF_DIMDEF(ncid,'lon',n_elements(lon))
latdim   = NCDF_DIMDEF(ncid,'lat',n_elements(lat))
pivdim   = NCDF_DIMDEF(ncid,'plev',n_elements(p))
timdim   = NCDF_DIMDEF(ncid,'time',/unlimited)
btimdim   = NCDF_DIMDEF(ncid,'bnds',2)

idlon  = NCDF_VARDEF(ncid,'lon', [londim],/DOUBLE)
;idlon1  = NCDF_VARDEF(ncid,'lon_bnds', [btimdim,londim],/DOUBLE)
idlat  = NCDF_VARDEF(ncid,'lat', [latdim],/DOUBLE)
;idlat1  = NCDF_VARDEF(ncid,'lat_bnds', [btimdim,latdim],/DOUBLE)
idpiv  = NCDF_VARDEF(ncid,'plev', [pivdim],/DOUBLE)
idtim  = NCDF_VARDEF(ncid,'time', [timdim],/DOUBLE)
;idtim1  = NCDF_VARDEF(ncid,'time_bnds', [btimdim,timdim],/DOUBLE)

ido3=NCDF_VARDEF(ncid,"partial_col",[londim,latdim,pivdim,timdim],/FLOAT)


spawn,'date +%F',t1
spawn,'date +%T',t2
;;ctime=t1+'-T'+t2+'Z'


NCDF_ATTPUT, ncid, /GLOBAL, 'project_id', 'CCMI1'
NCDF_ATTPUT, ncid, /GLOBAL, 'product', 'output'
NCDF_ATTPUT, ncid, /GLOBAL, 'institute_id', 'U-LEEDS'
NCDF_ATTPUT, ncid, /GLOBAL, 'experiment_id', 'refC1SD'
NCDF_ATTPUT, ncid, /GLOBAL, 'frequency', 'mon'
NCDF_ATTPUT, ncid, /GLOBAL, 'modeling_realm', 'atmos'
;;NCDF_ATTPUT, ncid, /GLOBAL, 'source', 'UM4.5L64'
NCDF_ATTPUT, ncid, /GLOBAL, 'table_id', 'monthly'
NCDF_ATTPUT, ncid, /GLOBAL, 'table_date', '06 August 2014'
NCDF_ATTPUT, ncid, /GLOBAL, 'realization', '1'
NCDF_ATTPUT, ncid, /GLOBAL, 'initialization_method', '1'
NCDF_ATTPUT, ncid, /GLOBAL, 'initialization_description', 'N/A'
NCDF_ATTPUT, ncid, /GLOBAL, 'physics_version', '1'
NCDF_ATTPUT, ncid, /GLOBAL, 'branch_time', '0.0'
NCDF_ATTPUT, ncid, /GLOBAL, 'contact', 'Sandip Dhomse and Martyn Chipperfield (s.dhomse@see.leeds.ac.uk)'
NCDF_ATTPUT, ncid, /GLOBAL, 'Conventions', 'CF-1.4'
;;NCDF_ATTPUT, ncid, /GLOBAL, 'creation_date', '2014-06-22-T12:00:00Z'
NCDF_ATTPUT, ncid, /GLOBAL, 'creation_date', t1[0]+'-T'+t2[0]+'Z' 
NCDF_ATTPUT, ncid, /GLOBAL, 'forcing', '0.0'
NCDF_ATTPUT, ncid, /GLOBAL, 'institution', 'University of Leeds, UK'
NCDF_ATTPUT, ncid, /GLOBAL, 'parent_experiment_id', 'N/A'
NCDF_ATTPUT, ncid, /GLOBAL, 'parent_experiment_rip', 'N/A'
NCDF_ATTPUT, ncid, /GLOBAL, 'cmor_version', '2.5.0'
NCDF_ATTPUT, ncid, /GLOBAL, 'tracking_id', tracid

NCDF_ATTPUT, ncid,idlon,'long_name','longitude'
NCDF_ATTPUT, ncid,idlon,'axis','X'
NCDF_ATTPUT, ncid,idlon,'units','degrees_east'
NCDF_ATTPUT, ncid,idlon,'standard_name','longitude'
NCDF_ATTPUT, ncid,idlon,'out_name','lon'
NCDF_ATTPUT, ncid,idlon,'valid_min',0.0
NCDF_ATTPUT, ncid,idlon,'valid_max',360.0
NCDF_ATTPUT, ncid,idlon,'stored_direction','increasing'
NCDF_ATTPUT, ncid,idlon,'type','double'
NCDF_ATTPUT, ncid,idlon,'must_have_bounds','no'

;NCDF_ATTPUT, ncid,idlon1,'long_name','lon_bnds'
;NCDF_ATTPUT, ncid,idlon1,'standard_name','lon_bnds'


NCDF_ATTPUT, ncid,idlat,'long_name','latitude'
NCDF_ATTPUT, ncid,idlat,'axis','Y'
NCDF_ATTPUT, ncid,idlat,'units','degrees_north'
NCDF_ATTPUT, ncid,idlat,'standard_name','latitude'
NCDF_ATTPUT, ncid,idlat,'out_name','lat'
NCDF_ATTPUT, ncid,idlat,'valid_min',-90.0
NCDF_ATTPUT, ncid,idlat,'valid_max',90.0
NCDF_ATTPUT, ncid,idlat,'stored_direction','increasing'
NCDF_ATTPUT, ncid,idlat,'type','double'
NCDF_ATTPUT, ncid,idlat,'must_have_bounds','no'

;NCDF_ATTPUT, ncid,idlat1,'long_name','lat_bnds'
;NCDF_ATTPUT, ncid,idlat1,'standard_name','lat_bnds'



NCDF_ATTPUT, ncid,idpiv,'long_name','partial_levels'
NCDF_ATTPUT, ncid,idpiv,'axis','Z'
NCDF_ATTPUT, ncid,idpiv,'units','Pa'
NCDF_ATTPUT, ncid,idpiv,'positive','down'
NCDF_ATTPUT, ncid,idpiv,'standard_name','partial_levles'
NCDF_ATTPUT, ncid,idpiv,'out_name','lev'
NCDF_ATTPUT, ncid,idpiv,'stored_direction','decreasing'
;NCDF_ATTPUT, ncid,idpiv,'tolerance',0.001
NCDF_ATTPUT, ncid,idpiv,'must_have_bounds','no'

NCDF_ATTPUT, ncid,idtim,'long_name','time'
NCDF_ATTPUT, ncid,idtim,'axis','T'
NCDF_ATTPUT, ncid,idtim,'units','months since '+syear+'-01-15 00:00:00'
NCDF_ATTPUT, ncid,idtim,'calendar','365_day'
NCDF_ATTPUT, ncid,idtim,'standard_name','time'
NCDF_ATTPUT, ncid,idtim,'out_name','time'
NCDF_ATTPUT, ncid,idtim,'stored_direction','increasing'
NCDF_ATTPUT, ncid,idtim,'type','double'
NCDF_ATTPUT, ncid,idtim,'must_have_bounds','yes'


;NCDF_ATTPUT, ncid,idtim1,'long_name','time_bnds'
;NCDF_ATTPUT, ncid,idtim1,'units','days since 1950-01-01 00:00:00'
;NCDF_ATTPUT, ncid,idtim1,'out_name','time_bnds'


NCDF_ATTPUT, ncid,ido3,'long_name','partial_columns_ozone'
NCDF_ATTPUT, ncid,ido3,'units','DU'
NCDF_ATTPUT, ncid,ido3,'standard_name','partial_column_ozone'
NCDF_ATTPUT, ncid,ido3,'comments',"troospheric ozone (surface to 100 hPa (170 hpa for lat >30), lower strat ozone (170/100  to 32 hPa) middle strat: 32 to 10 hPa, upper strat (pressure >10 hPa)"

NCDF_ATTPUT, ncid,ido3,'_FillValue',1.E20
NCDF_ATTPUT, ncid,ido3,'missing_value',1.E20
NCDF_ATTPUT, ncid,ido3,'valid_min',0.
NCDF_ATTPUT, ncid,ido3,'valid_max',1.

NCDF_CONTROL, ncid, /ENDEF

ntime=n_elements(time)
nlats=n_elements(lat)
nlons=n_elements(lon)

time1=dblarr(2,ntime)*0
lat1=dblarr(2,nlats)*0

lon1=dblarr(2,nlons)*0

lon1[0,*]=lon-1.87500*1.D
lon1[1,*]=lon+1.87500*1.D

time1[0,*]=time-15.*1.D
time1[1,*]=time+14.*1.D
lat1[0,*]=lat-1.25*1.D
lat1[1,*]=lat+1.25*1.D

help,time1

NCDF_VARPUT, ncid, idlon, lon
;NCDF_VARPUT, ncid, idlon1, lon1
NCDF_VARPUT, ncid, idlat, lat
;NCDF_VARPUT, ncid, idlat1, lat1
NCDF_VARPUT, ncid, idpiv, p       
NCDF_VARPUT, ncid, idtim, time
;NCDF_VARPUT, ncid, idtim1, time1
NCDF_VARPUT, ncid, ido3,vmr_ozone 
NCDF_CLOSE, ncid

END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


infile="/nfs/a245/fbsssdh/CCMI/toz/refC1SD/vmro3/CMAM/r1i1p1/v1/vmro3_monthly_CMAM_refC1SD_r1i1p1_198001-201012.nc"
ofile="/nfs/a258/fbsssdh/For_Andreas/partial_CMAM_refC1SD_r1i1p1_1980.nc"
syear= "1980"

for bb=0,0  do begin 
   
   
   print,infile
   id=ncdf_open(infile)
   tempid=ncdf_varid(id,"vmro3")
   pid=ncdf_varid(id,"lev")
   latid=ncdf_varid(id,"lat")
   lonid=ncdf_varid(id,"lon")
   tid=ncdf_varid(id,"time")
   aid=ncdf_varid(id,"ap")
   bid=ncdf_varid(id,"b")
   aaid=ncdf_varid(id,"ap_bnds")
   abid=ncdf_varid(id,"b_bnds")
;;   p0id=ncdf_varid(id,"p0")
   psid=ncdf_varid(id,"ps")
   
   ncdf_varget,id,pid,pp   
   ncdf_varget,id,tempid,o3
   ncdf_varget,id,latid,lats
   ncdf_varget,id,aid,hyam
   ncdf_varget,id,bid,hybm
   ncdf_varget,id,aaid,hyam1
   ncdf_varget,id,abid,hybm1
  ;; ncdf_varget,id,p0id,p0
   ncdf_varget,id,psid,ps
   ncdf_varget,id,latid,lats
   ncdf_varget,id,lonid,lons
   ncdf_varget,id,tid,t1
   NCDF_CLOSE, id
   
   jj2=julday(1,1,1960)
   jj1=julday(1,1,1950)
   
   tdiff=jj2-jj1
   
   nlat=n_elements(lats)
   nlon=n_elements(lons)
   ntime=n_elements(t1)
   nlev=n_elements(hyam)
   print,ntime
   newdata=fltarr(nlon,nlat,4,ntime)
   newdata1=fltarr(1,nlat,4,ntime)
   plev = [100000, 85000, 70000, 50000, 40000, 30000, 25000, 20000, 17000,$
           15000, 13000, 11500, 10000, 9000, 8000, 7000, 5000, 3000, 2000, 1500,$
           1000, 700, 500, 300, 200, 150, 100, 50, 30.000, 20, 10]
   plev=plev/100.
   c_boltzman = 1.380503E-23
   for t=0,ntime-1 do begin 
     for i =0,nlat-1 do begin
        for j =0,nlon-1 do begin
            pp=hyam[*]+(hybm[*]*ps[j,i,t])
            app=hyam1[0,*]+(hybm1[0,*]*ps[j,i,t])
            bpp=hyam1[1,*]+(hybm1[1,*]*ps[j,i,t])
            dp=reform(app-bpp)
           COLFAC=2.132E20
            alat=lats[i]
            ylim=170.
          ;  if (alat le -60.) then ylim=200.
          ;  if ((alat ge -60.) and (alat le -30.)) then ylim=150.
            if ((alat ge -30.) and (alat le 30.)) then ylim=100.
           ; if ((alat ge 30) and (alat le 60.)) then ylim=150.
           ; if (alat ge 60 ) then ylim=200.
            
            pp1=pp/100.
            
            x1=where(pp1 ge ylim)
            x2=where(pp1 le ylim)
            x3=where(pp1  le 32.)
            x4=where(pp1  le 10.)

            tracer=o3[j,i,*,t]*dp[*]*colfac
            c1=total(tracer[x1])/(2.69*1.e16)
            c2=total(tracer[x2])/(2.69*1.e16)
            c3=total(tracer[x3])/(2.69*1.e16)
            c4=total(tracer[x4])/(2.69*1.e16)

            
            newdata[j,i,0,t]=c1
            newdata[j,i,1,t]=c2-c3
            newdata[j,i,2,t]=c3-c4
            newdata[j,i,3,t]=c4
           ;; print,alat,c1+c2 
         endfor
         
         for x=0,3 do begin 
            newdata1[0,i,x,t]=mean(newdata[*,i,x,t])
         endfor
        endfor
      for x=0,3 do newdata1[0,*,x,t]=smooth(newdata1[0,*,x,t],3,/edge_truncate)
     
   endfor

   pth2= ""
   vname1='pcol'
   vname2='pcol'
   vname3='pcol '
   lons=0.
   spawn,'uuidgen',uu
   app1=[0,1,2,3]
   t1=findgen(ntime)
   tracid=uu[0]
   print,ofile
   write_htap_tracer_nc_ES4,ofile,lons,lats,app1,t1,newdata1,tracid,vname1,vname2,vname3,syear
endfor
end
