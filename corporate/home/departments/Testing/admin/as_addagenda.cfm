<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF AgendaFile is "">
<cflocation url="#link#" ADDTOKEN="No">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="AgendaFile" 
DESTINATION="d:\webserver\corporate\home\departments\snk5212\iqa\ScopeLetters\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf, application/x-zip-compressed">

<cfset FileName="#Form.AgendaFile#">

<cfset NewFileName="#URL.Year#-#URL.ID#.#cffile.ClientFileExt#">

 
<cffile
    action="rename"
    source="#FileName#"
    destination="d:\webserver\corporate\home\departments\snk5212\iqa\ScopeLetters\#NewFileName#">

<CFQUERY BLOCKFACTOR="100" NAME="Report" Datasource="Corporate">
UPDATE AuditSchedule

SET 
<CFIF AgendaFile is "">
<CFELSE>
Agenda='#NewFileName#'
</CFIF>

WHERE Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer"> 
AND ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cflocation url="auditdetails?ID=#URL.ID#&Year=#URL.Year#" ADDTOKEN="No">