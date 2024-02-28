<cfset File = Form.File>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF File is "">
<cflocation url="#link#" ADDTOKEN="No">
</CFIF>

	<CFFILE ACTION="UPLOAD" 
	FILEFIELD="File" 
	DESTINATION="#IQARootPath#Reports\" 
	NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">

	<cffile
	action="rename"
	source="#FileName#"
	destination="#IQARootPath#Reports\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="Upload" Datasource="Corporate">
UPDATE AuditSchedule

SET 
<CFIF File is "">
<CFELSE>

Report='#NewFileName#'
</CFIF>

WHERE ID=#URL.ID# and Year_=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">