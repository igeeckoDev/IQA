<cfif url.type is "Report">
	<CFFILE ACTION="UPLOAD"
	FILEFIELD="File"
	DESTINATION="#IQARootPath#Reports"
	NAMECONFLICT="OVERWRITE">

<cfelseif url.type is "Agenda">
	<CFFILE ACTION="UPLOAD"
	FILEFIELD="File"
	DESTINATION="#IQARootPath#ScopeLetters"
	NAMECONFLICT="OVERWRITE">

</cfif>

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">


<cfif url.type is "Report">
	<cffile
	action="rename"
	source="#FileName#"
	destination="#IQARootPath#Reports\#NewFileName#">
<cfelseif url.type is "Agenda">
	<cffile
	action="rename"
	source="#FileName#"
	destination="#IQARootPath#ScopeLetters\#NewFileName#">
</cfif>


<CFQUERY BLOCKFACTOR="100" NAME="Upload" Datasource="Corporate">
UPDATE AuditSchedule

SET
<CFIF Form.File is "">
<CFELSE>
	<cfif url.type is "Report">
Report
	<cfelseif url.type is "Agenda">
Agenda
	</cfif>
='#NewFileName#'
</CFIF>

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">