<cfif FORM.CBTL is "1">

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.File is "">
	<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="Form.File" 
DESTINATION="#IQARootPath#CBTL\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">
 
<cffile
action="rename"
source="#FileName#"
destination="#IQARootPath#CBTL\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="Report" Datasource="Corporate">
UPDATE AuditSchedule
SET 

Report2='Completed',
Reportdate=#CreateODBCDate(curdate)#

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">

<cfelseif Form.CBTL is "0">

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.File is "">
	<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="Form.File" 
DESTINATION="#IQARootPath#Reports\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">
 
<cffile
action="rename"
source="#FileName#"
destination="#IQARootPath#Reports\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="Report" Datasource="Corporate">
UPDATE AuditSchedule
SET 

Report='#NewFileName#',
Reportdate=#CreateODBCDate(curdate)#

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<CFQUERY BLOCKFACTOR="100" NAME="addreport" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif addreport.auditedby is NOT "Field Services">
    <CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
    SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, "AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.Approved, IQAtblOffices.OfficeName, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2, IQAtblOffices.Regional1, IQAtblOffices.Regional2, IQAtblOffices.Regional3
     FROM AuditSchedule, IQAtblOffices
     WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
     AND  AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
     AND  AuditSchedule.AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">
     AND  AuditSchedule.OfficeName = IQAtbloffices.OfficeName
    </CFQUERY>

	<cfif Notify.Approved eq "Yes">
        <cfmail 
            query="Notify"
            from="Internal.Quality_Audits@ul.com" 
            to=	"#trim(Email)#"
            cc="#trim(RQM)#, #trim(QM)#, #trim(GM)#, #trim(LES)#, #trim(Other)#, #trim(Other2)#, #trim(Regional1)#, #trim(Regional2)#, #trim(Regional3)#, #trim(Email2)#"
            bcc= "Internal.Quality_Audits@ul.com, Kai.Huang@ul.com"
            subject="Regional Audit Completed (#year#-#id#-#auditedby#)" 
            Mailerid="Audit Completion - Notification"
            type="html">
        Regional Audit #Year#-#ID# has been completed.<br /><br />
            
        You can access the audit details by following the link below, which includes a link to the audit report:<br />
        <a href="http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#
        </a><br /><br />
        
        The Local Quality Manager is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
        </cfmail>
    </cfif>

<cfelse>
	<!--- Field Services --->
    <CFQUERY BLOCKFACTOR="100" NAME="Notify" Datasource="Corporate"> 
    SELECT AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.Email2, "AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.Area, AuditSchedule.Approved
     FROM AuditSchedule
     WHERE AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
     AND  AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
     AND  AuditSchedule.AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="cf_sql_varchar">
    </CFQUERY>

	<cfif Notify.Approved eq "Yes">
        <cfmail 
            query="Notify"
            from="Internal.Quality_Audits@ul.com" 
            to=	"#Email#"
            cc="John.Carlin@ul.com, Steven.J.Schmid@ul.com, #Email2#" 
            bcc= "Internal.Quality_Audits@ul.com, Kai.Huang@ul.com"
            subject="Field Services Regional Audit of #OfficeName# Completed (#Year#-#ID#-#AuditedBy#)" 
            Mailerid="#year#-#id#-#AuditedBy# Audit Completion"
            type="html">
        Field Services Regional Audit #year#-#id# of #OfficeName# has been completed and the audit report has been published to the IQA web site.<br /><br />
        
        You can access the audit details by following the link below, which includes a link to the audit report:<br />
        <a href="http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#">http://#CGI.Server_Name#/departments/snk5212/IQA/auditdetails.cfm?ID=#ID#&Year=#Year#</a><br><br>
        
        The Field Service Quality Rep is responsible for forwarding this information to parties associated or responsible for the areas covered in this audit.
        </cfmail>
    </cfif>
</cfif>
	<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
</cfif>