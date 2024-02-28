<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfif Form.Publish is "Cancel">
<cflocation url="Report_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
<cfelseif Form.Publish is "Confirm to Publish Report">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Report='Completed'

WHERE ID = #URL.ID# AND Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Type" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.AuditType2, AuditSchedule.AuditType
 FROM AuditSchedule
 WHERE AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ID = #URL.ID#
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.Approved, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, IQAtblOffices.Regional1, IQAtblOffices.Regional2, IQAtblOffices.Regional3
 FROM AuditSchedule, IQAtblOffices
 WHERE AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ID = #URL.ID#
 AND  AuditSchedule.AuditedBy = '#URL.AuditedBy#'
 AND  AuditSchedule.OfficeName = IQAtbloffices.OfficeName
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfif auditedby is "IQA">
<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to=	"#trim(Email)#, #trim(RQM)#, #trim(QM)#, #trim(GM)#, #trim(LES)#, #trim(Other)#, #trim(Other2)#"
	bcc= "Internal.Quality_Audits@ul.com, christopher.j.nicastro@ul.com"
	subject="IQA Audit Completed (#year#-#id#-#auditedby#)" 
	Mailerid="Audit Completion - Notification">IQA Audit #Year#-#ID# has been completed.

You can access the report by following the link below:
http://#CGI.Server_Name#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#

Audit Details:
http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#

The Local Quality Manager is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>

<cfelse>

<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to=	"#trim(Email)#, #trim(RQM)#, #trim(QM)#, #trim(GM)#, #trim(LES)#, #trim(Other)#, #trim(Other2)#, #trim(Regional1)#, #trim(Regional2)#, #trim(Regional3)#"
	bcc= "Internal.Quality_Audits@ul.com, christopher.j.nicastro@ul.com"
	subject="Regional Audit Completed (#year#-#id#-#auditedby#)" 
	Mailerid="Audit Completion - Notification">Regional Audit #Year#-#ID# has been completed.	
	
You can access the report by following the link below:
http://#CGI.Server_Name#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#

Audit Details:
http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#

The Local Quality Manager is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>
</cfif>
</cfif>

<cflocation url="Report_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">
