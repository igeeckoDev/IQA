<cfset Self = GetFileFromPath(cgi.CF_TEMPLATE_PATH)>
<cfset DirToList = GetDirectoryFromPath(ExpandPath("./" & Self))>
<cfdirectory action="list" directory="#DirToList#" name="DirListing">

<CFQUERY BLOCKFACTOR="100" name="Rev" Datasource="Corporate">
SELECT Filename, RevNumber, RevDate
FROM WebHelp_All
WHERE FileName = '#Self#'
AND RevNumber = (SELECT Max(RevNumber) FROM WebHelp_All WHERE FileName = '#Self#')
</cfquery>

<CFQUERY DataSource="Corporate" Name="Details"> 
SELECT webHelp.ID, webHelp.fileName, webHelp.Title, webHelp.Category, webHelp_Rev.RevNumber, webHelp_Rev.RevDate
FROM webHelp, webHelp_Rev
WHERE webHelp.fileName = '#Self#'
AND webHelp.ID = webHelp_Rev.webHelpID
AND webHelp_Rev.RevNumber = (SELECT MAX(webHelp_REv.RevNumber) FROM webHelp, WebHelp_Rev WHERE webHelp.fileName = '#Self#' AND webHelp.ID = webHelp_Rev.webHelpID)
</CFQUERY>

<cfoutput query="Details">
<br>
<u>Revision History</u><br>
Filename: #FileName# (#ID#)<br>
Title: #Title#<br />
Category: #Category#<br />
Rev Number: #RevNumber#<br>
Rev Date: #DateFormat(RevDate, 'mm/dd/yyyy')#<br><br>

	<cflock scope="session" timeout="6">
		<cfif isDefined("SESSION.Auth.isLoggedIn")>
			<cfif SESSION.Auth.AccessLevel eq "SU"
				OR SESSION.Auth.AccessLevel eq "Admin">
					<a href="updateRevHistory.cfm?ID=#ID#">Update Rev History</a>
			</cfif>
		</cfif>
	</cflock>
</cfoutput>