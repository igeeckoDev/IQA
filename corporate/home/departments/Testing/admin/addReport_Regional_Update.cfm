<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.File is "">
	<cflocation url="#link#" ADDTOKEN="No">
</CFIF>

<cfif url.type is "Report">
	<CFFILE ACTION="UPLOAD" 
	FILEFIELD="Form.File" 
	DESTINATION="#IQARootPath#Reports" 
	NAMECONFLICT="OVERWRITE">
</cfif>

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">

<cfif url.type is "Report">
	<cffile
	action="rename"
	source="#FileName#"
	destination="#IQARootPath#Reports\#NewFileName#">
</cfif>
    

<CFQUERY BLOCKFACTOR="100" NAME="Upload" Datasource="Corporate">
UPDATE AuditSchedule

SET 
<cfif url.type is "Report">
Report
<cfelseif url.type is "Agenda">
Agenda
</cfif>
='#NewFileName#'

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">