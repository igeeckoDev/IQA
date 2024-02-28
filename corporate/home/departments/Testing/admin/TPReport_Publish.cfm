<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Report='Completed'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cfquery BLOCKFACTOR="100" Datasource="Corporate" NAME="checkEmail"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT tpreport.recommend, tpreport.id, recommend.text, recommend.id,"TPREPORT".YEAR_ as "Year"
 FROM TPReport, recommend
 WHERE tpreport.ID = #URL.ID#  AND  tpreport.Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  tpreport.recommend = recommend.id
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<cfquery BLOCKFACTOR="100" Datasource="Corporate" NAME="Email"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.LeadAuditor, AuditSchedule.ExternalLocation, TPReport.Recommend, AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", TPReport.ID,"TPREPORT".YEAR_ as "Year", recommend.id, recommend.recommend
 FROM TPReport, AuditSchedule, Recommend
 WHERE auditschedule.id = tpreport.id
 AND auditschedule.YEAR__=tpreport.year AND  AuditSchedule.ID = #URL.ID# 
 AND  AuditSchedule.Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  tpreport.recommend = recommend.id
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</cfquery>

<cfmail
 to="Internal.Quality_Audits@ul.com, James.E.Feth@ul.com, Jodine.E.Hepner@ul.com"
 from="Internal.Quality_Audits@ul.com"
 subject="Third Party Report of #ExternalLocation#"
 query="Email">
Submitted by: #LeadAuditor#

#Recommend#
</cfmail>

<cflocation url="TPReport_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">