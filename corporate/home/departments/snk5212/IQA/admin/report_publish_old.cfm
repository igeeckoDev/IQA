<cfif Form.Publish is "Cancel">
	<cflocation url="Report_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">
<cfelseif Form.Publish is "Confirm to Publish Report">

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE AuditSchedule
SET 

Report='Completed',
ReportDate=#CreateODBCDate(curdate)#

WHERE ID = #URL.ID# 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Queryadd">
UPDATE Report
SET 

ReportDate=#CreateODBCDate(curdate)#

WHERE ID = #URL.ID# 
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cfif auditedby is NOT "IQA">
<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.AuditType2, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Approved, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, IQAtblOffices.Regional1, IQAtblOffices.Regional2, IQAtblOffices.Regional3
FROM AuditSchedule, IQAtblOffices
WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = #URL.ID#
AND AuditSchedule.AuditedBy = '#URL.AuditedBy#'
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
</CFQUERY>

<cflock scope="SESSION" timeout="60">
<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to="#trim(Email)#"
    cc="#Email2#, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#, #Regional1#, #Regional2#, #Regional3#"
	bcc="Internal.Quality_Audits@ul.com, #SESSION.Auth.Email#"
	subject="Regional Audit Completed (#year#-#id#-#auditedby#)" 
	Mailerid="Audit Completion - Notification"
    type="html">
Regional Audit #Year#-#ID# has been completed.<br /><br />
	
You can access the report by following the link below:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#</a><Br><Br>

Audit Details:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#</a><br><Br>

The Local Quality Manager is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>
</cflock>

<cfelse>

<CFQUERY BLOCKFACTOR="100" NAME="Type" Datasource="Corporate"> 
SELECT AuditType, ID, AuditedBy, YEAR_ as "Year", AuditType2, AuditType
FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = #URL.ID#
</CFQUERY>

<cfif Type.AuditType2 is "Local Function" 
	or Type.AuditType2 is "Local Function FS" 
	or Type.AuditType2 is "Local Function CBTL">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.LeadAuditor, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Approved, AuditSchedule.Area, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2

FROM AuditSchedule, IQAtblOffices

WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = #URL.ID#
AND AuditSchedule.AuditedBy = '#URL.AuditedBy#'
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
</CFQUERY>

<cflock scope="SESSION" timeout="60">
<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to="#trim(Email)#"
	bcc="Internal.Quality_Audits@ul.com, #SESSION.Auth.Email#"
    cc="#Email2#, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#"
	subject="Audit Completed - Quality System Audit of #Trim(OfficeName)# - #Trim(Area)#" 
	Mailerid="Audit Completion - Notification"
    type="html">
The Quality System Audit of #Trim(OfficeName)# - #Trim(Area)# has been completed.<br /><Br />

You can review the Audit Summary, Findings/Observations and Audit Coverage by following the link to the Audit Report below:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#</a><Br><Br>

For Audit Details:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#</a><br><br>

Please contact #LeadAuditor# for any questions or comments.<br /><br />

The Local Quality Manager is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>
</cflock>

<cfelseif Type.AuditType2 is "MMS - Medical Management Systems">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate">
SELECT 
AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.LeadAuditor, AuditSchedule.Year_ AS "Year", AuditSchedule.Area, AuditSchedule.Approved

FROM 
AuditSchedule

WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND AuditSchedule.AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cflock scope="SESSION" timeout="60">
<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to="#trim(Email)#"
	bcc="Internal.Quality_Audits@ul.com, #SESSION.Auth.Email#"
    cc="#Email2#"
	subject="Audit Completed - Quality System Audit of #Trim(Area)#" 
	Mailerid="Audit Completion - Notification"
    type="html">
The Quality System Audit of #Trim(Area)# has been completed.<br /><br />

You can review the Audit Summary, Findings/Observations and Audit Coverage by following the link to the Audit Report below:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#</a><Br><Br>

For Audit Details:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#</a><br><br>

Please contact #LeadAuditor# for any questions or comments.<br /><br />

The MMS Program Manager is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>
</cflock>

<cfelseif Type.AuditType2 is "Program">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.LeadAuditor, AuditSchedule.Email2, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Area, AuditSchedule.Approved, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, ProgDev.Program, ProgDev.PMEmail, ProgDev.POEmail

FROM AuditSchedule, IQAtblOffices, ProgDev

WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND AuditSchedule.AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
AND AuditSchedule.Area = ProgDev.Program
</CFQUERY>

<cflock scope="SESSION" timeout="60">
<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to=	"#trim(Email)#"
	bcc= "Internal.Quality_Audits@ul.com, #SESSION.Auth.Email#"
	cc="#Email2#, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#, #PMEmail#, #POEmail#"
    subject="Audit Completed - Quality System Audit of #trim(Area)#" 
	Mailerid="Audit Completion - Notification"
    type="html">
