<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF NOT len(AgendaFile)>
	<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="AgendaFile" 
DESTINATION="#IQARootDir#ScopeLetters\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf, application/x-zip-compressed">

<cfset FileName="#Form.AgendaFile#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">

 
<cffile
    action="rename"
    source="#FileName#"
    destination="#IQARootDir#ScopeLetters\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="Report" Datasource="Corporate">
UPDATE AuditSchedule

SET 
<CFIF NOT len(AgendaFile)>
<CFELSE>
Agenda='#NewFileName#'
</CFIF>

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfoutput>
	<cflocation url="Auditdetails.cfm?#CGI.QUERY_STRING#" addtoken="no">
</cfoutput>