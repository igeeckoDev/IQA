<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit">
UPDATE IQARegion
SET 
TechnicalAudits_ROM = '#Form.TechnicalAudits_SQM#'
WHERE ID = #FORM.RegionID#
</CFQUERY>

<cflocation url="TechnicalAudits_ROM.cfm?var=msg&RegionID=#FORM.RegionID#&ROM=#Form.TechnicalAudits_SQM#" addtoken="no">