The Quality System Audit of #Trim(Area)# has been completed.<br /><br />

You can review the Audit Summary, Findings/Observations and Audit Coverage by following the link to the Audit Report below:<Br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#</a><Br><Br>

For Audit Details:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#</a><br><br>

Please contact #LeadAuditor# for any questions or comments.<br /><br />

The Program Manager and Program Owner are responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>
</cflock>

<cfelseif Type.AuditType2 is "Corporate">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.LeadAuditor, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Area, AuditSchedule.Approved, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, CorporateFunctions.Function, CorporateFunctions.Owner

FROM AuditSchedule, IQAtblOffices, CorporateFunctions

WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = #URL.ID#
AND AuditSchedule.AuditedBy = '#URL.AuditedBy#'
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
AND AuditSchedule.Area = CorporateFunctions.Function
</CFQUERY>

<cflock scope="SESSION" timeout="60">
<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to="#trim(Owner)#, #trim(Email)#"
	bcc="Internal.Quality_Audits@ul.com, #SESSION.Auth.Email#"
	cc="#Email2#, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#"
    subject="Audit Completed - Quality System Audit of #Trim(OfficeName)# - #Trim(Area)#" 
	Mailerid="Audit Completion - Notification"
    type="html">
The Quality System Audit of #Trim(OfficeName)# - #Trim(Area)# has been completed.<br /><br />

You can review the Audit Summary, Findings/Observations and Audit Coverage by following the link to the Audit Report below:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#</a><Br><Br>

For Audit Details:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#</a><br><br>

Please contact #LeadAuditor# for any questions or comments.<br /><br />

The Corporate Process Owner is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>
</cflock>

<cfelseif Type.AuditType2 is "Global Function/Process">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.LeadAuditor, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Area, AuditSchedule.Approved, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, GlobalFunctions.Function, GlobalFunctions.Owner

FROM AuditSchedule, IQAtblOffices, GlobalFunctions

WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = #URL.ID#
AND AuditSchedule.AuditedBy = '#URL.AuditedBy#'
AND AuditSchedule.OfficeName = IQAtbloffices.OfficeName
AND AuditSchedule.Area = GlobalFunctions.Function
</CFQUERY>

<cflock scope="SESSION" timeout="60">
<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to="#trim(Owner)#, #trim(Email)#"
	bcc="Internal.Quality_Audits@ul.com, #SESSION.Auth.Email#"
    cc="#Email2#, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#"    
	subject="Audit Completed - Quality System Audit of #Trim(OfficeName)# - #Trim(Area)#" 
	Mailerid="Audit Completion - Notification"
    type="html">
The Quality System Audit of #Trim(OfficeName)# - #Trim(Area)# has been completed.<br /><br />

You can review the Audit Summary, Findings/Observations and Audit Coverage by following the link to the Audit Report below:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#</a><Br><Br>

For Audit Details:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#</a><br><br>

Please contact #LeadAuditor# for any questions or comments.<br /><br />

The Global Process Owner is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>
</cflock>

<cfelseif Type.AuditType2 is "Field Services">

<CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, AuditSchedule.LeadAuditor, AUDITSCHEDULE.YEAR_ as "Year", AuditSchedule.Area, AuditSchedule.Approved

FROM AuditSchedule

WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = #URL.ID#
AND AuditSchedule.AuditedBy = '#URL.AuditedBy#'
</CFQUERY>

<cflock scope="SESSION" timeout="60">
<cfmail 
	query="Notify"
	from="Internal.Quality_Audits@ul.com" 
	to="#trim(Email)#"
    cc="#Email2#, John.Carlin@ul.com, Clint.Ferguson@ul.com"
	bcc="Internal.Quality_Audits@ul.com, #SESSION.Auth.Email#"
	subject="Audit Completed - Quality System Audit of Field Services - #trim(Area)#" 
	Mailerid="Audit Completion - Notification"
    type="html">
The Quality System Audit of Field Services - #Trim(Area)# has been completed.<br /><br />

You can review the Audit Summary, Findings/Observations and Audit Coverage by following the link to the Audit Report below:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/Report_Output_all.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#</a><Br><Br>

For Audit Details:<br />
<a href="http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">http://#CGI.SERVER_NAME#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#</a><br><br>

Please contact #LeadAuditor# for any questions or comments.<br /><br />

The Field Service Quality Rep is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
</cfmail>
</cflock>

</cfif>

</cfif>
</cfif>

<cflog application="no" 
	   file="iqaCompletedAudits" 
	   text="Audit #URL.Year#-#URL.ID#-#URL.AuditedBy# Completed" 
	   type="Information">

<cflocation url="Report_output_all.cfm?ID=#URL.ID#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#" addtoken="no">