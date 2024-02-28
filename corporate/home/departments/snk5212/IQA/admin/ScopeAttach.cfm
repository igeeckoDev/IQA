<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "Upload Files - Scope Letter">
<cfinclude template="SOP.cfm">

<!--- / --->

<CFQUERY BLOCKFACTOR="100" name="AddReport" Datasource="Corporate">
SELECT * FROM AuditSchedule
WHERE ID = #URL.ID#
and Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</CFQUERY>

<cfif isDefined("Form.Submit")>

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
accept="application/pdf, application/msword">

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

<cflocation url="ScopeAttachEmail.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">

<cfelse>
<cfoutput query="AddReport">

<CFFORM METHOD="POST" ENCTYPE="multipart/form-data" name="ScopeLetter" ACTION="#CGI.Script_Name#?ID=#ID#&Year=#Year#">
<br>
Upload New Scope Letter Attachment for <b>#year#-#id#</b>:<br>
File must be PDF Format<br>
<INPUT NAME="File" SIZE=50 Type="File"><br><br>

<INPUT TYPE="Submit" value="Submit Update" name="Submit">

</CFFORM>
</cfoutput> 
</cfif>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->