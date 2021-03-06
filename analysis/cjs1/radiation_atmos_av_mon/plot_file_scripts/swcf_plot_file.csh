#!/bin/csh -f

echo
echo '- - - - - - - - - - - - - - - - -'
echo 'Starting script "'$0'"...'
echo '- - - - - - - - - - - - - - - - -'
echo
date
echo

if ( $#argv != 1 ) then	# must have 1 argument
  echo " Usage:  $0  plot_file_project"
  exit 1
endif

set plot_file_project = "$argv[1]"	# quotes necessary to retain blanks
                                	# and special characters

#=======================================================================
#
# ERBE obs data source:
#
#  Datasets constructed by Mark Crane:
#    /net/jjp/Datasets/obs/{lwcldfrc,swcldfrc,nswt,olr}.toa.mon.ltm.nc
#
#  have been consolidated into a compressed tar data file which is used as
#  a data source for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/ERBE/data.tar.gz
#
#=======================================================================
#
# CERES ERBE-like ES-4 obs data source:
#
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/level3_es4_table.html
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/ES4/Quality_Summaries/CER_ES4_Terra_Edition2.html
#
#  NASA CERES ERBE-like ES-4: Terra FM1 Edition2 Rev1
#  2.5 Degree Regional, Monthly (Day), Total-sky and Clear-sky
#  Averages
#
#  User Applied Revision "Rev1" applied to monthly CERES Terra
#  FM1 Edition2 variables for 5-year Climatology (3/00 - 2/05)
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/ES4/Quality_Summaries/CER_ES4_Terra_Edition2.html#user_revision
#
#  variables reference: Tables 4-4, 4-5 at
#  http://asd-www.larc.nasa.gov/ceres/collect_guide/ES4_CG.pdf
#
#  Referencing Data in Journal Articles:
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/ES4/Quality_Summaries/CER_ES4_Terra_Edition2.html#Referencing
#
#   Journal Article Reference:
#
#  Wielicki, B. A., B. R. Barkstrom, E. F. Harrison, R. B. Lee III, G. L. Smith,
#  and J. E. Cooper, 1996: Clouds and the Earth's Radiant Energy System (CERES):
#  An Earth Observing System Experiment, Bull. Amer. Meteor. Soc., 77, 853-868.
#
#   Acknowledgment:
#
#  "These data were obtained from the Atmospheric Science Data Center at
#   NASA Langley Research Center."
#
#  Acknowledgment from:
#  http://eosweb.larc.nasa.gov/GUIDE/dataset_documents/cer_es4.html#ack
#
#  "These data were obtained from the NASA Langley Research Center
#   Atmospheric Science Data Center."
#
#  Datasets:
#    CERES_ES4_rdir/lwcf.CER_ES4_Terra-FM1_Edition2.climo.nc
#    CERES_ES4_rdir/netcf.CER_ES4_Terra-FM1_Edition2_Rev1.climo.nc
#    CERES_ES4_rdir/swcf.CER_ES4_Terra-FM1_Edition2_Rev1.climo.nc
#    CERES_ES4_rdir/Total-sky/net_radiant_flux.CER_ES4_Terra-FM1_Edition2_Rev1.climo.nc
#    CERES_ES4_rdir/Total-sky/longwave_flux.CER_ES4_Terra-FM1_Edition2.climo.nc
#    CERES_ES4_rdir/Total-sky/swabs.CER_ES4_Terra-FM1_Edition2_Rev1.climo.nc
#    where CERES_ES4_rdir = /net/cjs/data/ceres/CER_ES4/Terra_Edition2/climatology/200003-200502/2.5_Degree_Regional/Monthly-Day
#
#  have been consolidated into a compressed tar data file which is used as
#  a data source for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/CERES_ES4/data.tar.gz
#
#=======================================================================
#
# CERES SRBAVG obs data source:
#
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/level3_srbavg_table.html
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/SRBAVG/Quality_Summaries/CER_SRBAVG_Edition2D_Terra_Aqua.html
#
#  NASA CERES SRBAVG Terra (CERES-FM1 or CERES-FM2) Edition2D-Rev1
#  1 Degree Monthly
#
#  User Applied Revision "Rev1" applied to monthly CERES Terra
#  (CERES-FM1 or CERES-FM2) Edition2D nonGEO and GEO SRBAVG1 variables
#  for 5-year Climatology (3/00 - 2/05)
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/SRBAVG/Quality_Summaries/CER_SRBAVG_Edition2D_Terra_Aqua.html#user_revision
#
#  Attribution - Referencing Data in Journal Articles from:
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/SRBAVG/Quality_Summaries/CER_SRBAVG_Edition2D_Terra_Aqua.html#refer
#
#   Journal Article Reference:
#
#  Wielicki, B. A., B. R. Barkstrom, E. F. Harrison, R. B. Lee III, G. L. Smith,
#  and J. E. Cooper, 1996: Clouds and the Earth's Radiant Energy System (CERES):
#  An Earth Observing System Experiment, Bull. Amer. Meteor. Soc., 77, 853-868.
#
#   Acknowledgment:
#
#  "These data were obtained from the NASA Langley Research Center EOSDIS
#   Distributed Active Archive Center."
# 
#  Acknowledgment from:
#  http://eosweb.larc.nasa.gov/GUIDE/dataset_documents/cer_srbavg.html#acknowledge
#
#  "These data were obtained from the NASA Langley Research Center
#   Atmospheric Science Data Center."
#
#  For CERES SRBAVG nonGEO, datasets:
#    /net/cjs/data/ceres/CER_SRBAVG/SRBAVG1/climatology/CER_SRBAVG1_Terra-FM1-Edition2D.nonGEO-Rev1.climo.{ctl,ieee}
#
#  have been consolidated into a compressed tar data file which is used as
#  a data source for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/CERES_SRBAVG_nonGEO/data.tar.gz
#
#  For CERES SRBAVG GEO, datasets:
#    /net/cjs/data/ceres/CER_SRBAVG/SRBAVG1/climatology/CER_SRBAVG1_Terra-FM1-Edition2D.GEO-Rev1.climo.{ctl,ieee}
#    /net/cjs/data/ceres/CER_SRBAVG/SRBAVG1/climatology/CER_SRBAVG1_Terra-XTRK-Edition2D.GEO-Rev1.climo.{ctl,ieee}
#    /net/cjs/data/ceres/CER_SRBAVG/SRBAVG1/climatology/CER_SRBAVG1_Terra-XTRK-FM1-Edition2D.GEO-Rev1.climo.{ctl,ieee}
#
#  have been consolidated into a compressed tar data file which is used as
#  a data source for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/CERES_SRBAVG_GEO/data.tar.gz
#
#=======================================================================
#
# CERES EBAF Edition1A obs data source:
#
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/level4_ebaf_table.html
#
#  NASA CERES EBAF Terra (CERES-FM1 or CERES-FM2) Edition1A
#  Energy Balanced and Filled 1 Degree Monthly (3/00 - 10/05) and
#  5-year Climatology (3/00 - 2/05)
#
#  Attribution from:
#  http://eosweb.larc.nasa.gov/PRODOCS/ceres/EBAF/Quality_Summaries/CER_EBAF_Terra_Edition1A.html
#
#   Journal Article Reference (updated using http://ams.allenpress.com/perlserv/?request=cite-builder&doi=10.1175%2F2008JCLI2637.1):
#
#  Loeb, N.G., B.A. Wielicki, D.R. Doelling, G.L. Smith, D.F. Keyes, S. Kato,
#  N. Manalo-Smith, and T. Wong, 2009: Toward Optimal Closure of the Earth's 
#  Top-of-Atmosphere Radiation Budget. J. Climate, 22, 748-766.
#
#   Acknowledgment:
#
#  "These data were obtained from the NASA Langley Research Center EOSDIS
#   Distributed Active Archive Center."
#
#  Acknowledgment from:
#  http://eosweb.larc.nasa.gov/GUIDE/dataset_documents/cer_ebaf.html#acknowledge
#
#  "These data were obtained from the NASA Langley Research Center
#   Atmospheric Science Data Center."
#
#  Datasets:
#    CERES_EBAF_dir/{clim_lwcre,clim_netcre,clim_net,clim_lwup,clim_swinc,clim_swup,clim_swcre}.CERES_EBAF_TOA_Terra_Edition1A_200003-200510.nc
#    where CERES_EBAF_dir = /net/cjs/data/ceres/CERES_EBAF_TOA_Terra_Edition1A/climatology
#
#  have been consolidated into a compressed tar data file which is used as
#  a data source for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/CERES_EBAF/data.tar.gz
#
#=======================================================================
#
# CERES EBAF Edition2.6 obs data source:
#
#  CERES Product Information:
#  http://ceres.larc.nasa.gov/products.php?product=EBAF : "Browse & Subset", to:
#
#  CERES_EBAF-TOA-Terra_Ed2.6 Subsetting:
#  http://ceres-tool.larc.nasa.gov/ord-tool/jsp/EBAFSelection.jsp
#
#  NASA CERES EBAF Terra (CERES-FM1 or CERES-FM2) Edition2.6
#  Energy Balanced and Filled 1 Degree Monthly (3/00 - 12/10) and
#  10-year Climatology
#
#  Note, the following "Product Attribution" section was copied from the bottom of page 3 of
#  /net/cjs/data/ceres/CERES_EBAF-TOA_Terra_Ed2.6/monthly/CERES_EBAF-TOA_Terra_Ed2.6_DataProductCatalog.pdf
#  into /net/cjs/data/ceres/CERES_EBAF-TOA_Terra_Ed2.6/monthly/Product_Attribution,
#  edited there and is copied from that file here; CERES_EBAF-TOA_Terra_Ed2.6_DataProductCatalog.pdf
#  was downloaded as part of the download procedure to obtain the monthly time series dataset.
#
#  Product Attribution:
#
#  The CERES Team has gone to considerable trouble to remove major errors and to verify the quality
#  and accuracy of this data. Please specify the CERES product and version as "CERES EBAF Ed2.6"
#  and provide a reference to the following paper when you publish scientific results with the data:
#
#  Loeb, N.G., B.A. Wielicki, D.R. Doelling, G.L. Smith, D.F. Keyes, S. Kato, N. Manalo-Smith, and T.
#  Wong, 2008: Toward Optimal Closure of the Earth's Top-of-Atmosphere Radiation Budget, Journal of
#  Climate, Volume 22, Issue 3 (February 2009) pp. 748-766. doi: 10.1175/2008JCLI2637.1
#
#  Datasets:
#    CERES_EBAF_dir/monthly/CERES_EBAF-TOA_Terra_Ed2.6_Subset_200003-201012.nc
#    CERES_EBAF_dir/climate/CERES_EBAF-TOA_Terra_Ed2.6_Subset_CLIM01-CLIM12.nc
#    where CERES_EBAF_dir = /net/cjs/data/ceres/CERES_EBAF-TOA_Terra_Ed2.6
#
#  have been consolidated into a compressed tar data file which is used as
#  a data source for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/CERES_EBAF_Ed2.6/data.tar.gz
#
#=======================================================================
#
# CERES EBAF Edition2.7 obs data sources:
#
#- - - - - - - - - - - - - - - - - TOA - - - - - - - - - - - - - - - - -
#
#  NASA CERES EBAF TOA Edition2.7
#  Energy Balanced and Filled 1 Degree Monthly (3/2000 - 4/2013) and
#  13-year Climatology
#
#  CERES Data Products:
#  http://ceres.larc.nasa.gov/order_data.php : "EBAF-TOA", to:
#
#  CERES EBAF-TOA Product Information:
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-TOA : "Browse & Order", to:
#
#  CERES_EBAF-TOA_Ed2.7 Subsetting and Browsing:
#  http://ceres-tool.larc.nasa.gov/ord-tool/jsp/EBAFSelection.jsp
#
#  the following "Product Statement" was copied from the bottom of
#  http://ceres-tool.larc.nasa.gov/ord-tool/srbavg
#  during the "Get Data" part of the data order process:
#
#                               Product Statement
#                            - CERES_EBAF-TOA_Ed2.7 -
#
#  Product Description:
#
#  The CERES_EBAF-TOA_Ed2.7 provides monthly and climatological averages of
#  clear-sky fluxes, all-sky fluxes, and cloud radiative effect (CRE) fluxes at
#  TOA, that are energy balanced to the ocean heat storage term and clear-sky
#  spatially filled. More information can be obtained here: CERES-EBAF-TOA
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-TOA.
#
#  Product Data Quality Summary:
#
#  The EBAF-TOA data quality summary
#  http://ceres.larc.nasa.gov/documents/DQ_summaries/CERES_EBAF_Ed2.7_DQS.pdf
#  provides more information of the content.
#
#  Product Attribution:
#
#  The CERES Team has made considerable efforts to remove major errors and to
#  verify the quality and accuracy of this data. Please specify the CERES product
#  and version as "CERES EBAF-TOA Ed2.7" and provide a reference to the following
#  paper when you publish scientific results with the data:
#
#    Loeb, N.G., B.A. Wielicki, D.R. Doelling, G.L. Smith, D.F. Keyes, S. Kato,
#    N. Manalo-Smith, and T. Wong, 2009: Toward Optimal Closure of the Earth's
#    Top-of-Atmosphere Radiation Budget. Journal of Climate, Volume 22, Issue 3
#    (February 2009) pp. 748-766. doi: 10.1175/2008JCLI2637.1
#
#- - - - - - - - - - - - - - - - - SFC - - - - - - - - - - - - - - - - -
#
#  NASA CERES EBAF Surface Edition2.7
#  Energy Balanced and Filled 1 Degree Monthly (3/2000 - 9/2012) and
#  12-year Climatology
#
#  CERES Data Products:
#  http://ceres.larc.nasa.gov/order_data.php : "EBAF-Surface", to:
#
#  CERES EBAF-Surface Product Information:
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-Surface: "Browse & Order", to:
#
#  CERES_EBAF-Surface_Ed2.7 Subsetting and Browsing:
#  http://ceres-tool.larc.nasa.gov/ord-tool/jsp/EBAFSFCSelection.jsp
#
#  the following "Product Statement" was copied from the bottom of
#  http://ceres-tool.larc.nasa.gov/ord-tool/srbavg
#  during the "Get Data" part of the data order process:
#
#                               Product Statement
#                         - CERES_EBAF-Surface_Ed2.7 -
#
#  Product Description:
#
#  The CERES_EBAF-Surface_Ed2.7 product provides monthly and climatological
#  averages of computed clear-sky fluxes, all-sky fluxes, and cloud radiative
#  effect (CRE) fluxes at surface, consistent with the CERES EBAF-TOA fluxes. More
#  information can be obtained here: CERES-EBAF-Surface
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-Surface.
#
#  Product Data Quality Summary:
#
#  The EBAF-Surface data quality summary
#  http://ceres.larc.nasa.gov/documents/DQ_summaries/CERES_EBAF-Surface_Ed2.7_DQS.pdf
#  provides more information of the content.
#
#  Product Attribution:
#
#  The CERES Team has made considerable efforts to remove major errors and to
#  verify the quality and accuracy of this data. Please specify the CERES product
#  and version as "CERES EBAF-Surface Ed2.7" and provide a reference to the
#  following paper when you publish scientific results with the data:
#
#    Kato, S., N. G. Loeb, F. G. Rose, D. R. Doelling, D. A. Rutan, T. E.
#    Caldwell, L. Yu, and R. A. Weller, 2013: Surface irradiances consistent with
#    CERES-derived top-of-atmosphere shortwave and longwave irradiances. Journal
#    of Climate, Volume 26, 2719-2740. doi: 10.1175/JCLI-D-12-00436.1
#
#  Datasets:
#    CERES_dir/CERES_EBAF-Surface_Ed2.7/monthly/CERES_EBAF-Surface_Ed2.7_Subset_200003-201209.nc
#    CERES_dir/CERES_EBAF-Surface_Ed2.7/climate/CERES_EBAF-Surface_Ed2.7_Subset_CLIM01-CLIM12.nc
#    CERES_dir/CERES_EBAF-TOA_Ed2.7/monthly/CERES_EBAF-TOA_Ed2.7_Subset_200003-201304.nc
#    CERES_dir/CERES_EBAF-TOA_Ed2.7/climate/CERES_EBAF-TOA_Ed2.7_Subset_CLIM01-CLIM12.nc
#    where CERES_dir = /net2/cjs/data/ceres
#
#  have been consolidated into a compressed tar data file which is used as
#  a data source for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/CERES_EBAF_Ed2.7/data.tar.gz
#
#=======================================================================
#
# CERES EBAF Edition2.8 v1 obs data sources:
#
#- - - - - - - - - - - - - - - - - TOA - - - - - - - - - - - - - - - - -
#
#  NASA CERES EBAF TOA Edition2.8
#  Energy Balanced and Filled 1 Degree Monthly (3/2000 - 3/2015) and
#  15-year Climatology
#
#  CERES Data Products:
#  http://ceres.larc.nasa.gov/order_data.php : "EBAF-TOA", to:
#
#  CERES EBAF-TOA Product Information:
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-TOA : "Browse & Order", to:
#
#  CERES_EBAF-TOA_Ed2.8 Subsetting and Browsing:
#  http://ceres-tool.larc.nasa.gov/ord-tool/jsp/EBAFSelection.jsp
#
#  the following "Product Statement" is an edited version of a copy
#  taken from the bottom of http://ceres-tool.larc.nasa.gov/ord-tool/srbavg
#  during the "Get Data" part of the data order process:
#
#                               Product Statement
#                            - CERES_EBAF-TOA_Ed2.8 -
#
#  Product Description:
#
#  The CERES_EBAF-TOA_Ed2.8 provides monthly and climatological averages of
#  clear-sky fluxes, all-sky fluxes, and cloud radiative effect (CRE) fluxes at
#  TOA, that are energy balanced to the ocean heat storage term and clear-sky
#  spatially filled. More information can be obtained here: CERES-EBAF-TOA
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-TOA .
#
#  Product Data Quality Summary:
#
#  The EBAF-TOA data quality summary
#  http://ceres.larc.nasa.gov/documents/DQ_summaries/CERES_EBAF_Ed2.8_DQS.pdf
#  provides more information of the content.
#
#  Product Attribution:
#
#  The CERES Team has made considerable efforts to remove major errors and to
#  verify the quality and accuracy of this data. Please specify the CERES product
#  and version as "CERES EBAF-TOA Ed2.8" and provide a reference to the following
#  paper when you publish scientific results with the data:
#
#    Loeb, N.G., B.A. Wielicki, D.R. Doelling, G.L. Smith, D.F. Keyes, S. Kato,
#    N. Manalo-Smith, and T. Wong, 2009: Toward Optimal Closure of the Earth's
#    Top-of-Atmosphere Radiation Budget. Journal of Climate, Volume 22, Issue 3
#    (February 2009) pp. 748-766. doi: 10.1175/2008JCLI2637.1
#
#- - - - - - - - - - - - - - - - - SFC - - - - - - - - - - - - - - - - -
#
#  NASA CERES EBAF Surface Edition2.8
#  Energy Balanced and Filled 1 Degree Monthly (3/2000 - 2/2015) and
#  15-year Climatology
#
#  CERES Data Products:
#  http://ceres.larc.nasa.gov/order_data.php : "EBAF-Surface", to:
#
#  CERES EBAF-Surface Product Information:
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-Surface: "Browse & Order", to:
#
#  CERES_EBAF-Surface_Ed2.8 Subsetting and Browsing:
#  http://ceres-tool.larc.nasa.gov/ord-tool/jsp/EBAFSFCSelection.jsp
#
#  the following "Product Statement" is an edited version of a copy
#  taken from the bottom of http://ceres-tool.larc.nasa.gov/ord-tool/srbavg
#  during the "Get Data" part of the data order process:
#
#                               Product Statement
#                         - CERES_EBAF-Surface_Ed2.8 -
#
#  Product Description:
#
#  The CERES_EBAF-Surface_Ed2.8 product provides monthly and climatological
#  averages of computed clear-sky fluxes, all-sky fluxes, and cloud radiative
#  effect (CRE) fluxes at surface, consistent with the CERES EBAF-TOA fluxes. More
#  information can be obtained here: CERES-EBAF-Surface
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-Surface .
#
#  Product Data Quality Summary:
#
#  The EBAF-Surface data quality summary
#  http://ceres.larc.nasa.gov/documents/DQ_summaries/CERES_EBAF-Surface_Ed2.8_DQS.pdf
#  provides more information of the content.
#
#  Product Attribution:
#
#  The CERES Team has made considerable efforts to remove major errors and to
#  verify the quality and accuracy of this data. Please specify the CERES product
#  and version as "CERES EBAF-Surface Ed2.8" and provide a reference to the
#  following paper when you publish scientific results with the data:
#
#    Kato, S., N. G. Loeb, F. G. Rose, D. R. Doelling, D. A. Rutan, T. E.
#    Caldwell, L. Yu, and R. A. Weller, 2013: Surface irradiances consistent with
#    CERES-derived top-of-atmosphere shortwave and longwave irradiances. Journal
#    of Climate, Volume 26, 2719-2740. doi: 10.1175/JCLI-D-12-00436.1
#
#  Datasets:
#    CERES_dir/CERES_EBAF-Surface_Ed2.8/v1/monthly/CERES_EBAF-Surface_Ed2.8_Subset_200003-201502.nc
#    CERES_dir/CERES_EBAF-Surface_Ed2.8/v1/climate/CERES_EBAF-Surface_Ed2.8_Subset_CLIM01-CLIM12.nc
#    CERES_dir/CERES_EBAF-TOA_Ed2.8/v1/monthly/CERES_EBAF-TOA_Ed2.8_Subset_200003-201503.nc
#    CERES_dir/CERES_EBAF-TOA_Ed2.8/v1/climate/CERES_EBAF-TOA_Ed2.8_Subset_CLIM01-CLIM12.nc
#    where CERES_dir = /net2/cjs/data/ceres
#
#  have been consolidated into a compressed tar data file for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/CERES_EBAF_Ed2.8/v1/data.tar.gz
#
#=======================================================================
#
# CERES EBAF Edition2.8 v2 obs data sources:
#
#- - - - - - - - - - - - - - - - - TOA - - - - - - - - - - - - - - - - -
#
#  NASA CERES EBAF TOA Edition2.8
#  Energy Balanced and Filled 1 Degree Monthly (3/2000 - 7/2016) and
#  16-year Climatology
#
#  CERES Data Products:
#  http://ceres.larc.nasa.gov/order_data.php : "EBAF-TOA", to:
#
#  CERES EBAF-TOA Product Information:
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-TOA : "Browse & Subset", to:
#
#  CERES_EBAF-TOA_Ed2.8 Subsetting and Browsing:
#  http://ceres-tool.larc.nasa.gov/ord-tool/jsp/EBAFSelection.jsp
#
#  the following "Product Statement" is an edited version of a copy
#  taken from the bottom of https://ceres-tool.larc.nasa.gov/ord-tool/srbavg
#  during the "Get Data" part of the data order process:
#
#                                 Product Statement
#                              - CERES_EBAF-TOA_Ed2.8 -
#
#  Product Description:
#
#  The CERES_EBAF-TOA_Ed2.8 provides monthly and climatological averages of
#  clear-sky fluxes, all-sky fluxes, and cloud radiative effect (CRE) fluxes at
#  TOA, that are energy balanced to the ocean heat storage term and clear-sky
#  spatially filled. More information can be obtained here: CERES-EBAF-TOA
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-TOA .
#
#  Product Data Quality Summary:
#
#  The EBAF-TOA data quality summary
#  http://ceres.larc.nasa.gov/documents/DQ_summaries/CERES_EBAF_Ed2.8_DQS.pdf
#  provides more information of the content.
#
#  Product Attribution:
#
#  The CERES Team has made considerable efforts to remove major errors and to
#  verify the quality and accuracy of this data. Please specify the CERES product
#  and version as "CERES EBAF-TOA Ed2.8" and provide a reference to the following
#  paper when you publish scientific results with the data:
#
#      Loeb, N.G., B.A. Wielicki, D.R. Doelling, G.L. Smith, D.F. Keyes, S. Kato,
#      N. Manalo-Smith, and T. Wong, 2009: Toward Optimal Closure of the Earth's
#      Top-of-Atmosphere Radiation Budget. Journal of Climate, Volume 22, Issue 3
#      (February 2009) pp. 748-766. doi: 10.1175/2008JCLI2637.1
#
#- - - - - - - - - - - - - - - - - SFC - - - - - - - - - - - - - - - - -
#
#  NASA CERES EBAF Surface Edition2.8
#  Energy Balanced and Filled 1 Degree Monthly (3/2000 - 2/2016) and
#  16-year Climatology
#
#  CERES Data Products:
#  http://ceres.larc.nasa.gov/order_data.php : "EBAF-Surface", to:
#
#  CERES EBAF-Surface Product Information:
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-Surface: "Browse & Subset", to:
#
#  CERES_EBAF-Surface_Ed2.8 Subsetting and Browsing:
#  http://ceres-tool.larc.nasa.gov/ord-tool/jsp/EBAFSFCSelection.jsp
#
#  the following "Product Statement" is an edited version of a copy
#  taken from the bottom of https://ceres-tool.larc.nasa.gov/ord-tool/srbavg
#  during the "Get Data" part of the data order process:
#
#                                 Product Statement
#                           - CERES_EBAF-Surface_Ed2.8 -
#
#  Product Description:
#
#  The CERES_EBAF-Surface_Ed2.8 product provides monthly and climatological
#  averages of computed clear-sky fluxes, all-sky fluxes, and cloud radiative
#  effect (CRE) fluxes at surface, consistent with the CERES EBAF-TOA fluxes. More
#  information can be obtained here: CERES-EBAF-Surface
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-Surface .
#
#  Product Data Quality Summary:
#
#  The EBAF-Surface data quality summary
#  http://ceres.larc.nasa.gov/documents/DQ_summaries/CERES_EBAF-Surface_Ed2.8_DQS.pdf
#  provides more information of the content.
#
#  Product Attribution:
#
#  The CERES Team has made considerable efforts to remove major errors and to
#  verify the quality and accuracy of this data. Please specify the CERES product
#  and version as "CERES EBAF-Surface Ed2.8" and provide a reference to the
#  following paper when you publish scientific results with the data:
#
#      Kato, S., N. G. Loeb, F. G. Rose, D. R. Doelling, D. A. Rutan, T. E.
#      Caldwell, L. Yu, and R. A. Weller, 2013: Surface irradiances consistent with
#      CERES-derived top-of-atmosphere shortwave and longwave irradiances. Journal
#      of Climate, Volume 26, 2719-2740. doi: 10.1175/JCLI-D-12-00436.1
#
#  Datasets:
#    CERES_dir/CERES_EBAF-Surface_Ed2.8/v2/monthly/CERES_EBAF-Surface_Ed2.8_Subset_200003-201602.nc
#    CERES_dir/CERES_EBAF-Surface_Ed2.8/v2/climate/CERES_EBAF-Surface_Ed2.8_Subset_CLIM01-CLIM12.nc
#    CERES_dir/CERES_EBAF-TOA_Ed2.8/v2/monthly/CERES_EBAF-TOA_Ed2.8_Subset_200003-201607.nc
#    CERES_dir/CERES_EBAF-TOA_Ed2.8/v2/climate/CERES_EBAF-TOA_Ed2.8_Subset_CLIM01-CLIM12.nc
#    where CERES_dir = /net2/cjs/data/ceres
#
#  have been consolidated into a compressed tar data file for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/CERES_EBAF_Ed2.8/v2/data.tar.gz
#
#=======================================================================
#
# CERES EBAF Edition4.0 v1 obs data sources:
#
#- - - - - - - - - - - - - - - - - TOA - - - - - - - - - - - - - - - - -
#
#  NASA CERES EBAF TOA Edition4.0
#  Energy Balanced and Filled 1 Degree Monthly (3/2000 - 1/2017) and
#  7/2005 to 6/2015 Climatology
#
#  CERES Data Products:
#  https://ceres.larc.nasa.gov/order_data.php : "EBAF-TOA", to:
#
#  CERES EBAF-TOA Product Information:
#  https://ceres.larc.nasa.gov/products.php?product=EBAF-TOA : "Browse & Subset", to:
#
#  CERES EBAF-TOA Ordering Page:
#  https://ceres.larc.nasa.gov/products-info.php?product=EBAF-TOA : "Browse & Subset", to:
#
#  CERES Subsetting and Browsing (CERES_EBAF-TOA_Ed4.0 Subsetting and Browsing):
#  https://ceres-tool.larc.nasa.gov/ord-tool/jsp/EBAF4Selection.jsp
#
#  the following "Product Statement" is an edited version of a copy
#  taken from the bottom of https://ceres-tool.larc.nasa.gov/ord-tool/srbavg
#  during the "Get Data" part of the data order process:
#
#                                 Product Statement
#                              - CERES_EBAF-TOA_Ed4.0 -
#
#  Product Description:
#
#  The CERES_EBAF-TOA_Ed4.0 provides monthly and climatological averages of
#  clear-sky fluxes, all-sky fluxes and clouds, and cloud radiative effect (CRE)
#  fluxes at TOA, that are energy balanced to the ocean heat storage term and
#  clear-sky spatially filled. More information can be obtained here: CERES-EBAF-TOA
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-TOA .
#
#  Product Data Quality Summary:
#
#  The EBAF-TOA data quality summary
#  http://ceres.larc.nasa.gov/documents/DQ_summaries/CERES_EBAF_Ed4.0_DQS.pdf
#  provides more information on the content.
#
#  Product Attribution:
#
#  The CERES Team has made considerable efforts to remove major errors and to
#  verify the quality and accuracy of this data. Please specify the CERES product
#  and version as "CERES EBAF-TOA Ed4.0" and provide a reference to the following
#  paper when you publish scientific results with the data:
#
#      Loeb, N.G., B.A. Wielicki, D.R. Doelling, G.L. Smith, D.F. Keyes, S. Kato,
#      N. Manalo-Smith, and T. Wong, 2009: Toward Optimal Closure of the Earth's
#      Top-of-Atmosphere Radiation Budget. Journal of Climate, Volume 22, Issue 3
#      (February 2009) pp. 748-766. doi: 10.1175/2008JCLI2637.1
#
#- - - - - - - - - - - - - - - - - SFC - - - - - - - - - - - - - - - - -
#
#  NASA CERES EBAF Surface Edition4.0
#  Energy Balanced and Filled 1 Degree Monthly (3/2000 - 2/2016) and
#  7/2005 to 6/2015 Climatology
#
#  CERES Data Products:
#  https://ceres.larc.nasa.gov/order_data.php : "EBAF-Surface", to:
#
#  CERES EBAF-Surface Product Information:
#  https://ceres.larc.nasa.gov/products.php?product=EBAF-Surface : "Browse & Subset", to:
#
#  CERES EBAF-Surface Ordering Page:
#  https://ceres.larc.nasa.gov/products-info.php?product=EBAF-Surface : "Browse & Subset", to:
#
#  CERES_EBAF-Surface_Ed4.0 Subsetting and Browsing:
#  https://ceres-tool.larc.nasa.gov/ord-tool/jsp/EBAFSFC4Selection.jsp
#
#  the following "Product Statement" is an edited version of a copy
#  taken from the bottom of https://ceres-tool.larc.nasa.gov/ord-tool/srbavg
#  during the "Get Data" part of the data order process:
#
#                                 Product Statement
#                           - CERES_EBAF-Surface_Ed4.0 -
#
#  Product Description:
#
#  The CERES_EBAF-Surface_Ed4.0 product provides monthly and climatological
#  averages of computed clear-sky fluxes, all-sky fluxes, and cloud radiative
#  effect (CRE) fluxes at surface, consistent with the CERES EBAF-TOA fluxes. More
#  information can be obtained here: CERES-EBAF-Surface
#  http://ceres.larc.nasa.gov/products.php?product=EBAF-Surface .
#
#  Product Data Quality Summary:
#
#  The EBAF-Surface data quality summary
#  http://ceres.larc.nasa.gov/documents/DQ_summaries/CERES_EBAF-Surface_Ed4.0_DQS.pdf
#  provides more information of the content.
#
#  Product Attribution:
#
#  The CERES Team has made considerable efforts to remove major errors and to
#  verify the quality and accuracy of this data. Please specify the CERES product
#  and version as "CERES EBAF-Surface Ed4.0" and provide a reference to the
#  following paper when you publish scientific results with the data:
#
#      Kato, S., N. G. Loeb, F. G. Rose, D. R. Doelling, D. A. Rutan, T. E.
#      Caldwell, L. Yu, and R. A. Weller, 2013: Surface irradiances consistent with
#      CERES-derived top-of-atmosphere shortwave and longwave irradiances. Journal
#      of Climate, Volume 26, 2719-2740. doi: 10.1175/JCLI-D-12-00436.1
#
#  Datasets:
#    CERES_dir/CERES_EBAF-Surface_Ed4.0/v1/monthly/CERES_EBAF-Surface_Ed4.0_Subset_200003-201602.nc
#    CERES_dir/CERES_EBAF-Surface_Ed4.0/v1/climate/CERES_EBAF-Surface_Ed4.0_Subset_CLIM01-CLIM12.nc
#    CERES_dir/CERES_EBAF-TOA_Ed4.0/v1/monthly/CERES_EBAF-TOA_Ed4.0_Subset_200003-201701.nc
#    CERES_dir/CERES_EBAF-TOA_Ed4.0/v1/climate/CERES_EBAF-TOA_Ed4.0_Subset_CLIM01-CLIM12.nc
#    where CERES_dir = /net2/cjs/data/ceres
#
#  have been consolidated into a compressed tar data file for this processor:
#
#  $FRE_ANALYSIS_ARCHIVE/cjs/radiation_atmos_av_mon/CERES_EBAF_Ed4.0/v1/data.tar.gz
#
#=======================================================================

source $plot_file_project

if ( -e $plot_file ) rm -f $plot_file || exit 1

switch ( $obs_source )

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case ERBE:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'lon=0,lon=360,lat=-60,lat=60'
set stats_region = '0. 357.5 -60. 60.'

# model variable

set mod_var = 'swup_toa_clr-swup_toa'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$ERBE_swcldfrc_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_ES4:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable

set obs_var = 'swcf'

# model variable

set mod_var = 'swup_toa_clr-swup_toa'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$CERES_ES4_swcf_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_SRBAVG_nonGEO:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable

set obs_var = 'swcf'

# model variable

set mod_var = 'swup_toa_clr-swup_toa'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
open $obs_in_data_dir/$CERES_SRBAVG_nonGEO_ctl
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_SRBAVG_GEO:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable

set obs_var = 'swcf'

# model variable

set mod_var = 'swup_toa_clr-swup_toa'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
open $obs_in_data_dir/$CERES_SRBAVG_GEO_XTRK_ctl
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable

set obs_var = 'clim_swcre'

# model variable

set mod_var = 'swup_toa_clr-swup_toa'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$CERES_EBAF_swcre_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_Ed2.6:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable

set obs_var = 'cre_sw_mon'

# model variable

set mod_var = 'swup_toa_clr-swup_toa'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$CERES_EBAF_Ed2p6_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_TOA_Ed2.7:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable

set obs_var = 'toa_cre_sw_mon'

# model variable

set mod_var = 'swup_toa_clr-swup_toa'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$CERES_EBAF_TOA_Ed2p7_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_SFC_Ed2.7:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable; name is truncated to first 15 characters for GrADS

set obs_var = 'sfc_cre_net_sw_'

# model variable

#  from /net/cjs/data/ceres/CERES_EBAF-Surface_Ed2.7/CERES_EBAF-Surface_Ed2.7_DQS.pdf
#
#  "3.0 Cautions and Helpful Hints" on page 4:
#
#  "Clear-sky surface fluxes are consistent with clear-sky TOA fluxes
#  included in CERES-EBAF-TOA_Ed2.7. Therefore, the monthly 1??1? gridded clear-sky
#  fluxes are clear-sky fraction-weighted fluxes instead of fluxes computed by
#  removing clouds. Computed clear-sky fluxes are also constrained by the
#  CERES-derived clear-sky TOA fluxes that are included in CERES_EBAF-TOA_Ed2.7."
#
#  "Cloud radiative effects are computed as all-sky flux minus clear-sky flux."
#
#  "The net flux is positive when the energy is deposited to the surface, i.e. the
#  net is defined as downward minus upward flux."

set mod_var = '(swdn_sfc-swup_sfc) - (swdn_sfc_clr-swup_sfc_clr)'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$CERES_EBAF_SFC_Ed2p7_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_ATM_Ed2.7:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs and model variables

#  obs variable names are truncated to first 15 characters for GrADS

#  Defined as SWCF at SFC divided by SWCF at TOA
#
#   following Kiehl, et al (1995), Equation (1) in
#   http://journals.ametsoc.org/doi/pdf/10.1175/1520-0442%281995%29008%3C2200%3ASOAGCT%3E2.0.CO%3B2
#   on page 2201:
#
#  "As noted by Cess et al, another measure of enhanced shortwave cloud absorption
#  is the ratio of the shortwave cloud forcing at the surface to that at the top of
#  the atmosphere.  Shortwave cloud forcing (SWCF) is defined as the difference
#  between the clear and total absorbed shortwave flux Sabs. Thus the ratio is
#  
#        Sabs(SRF) - Sabsclr(SRF)
#    R = ------------------------
#        Sabs(TOA) - Sabsclr(TOA)
#  
#        SWCF(SRF)
#      = --------- .             (1)"
#        SWCF(TOA)

set obs_var = 'sfc_cre_net_sw_.1/toa_cre_sw_mon.2'

set mod_var = '((swdn_sfc-swup_sfc) - (swdn_sfc_clr-swup_sfc_clr))/(swup_toa_clr-swup_toa)'

set num_mod_file = 3

# start the plot file

cat << EOF > $plot_file
* open observation files
sdfopen $obs_in_data_dir/$CERES_EBAF_SFC_Ed2p7_nc
sdfopen $obs_in_data_dir/$CERES_EBAF_TOA_Ed2p7_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_TOA_Ed2.8:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable

set obs_var = 'toa_cre_sw_mon'

# model variable

set mod_var = 'swup_toa_clr-swup_toa'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$CERES_EBAF_TOA_Ed2p8_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_SFC_Ed2.8:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable; name is truncated to first 15 characters for GrADS

set obs_var = 'sfc_cre_net_sw_'

# model variable

#  from /net/cjs/data/ceres/CERES_EBAF-Surface_Ed2.8/v2/CERES_EBAF-Surface_Ed2.8_DQS.pdf
#
#  "3.0 Cautions and Helpful Hints" on page 4:
#
#  "Clear-sky surface fluxes are consistent with clear-sky TOA fluxes included in
#  CERES-EBAF-TOA_Ed2.8. Therefore, the monthly 1??1? gridded clear-sky fluxes are
#  clear-sky fraction-weighted fluxes instead of fluxes computed by removing
#  clouds. Computed clear-sky fluxes are also constrained by the CERES-derived
#  clear-sky TOA fluxes that are included in CERES_EBAF-TOA_Ed2.8."
#
#  "Cloud radiative effects are computed as all-sky flux minus clear-sky flux."
#
#  "The net flux is positive when the energy is deposited to the surface, i.e.
#  the net is defined as downward minus upward flux."

set mod_var = '(swdn_sfc-swup_sfc) - (swdn_sfc_clr-swup_sfc_clr)'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$CERES_EBAF_SFC_Ed2p8_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_ATM_Ed2.8:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs and model variables

#  obs variable names are truncated to first 15 characters for GrADS

#  Defined as SWCF at SFC divided by SWCF at TOA (see notes for CERES_EBAF_ATM_Ed2.7)

set obs_var = 'sfc_cre_net_sw_.1/toa_cre_sw_mon.2'

set mod_var = '((swdn_sfc-swup_sfc) - (swdn_sfc_clr-swup_sfc_clr))/(swup_toa_clr-swup_toa)'

set num_mod_file = 3

# start the plot file

cat << EOF > $plot_file
* open observation files
sdfopen $obs_in_data_dir/$CERES_EBAF_SFC_Ed2p8_nc
sdfopen $obs_in_data_dir/$CERES_EBAF_TOA_Ed2p8_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_TOA_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable

set obs_var = 'toa_cre_sw_mon'

# model variable

set mod_var = 'swup_toa_clr-swup_toa'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$CERES_EBAF_TOA_Ed4p0_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_SFC_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs variable; name is truncated to first 15 characters for GrADS

set obs_var = 'sfc_cre_net_sw_'

# model variable

#  from /net/cjs/data/ceres/CERES_EBAF-Surface_Ed4.0/v1/CERES_EBAF-Surface_Ed4.0_DQS.pdf
#
#  "3.0 Cautions and Helpful Hints" on page 11:
#
#  "Clear-sky surface fluxes are consistent with clear-sky TOA fluxes included in
#  CERES-EBAF-TOA_Ed4.0. Therefore, the monthly 1??1? gridded clear-sky fluxes are
#  clear-sky fraction-weighted fluxes instead of fluxes computed by removing
#  clouds. Computed clear-sky fluxes are also constrained by the CERES-derived
#  clear-sky TOA fluxes that are included in CERES_EBAF-TOA_Ed4.0."
#
#  "Cloud radiative effects are computed as all-sky flux minus clear-sky flux."
#
#  "The net flux is positive when the energy is deposited to the surface, i.e.
#  the net is defined as downward minus upward flux."

set mod_var = '(swdn_sfc-swup_sfc) - (swdn_sfc_clr-swup_sfc_clr)'

set num_mod_file = 2

# start the plot file

cat << EOF > $plot_file
* open observation file
sdfopen $obs_in_data_dir/$CERES_EBAF_SFC_Ed4p0_nc
EOF

    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_ATM_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# area average and statistics regions

set aave_region = 'g'
set stats_region = '0. 360. -90. 90.'

# obs and model variables

#  obs variable names are truncated to first 15 characters for GrADS

#  Defined as SWCF at SFC divided by SWCF at TOA (see notes for CERES_EBAF_ATM_Ed2.7)

set obs_var = 'sfc_cre_net_sw_.1/toa_cre_sw_mon.2'

set mod_var = '((swdn_sfc-swup_sfc) - (swdn_sfc_clr-swup_sfc_clr))/(swup_toa_clr-swup_toa)'

set num_mod_file = 3

# start the plot file

cat << EOF > $plot_file
* open observation files
sdfopen $obs_in_data_dir/$CERES_EBAF_SFC_Ed4p0_nc
sdfopen $obs_in_data_dir/$CERES_EBAF_TOA_Ed4p0_nc
EOF

    breaksw

endsw

switch ( $GrADS_version )

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case GrADS_v1.9b4:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# use "sdfopen"

cat << EOF >> $plot_file

* open model file
sdfopen $mod_file

EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case GrADS_v2:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# use "xdfopen"

cat << EOF >> $plot_file

* open model file
xdfopen $mod_xdf_file

EOF
    breaksw

endsw

# add model and obs code; categorize using "mod_grid_type" and "obs_grid_type"

########################################################################
if ( $mod_grid_type == regrid_to_obs && $obs_grid_type == obs ) then
########################################################################

#----------------------------- model code ------------------------------

cat << EOF >> $plot_file
set dfile $num_mod_file
set x 1 $mod_nlon
set y 1 $mod_nlat
set z 1
set t 1 12
define mswcf = $mod_var
set t 1

define fieldtemp = ave(mswcf,t=1,t=12)
define mswcfann = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemodann = aave(mswcfann,$aave_region)
undefine fieldtemp

define fieldtemp = (2.0*ave(mswcf,t=1,t=2)+mswcf(t=12))/3.
define mswcfdjf = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemoddjf = aave(mswcfdjf,$aave_region)
undefine fieldtemp

define fieldtemp = ave(mswcf,t=3,t=5)
define mswcfmam = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemodmam = aave(mswcfmam,$aave_region)
undefine fieldtemp

define fieldtemp = ave(mswcf,t=6,t=8)
define mswcfjja = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemodjja = aave(mswcfjja,$aave_region)
undefine fieldtemp

define fieldtemp = ave(mswcf,t=9,t=11)
define mswcfson = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemodson = aave(mswcfson,$aave_region)
undefine fieldtemp

EOF

#------------------------------ obs code -------------------------------

switch ( $obs_source )

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case ERBE:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
set dfile 1
set x 1 144
set y 1 73
set z 1
* set missing values to zero
set t 1 12
define newcldfrc = const(nswcft,0.,-u)
set t 1

define obsswcfann = ave(newcldfrc,t=1,t=12)
define aveobsann = aave(obsswcfann,$aave_region)

define obsswcfdjf = (2.*ave(newcldfrc,t=1,t=2)+newcldfrc(t=12))/3.
define aveobsdjf = aave(obsswcfdjf,$aave_region)

define obsswcfmam = ave(newcldfrc,t=3,t=5)
define aveobsmam = aave(obsswcfmam,$aave_region)

define obsswcfjja = ave(newcldfrc,t=6,t=8)
define aveobsjja = aave(obsswcfjja,$aave_region)

define obsswcfson = ave(newcldfrc,t=9,t=11)
define aveobsson = aave(obsswcfson,$aave_region)

EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_ES4:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
set dfile 1
set x 1 144
set y 1 72
set z 1
set t 1

define obsswcfann = ave(swcf,t=1,t=12)
define aveobsann = aave(obsswcfann,$aave_region)

define obsswcfdjf = ave(swcf,t=10,t=12)
define aveobsdjf = aave(obsswcfdjf,$aave_region)

define obsswcfmam = ave(swcf,t=1,t=3)
define aveobsmam = aave(obsswcfmam,$aave_region)

define obsswcfjja = ave(swcf,t=4,t=6)
define aveobsjja = aave(obsswcfjja,$aave_region)

define obsswcfson = ave(swcf,t=7,t=9)
define aveobsson = aave(obsswcfson,$aave_region)

EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_SRBAVG_nonGEO:
  case CERES_SRBAVG_GEO:
  case CERES_EBAF:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# special case: obs dataset longitude range is (-179.5,179.5)

cat << EOF >> $plot_file
set dfile 1
set lon 0.5 359.5
set lat -89.5 89.5
set z 1
set t 1

define obsswcfann = ave($obs_var,t=1,t=12)
define aveobsann = aave(obsswcfann,$aave_region)

define obsswcfdjf = ave($obs_var,t=10,t=12)
define aveobsdjf = aave(obsswcfdjf,$aave_region)

define obsswcfmam = ave($obs_var,t=1,t=3)
define aveobsmam = aave(obsswcfmam,$aave_region)

define obsswcfjja = ave($obs_var,t=4,t=6)
define aveobsjja = aave(obsswcfjja,$aave_region)

define obsswcfson = ave($obs_var,t=7,t=9)
define aveobsson = aave(obsswcfson,$aave_region)

EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_Ed2.6:
  case CERES_EBAF_TOA_Ed2.7:
  case CERES_EBAF_SFC_Ed2.7:
  case CERES_EBAF_ATM_Ed2.7:
  case CERES_EBAF_TOA_Ed2.8:
  case CERES_EBAF_SFC_Ed2.8:
  case CERES_EBAF_ATM_Ed2.8:
  case CERES_EBAF_TOA_Ed4.0:
  case CERES_EBAF_SFC_Ed4.0:
  case CERES_EBAF_ATM_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# special case: define obs climatology

cat << EOF >> $plot_file
set dfile 1
set x 1 360
set y 1 180
set z 1
set t 1 12
define obsclim = ave($obs_var,t+$obs_dts,t=$obs_tf,12)
set t 1

define obsswcfann = ave(obsclim,t=1,t=12)
define aveobsann = aave(obsswcfann,$aave_region)

define obsswcfdjf = ave(obsclim,t=10,t=12)
define aveobsdjf = aave(obsswcfdjf,$aave_region)

define obsswcfmam = ave(obsclim,t=1,t=3)
define aveobsmam = aave(obsswcfmam,$aave_region)

define obsswcfjja = ave(obsclim,t=4,t=6)
define aveobsjja = aave(obsswcfjja,$aave_region)

define obsswcfson = ave(obsclim,t=7,t=9)
define aveobsson = aave(obsswcfson,$aave_region)

EOF
    breaksw

endsw

########################################################################
else if ( $mod_grid_type == mod && $obs_grid_type == regrid_to_mod ) then
########################################################################

#------------------------------ obs code -------------------------------

switch ( $obs_source )

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case ERBE:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
set dfile 1
set x 1 144
set y 1 73
set z 1
* set missing values to zero
set t 1 12
define newcldfrc = const(nswcft,0.,-u)
set t 1

define fieldtemp = ave(newcldfrc,t=1,t=12)
define obsswcfann = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsann = aave(obsswcfann,$aave_region)
undefine fieldtemp

define fieldtemp = (2.*ave(newcldfrc,t=1,t=2)+newcldfrc(t=12))/3.
define obsswcfdjf = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsdjf = aave(obsswcfdjf,$aave_region)
undefine fieldtemp

define fieldtemp = ave(newcldfrc,t=3,t=5)
define obsswcfmam = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsmam = aave(obsswcfmam,$aave_region)
undefine fieldtemp

define fieldtemp = ave(newcldfrc,t=6,t=8)
define obsswcfjja = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsjja = aave(obsswcfjja,$aave_region)

define fieldtemp = ave(newcldfrc,t=9,t=11)
define obsswcfson = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsson = aave(obsswcfson,$aave_region)
undefine fieldtemp
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_ES4:
  case CERES_SRBAVG_nonGEO:
  case CERES_SRBAVG_GEO:
  case CERES_EBAF:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
set dfile 1
set x 1 $obs_nlon
set y 1 $obs_nlat
set z 1
set t 1

define fieldtemp = ave($obs_var,t=1,t=12)
define obsswcfann = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsann = aave(obsswcfann,$aave_region)
undefine fieldtemp

define fieldtemp = ave($obs_var,t=10,t=12)
define obsswcfdjf = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsdjf = aave(obsswcfdjf,$aave_region)
undefine fieldtemp

define fieldtemp = ave($obs_var,t=1,t=3)
define obsswcfmam = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsmam = aave(obsswcfmam,$aave_region)
undefine fieldtemp

define fieldtemp = ave($obs_var,t=4,t=6)
define obsswcfjja = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsjja = aave(obsswcfjja,$aave_region)
undefine fieldtemp

define fieldtemp = ave($obs_var,t=7,t=9)
define obsswcfson = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsson = aave(obsswcfson,$aave_region)
undefine fieldtemp
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_Ed2.6:
  case CERES_EBAF_TOA_Ed2.7:
  case CERES_EBAF_SFC_Ed2.7:
  case CERES_EBAF_ATM_Ed2.7:
  case CERES_EBAF_TOA_Ed2.8:
  case CERES_EBAF_SFC_Ed2.8:
  case CERES_EBAF_ATM_Ed2.8:
  case CERES_EBAF_TOA_Ed4.0:
  case CERES_EBAF_SFC_Ed4.0:
  case CERES_EBAF_ATM_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# special case: define obs climatology

cat << EOF >> $plot_file
set dfile 1
set x 1 360
set y 1 180
set z 1
set t 1 12
define obsclim = ave($obs_var,t+$obs_dts,t=$obs_tf,12)
set t 1

define fieldtemp = ave(obsclim,t=1,t=12)
define obsswcfann = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsann = aave(obsswcfann,$aave_region)
undefine fieldtemp

define fieldtemp = ave(obsclim,t=10,t=12)
define obsswcfdjf = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsdjf = aave(obsswcfdjf,$aave_region)
undefine fieldtemp

define fieldtemp = ave(obsclim,t=1,t=3)
define obsswcfmam = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsmam = aave(obsswcfmam,$aave_region)
undefine fieldtemp

define fieldtemp = ave(obsclim,t=4,t=6)
define obsswcfjja = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsjja = aave(obsswcfjja,$aave_region)
undefine fieldtemp

define fieldtemp = ave(obsclim,t=7,t=9)
define obsswcfson = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsson = aave(obsswcfson,$aave_region)
undefine fieldtemp
EOF
    breaksw

endsw

#----------------------------- model code ------------------------------

cat << EOF >> $plot_file

set dfile $num_mod_file
set x 1 $mod_nlon
set y 1 $mod_nlat
set z 1
set t 1 12
define mswcf = $mod_var
set t 1

define mswcfann = ave(mswcf,t=1,t=12)
define avemodann = aave(mswcfann,$aave_region)

define mswcfdjf = (2.0*ave(mswcf,t=1,t=2)+mswcf(t=12))/3.
define avemoddjf = aave(mswcfdjf,$aave_region)

define mswcfmam = ave(mswcf,t=3,t=5)
define avemodmam = aave(mswcfmam,$aave_region)

define mswcfjja = ave(mswcf,t=6,t=8)
define avemodjja = aave(mswcfjja,$aave_region)

define mswcfson = ave(mswcf,t=9,t=11)
define avemodson = aave(mswcfson,$aave_region)

EOF

########################################################################
else if ( $mod_grid_type == regrid_to_nominal_mod && $obs_grid_type == regrid_to_nominal_mod ) then
########################################################################

#------------------------------ obs code -------------------------------

switch ( $obs_source )

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case ERBE:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
set dfile 1
set x 1 144
set y 1 73
set z 1
* set missing values to zero
set t 1 12
define newcldfrc = const(nswcft,0.,-u)
set t 1

define fieldtemp = ave(newcldfrc,t=1,t=12)
define obsswcfann = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsann = aave(obsswcfann,$aave_region)
undefine fieldtemp

define fieldtemp = (2.*ave(newcldfrc,t=1,t=2)+newcldfrc(t=12))/3.
define obsswcfdjf = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsdjf = aave(obsswcfdjf,$aave_region)
undefine fieldtemp

define fieldtemp = ave(newcldfrc,t=3,t=5)
define obsswcfmam = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsmam = aave(obsswcfmam,$aave_region)
undefine fieldtemp

define fieldtemp = ave(newcldfrc,t=6,t=8)
define obsswcfjja = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsjja = aave(obsswcfjja,$aave_region)

define fieldtemp = ave(newcldfrc,t=9,t=11)
define obsswcfson = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsson = aave(obsswcfson,$aave_region)
undefine fieldtemp
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_ES4:
  case CERES_SRBAVG_nonGEO:
  case CERES_SRBAVG_GEO:
  case CERES_EBAF:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
set dfile 1
set x 1 $obs_nlon
set y 1 $obs_nlat
set z 1
set t 1

define fieldtemp = ave($obs_var,t=1,t=12)
define obsswcfann = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsann = aave(obsswcfann,$aave_region)
undefine fieldtemp

define fieldtemp = ave($obs_var,t=10,t=12)
define obsswcfdjf = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsdjf = aave(obsswcfdjf,$aave_region)
undefine fieldtemp

define fieldtemp = ave($obs_var,t=1,t=3)
define obsswcfmam = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsmam = aave(obsswcfmam,$aave_region)
undefine fieldtemp

define fieldtemp = ave($obs_var,t=4,t=6)
define obsswcfjja = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsjja = aave(obsswcfjja,$aave_region)
undefine fieldtemp

define fieldtemp = ave($obs_var,t=7,t=9)
define obsswcfson = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsson = aave(obsswcfson,$aave_region)
undefine fieldtemp
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_Ed2.6:
  case CERES_EBAF_TOA_Ed2.7:
  case CERES_EBAF_SFC_Ed2.7:
  case CERES_EBAF_ATM_Ed2.7:
  case CERES_EBAF_TOA_Ed2.8:
  case CERES_EBAF_SFC_Ed2.8:
  case CERES_EBAF_ATM_Ed2.8:
  case CERES_EBAF_TOA_Ed4.0:
  case CERES_EBAF_SFC_Ed4.0:
  case CERES_EBAF_ATM_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# special case: define obs climatology

cat << EOF >> $plot_file
set dfile 1
set x 1 360
set y 1 180
set z 1
set t 1 12
define obsclim = ave($obs_var,t+$obs_dts,t=$obs_tf,12)
set t 1

define fieldtemp = ave(obsclim,t=1,t=12)
define obsswcfann = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsann = aave(obsswcfann,$aave_region)
undefine fieldtemp

define fieldtemp = ave(obsclim,t=10,t=12)
define obsswcfdjf = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsdjf = aave(obsswcfdjf,$aave_region)
undefine fieldtemp

define fieldtemp = ave(obsclim,t=1,t=3)
define obsswcfmam = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsmam = aave(obsswcfmam,$aave_region)
undefine fieldtemp

define fieldtemp = ave(obsclim,t=4,t=6)
define obsswcfjja = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsjja = aave(obsswcfjja,$aave_region)
undefine fieldtemp

define fieldtemp = ave(obsclim,t=7,t=9)
define obsswcfson = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define aveobsson = aave(obsswcfson,$aave_region)
undefine fieldtemp
EOF
    breaksw

endsw

#----------------------------- model code ------------------------------

cat << EOF >> $plot_file

set dfile $num_mod_file
set x 1 $mod_nlon
set y 1 $mod_nlat
set z 1
set t 1 12
define mswcf = $mod_var
set t 1

define fieldtemp = ave(mswcf,t=1,t=12)
define mswcfann = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemodann = aave(mswcfann,$aave_region)
undefine fieldtemp

define fieldtemp = (2.0*ave(mswcf,t=1,t=2)+mswcf(t=12))/3.
define mswcfdjf = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemoddjf = aave(mswcfdjf,$aave_region)
undefine fieldtemp

define fieldtemp = ave(mswcf,t=3,t=5)
define mswcfmam = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemodmam = aave(mswcfmam,$aave_region)
undefine fieldtemp

define fieldtemp = ave(mswcf,t=6,t=8)
define mswcfjja = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemodjja = aave(mswcfjja,$aave_region)
undefine fieldtemp

define fieldtemp = ave(mswcf,t=9,t=11)
define mswcfson = regrid2(fieldtemp,$regrid_dlon,$regrid_dlat,ba_p1,$regrid_lon1,$regrid_lat1)
define avemodson = aave(mswcfson,$aave_region)
undefine fieldtemp

EOF

########################################################################
else if ( $mod_grid_type == mod && $obs_grid_type == obs ) then
########################################################################

#------------------------------ obs code -------------------------------

switch ( $obs_source )

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case ERBE:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
set dfile 1
set x 1 144
set y 1 73
set z 1
* set missing values to zero
set t 1 12
define newcldfrc = const(nswcft,0.,-u)
set t 1

define obsswcfann = ave(newcldfrc,t=1,t=12)
define aveobsann = aave(obsswcfann,$aave_region)

define obsswcfdjf = (2.*ave(newcldfrc,t=1,t=2)+newcldfrc(t=12))/3.
define aveobsdjf = aave(obsswcfdjf,$aave_region)

define obsswcfmam = ave(newcldfrc,t=3,t=5)
define aveobsmam = aave(obsswcfmam,$aave_region)

define obsswcfjja = ave(newcldfrc,t=6,t=8)
define aveobsjja = aave(obsswcfjja,$aave_region)

define obsswcfson = ave(newcldfrc,t=9,t=11)
define aveobsson = aave(obsswcfson,$aave_region)
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_ES4:
  case CERES_SRBAVG_nonGEO:
  case CERES_SRBAVG_GEO:
  case CERES_EBAF:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
set dfile 1
set x 1 $obs_nlon
set y 1 $obs_nlat
set z 1
set t 1

define obsswcfann = ave($obs_var,t=1,t=12)
define aveobsann = aave(obsswcfann,$aave_region)

define obsswcfdjf = ave($obs_var,t=10,t=12)
define aveobsdjf = aave(obsswcfdjf,$aave_region)

define obsswcfmam = ave($obs_var,t=1,t=3)
define aveobsmam = aave(obsswcfmam,$aave_region)

define obsswcfjja = ave($obs_var,t=4,t=6)
define aveobsjja = aave(obsswcfjja,$aave_region)

define obsswcfson = ave($obs_var,t=7,t=9)
define aveobsson = aave(obsswcfson,$aave_region)
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_Ed2.6:
  case CERES_EBAF_TOA_Ed2.7:
  case CERES_EBAF_SFC_Ed2.7:
  case CERES_EBAF_ATM_Ed2.7:
  case CERES_EBAF_TOA_Ed2.8:
  case CERES_EBAF_SFC_Ed2.8:
  case CERES_EBAF_ATM_Ed2.8:
  case CERES_EBAF_TOA_Ed4.0:
  case CERES_EBAF_SFC_Ed4.0:
  case CERES_EBAF_ATM_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# special case: define obs climatology

cat << EOF >> $plot_file
set dfile 1
set x 1 360
set y 1 180
set z 1
set t 1 12
define obsclim = ave($obs_var,t+$obs_dts,t=$obs_tf,12)
set t 1

define obsswcfann = ave(obsclim,t=1,t=12)
define aveobsann = aave(obsswcfann,$aave_region)

define obsswcfdjf = ave(obsclim,t=10,t=12)
define aveobsdjf = aave(obsswcfdjf,$aave_region)

define obsswcfmam = ave(obsclim,t=1,t=3)
define aveobsmam = aave(obsswcfmam,$aave_region)

define obsswcfjja = ave(obsclim,t=4,t=6)
define aveobsjja = aave(obsswcfjja,$aave_region)

define obsswcfson = ave(obsclim,t=7,t=9)
define aveobsson = aave(obsswcfson,$aave_region)
EOF
    breaksw

endsw

#----------------------------- model code ------------------------------

cat << EOF >> $plot_file

set dfile $num_mod_file
set x 1 $mod_nlon
set y 1 $mod_nlat
set z 1
set t 1 12
define mswcf = $mod_var
set t 1

define mswcfann = ave(mswcf,t=1,t=12)
define avemodann = aave(mswcfann,$aave_region)

define mswcfdjf = (2.0*ave(mswcf,t=1,t=2)+mswcf(t=12))/3.
define avemoddjf = aave(mswcfdjf,$aave_region)

define mswcfmam = ave(mswcf,t=3,t=5)
define avemodmam = aave(mswcfmam,$aave_region)

define mswcfjja = ave(mswcf,t=6,t=8)
define avemodjja = aave(mswcfjja,$aave_region)

define mswcfson = ave(mswcf,t=9,t=11)
define avemodson = aave(mswcfson,$aave_region)

EOF

########################################################################
else
########################################################################

  echo mod_grid_type = $mod_grid_type  obs_grid_type = $obs_grid_type
  exit 1

########################################################################
endif
########################################################################

#---------------- "run plot_3panel_radiation" command ------------------

switch ( $obs_source )

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case ERBE:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
run plot_3panel_radiation mswcf avemod obsswcf aveobs SWCF $stats_region (W/m\`a2\`n)
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_ES4:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
run plot_3panel_radiation mswcf avemod obsswcf aveobs SWCF $stats_region (W/m\`a2\`n) FM1 Edition2_Rev1
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_SRBAVG_nonGEO:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
run plot_3panel_radiation mswcf avemod obsswcf aveobs SWCF $stats_region (W/m\`a2\`n) FM1 Edition2D-Rev1
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_SRBAVG_GEO:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
run plot_3panel_radiation mswcf avemod obsswcf aveobs SWCF $stats_region (W/m\`a2\`n) XTRK Edition2D-Rev1
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_SFC_Ed2.7:
  case CERES_EBAF_SFC_Ed2.8:
  case CERES_EBAF_SFC_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
run plot_3panel_radiation mswcf avemod obsswcf aveobs SWCRESFC $stats_region (W/m\`a2\`n)
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF_ATM_Ed2.7:
  case CERES_EBAF_ATM_Ed2.8:
  case CERES_EBAF_ATM_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
run plot_3panel_radiation mswcf avemod obsswcf aveobs SWCRE_RATIO $stats_region
EOF
    breaksw

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  case CERES_EBAF:
  case CERES_EBAF_Ed2.6:
  case CERES_EBAF_TOA_Ed2.7:
  case CERES_EBAF_TOA_Ed2.8:
  case CERES_EBAF_TOA_Ed4.0:
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

cat << EOF >> $plot_file
run plot_3panel_radiation mswcf avemod obsswcf aveobs SWCRE $stats_region (W/m\`a2\`n)
EOF
    breaksw

endsw

echo
echo '*** finished script "'$0'" ***'
echo

exit 0
