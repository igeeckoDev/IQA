<CFQUERY BLOCKFACTOR="1000" Datasource="Corporate" NAME="TPTDP">
SELECT * FROM ExternalLocation
<cfif isDefined("URL.ID")>
	WHERE ID = #URL.ID#
<cfelseif isDefined("URL.ExternalLocation")>
	WHERE ExternalLocation = '#URL.ExternalLocation#'
</cfif>
</CFQUERY>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "#Request.SiteTitle# -TPTDP Notes - <cfoutput>#TPTDP.ExternalLocation#</cfoutput>">
<cfinclude template="SOP.cfm">

<!--- / --->

<br>
<cfoutput query="TPTDP">
<u>Notes</u>:<br><br>

#Notes#
</cfoutput>

<!--- Footer, End of Page HTML --->

<cfinclude template="EOP.cfm">

<!--- / --->