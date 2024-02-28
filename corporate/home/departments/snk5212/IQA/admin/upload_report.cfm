<cfset File = Form.File>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF File is "">
<cflocation url="#link#" addtoken="no">
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
<CFIF File is "">
<CFELSE>
Report='#NewFileName#'
</CFIF>

WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">