<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfif FORM.CBTL is "1">

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF File is "">
<cflocation url="#link#">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="File" 
DESTINATION="#basedir#CBTL\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">
 
<cffile
action="rename"
source="#FileName#"
destination="#basedir#CBTL\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="Report" Datasource="Corporate">
UPDATE AuditSchedule
SET 

Report2='Completed'

WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#">

<cfelseif Form.CBTL is "0">

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF File is "">
<cflocation url="#link#">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="File" 
DESTINATION="#basedir#Reports\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">
 
<cffile
action="rename"
source="#FileName#"
destination="#basedir#Reports\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="Report" Datasource="Corporate">
UPDATE AuditSchedule
SET 

Report='#NewFileName#'

WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="addreport" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif addreport.auditedby is NOT "Field Services">
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

<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to=	"#trim(Email)#, #trim(RQM)#, #trim(QM)#, #trim(GM)#, #trim(LES)#, #trim(Other)#, #trim(Other2)#, #trim(Regional1)#, #trim(Regional2)#, #trim(Regional3)#"
	bcc= "Internal.Quality_Audits@ul.com"
	subject="Regional Audit Completed (#year#-#id#-#auditedby#)" 
	Mailerid="Audit Completion - Notification">Regional Audit #Year#-#ID# has been completed.	
	
You can access the report by following the link below:
http://#CGI.Server_Name#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#

Audit Details:
http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#

The Local Quality Manager is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>

<cfelse>

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.Area, AuditSchedule.Approved
 FROM AuditSchedule
 WHERE AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ID = #URL.ID#
 AND  AuditSchedule.AuditedBy = '#URL.AuditedBy#'
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to=	"John.Carlin@ul.com"
	bcc= "Internal.Quality_Audits@ul.com"
	subject="IQA Audit Completed (#year#-#id#-#auditedby#)" 
	Mailerid="Audit Completion - Notification">IQA Audit #Year#-#ID# has been completed.

You can access the report by following the link below:
http://#CGI.Server_Name#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#

Audit Details:
http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#

The Field Service Quality Rep is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>
</cfif>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#">

</cfif>
