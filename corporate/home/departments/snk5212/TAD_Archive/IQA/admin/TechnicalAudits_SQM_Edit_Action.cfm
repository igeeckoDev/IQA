<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Edit">
UPDATE IQAtblOffices
SET 
TechnicalAudits_SQM = '#Form.TechnicalAudits_SQM#'
WHERE ID = #FORM.OfficeID#
</CFQUERY>

<cflocation url="TechnicalAudits_SQM.cfm?var=msg&OfficeID=#FORM.OfficeID#&SQM=#Form.TechnicalAudits_SQM#" addtoken="no">