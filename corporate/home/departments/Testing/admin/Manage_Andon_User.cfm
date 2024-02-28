<cfif URL.Action is "Added">
	<cfset Action = "Yes">
<cfelseif URL.Action is "Removed">
	<cfset Action = "No">
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="Andon" Datasource="Corporate"> 
UPDATE IQADB_Login
SET
Andon = '#Action#'
WHERE ID = #URL.ID#
</CFQUERY>

<cflocation url="manage.cfm?Role=Andon&ID=#URL.ID#&Action=#URL.Action#" addtoken="no">