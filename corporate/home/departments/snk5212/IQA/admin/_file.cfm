<cfset Self = GetFileFromPath(cgi.CF_TEMPLATE_PATH)>
<cfset DirToList = GetDirectoryFromPath(ExpandPath("./" & Self))>
<cfdirectory action="list" directory="#DirToList#" name="DirListing">

<CFQUERY Name="Files" Datasource="Corporate">
SELECT * From Rev_IQAAdminFiles
WHERE FileName = '#Self#'
</CFQUERY>

<cfif Files.FileName is NOT "">
<cfoutput>
Exists - #Self# - #Files.FileName#
</cfoutput>
<cfelse>
<cfoutput>
Does not Exist (#Self#) - REGISTER
</cfoutput>
</cfif>