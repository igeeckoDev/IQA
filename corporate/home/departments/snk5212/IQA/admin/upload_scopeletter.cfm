<cfdump var="#Form#">

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF Form.Scope is "">
	<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="Scope"
DESTINATION="#IQARootPath#ScopeLetters\" 
NAMECONFLICT="OVERWRITE">

<cfset FileName="#Form.Scope#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#basedir#ScopeLetters\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="Report" Datasource="Corporate">
UPDATE AuditSchedule

SET 
<CFIF File is "">
<CFELSE>
ScopeLetter='#NewFileName#',
ScopeLetterDate='#curdate#'
</CFIF>

WHERE ID=#URL.ID# and Year=<cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">