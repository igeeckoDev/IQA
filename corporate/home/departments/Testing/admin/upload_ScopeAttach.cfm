<cfset File = Form.File>

<cfparam name="link" default="">
<cfset link="#HTTP_Referer#">

<CFIF File is "">
<cflocation url="#link#" addtoken="no">
</CFIF>

<CFFILE ACTION="UPLOAD" 
FILEFIELD="File" 
DESTINATION="#basedir#ScopeLetters\" 
NAMECONFLICT="OVERWRITE"
accept="application/pdf, application/x-zip-compressed, application/msword">

<cfset FileName="#Form.File#">

<cfset NewFileName="#URL.Year#-#URL.ID#-Attach.#cffile.ClientFileExt#">
 
<cffile
    action="rename"
    source="#FileName#"
    destination="#basedir#ScopeLetters\#NewFileName#">

<CFQUERY Datasource="Corporate" Name="EnterScope">
UPDATE Scope
SET

AttachA='#NewFileName#'

WHERE ID = #URL.ID# AND YEAR = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>

<cfoutput>
<cflocation url="ScopeLetter_View.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
</cfoutput>