<cfquery name="Input" Datasource="Corporate">
UPDATE Plan
SET 

Comments='#form.e_comments#'

WHERE Year_ = #URL.Year# 
AND OfficeName = '#URL.OfficeName#' 
AND Start_ = #URL.Start# 
AND AuditedBy = '#URL.AuditedBy#'
</cfquery>

<cflocation url="Audit_Plan.cfm?Officename=#URL.Officename#&Start=#URL.Start#&AuditedBy=#URL.AuditedBy#" ADDTOKEN="No">