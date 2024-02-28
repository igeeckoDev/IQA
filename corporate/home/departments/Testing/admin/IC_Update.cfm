<cfif NOT isDefined("form.ICComments")>
	<cflocation url="IC_Edit.cfm?#CGI.Query_String#&requiredfields=Yes" addtoken="no">
</cfif>
<!---
	<script language="JavaScript" src="../webhelp/webhelp.js"></script>
--->

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IC">
SELECT IC, ICComments, OfficeName, ID
FROM IQAtblOffices
WHERE ID = #URL.ID#
</cfquery>

<!---
<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->

<cfset title = "UL Locations - SNAP Details - #SNAP.OfficeName#">
<cfinclude template="SOP.cfm">

<!--- / --->
--->

<cfset Dump = #replace(form.ICComments, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br />", "All")#>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="SNAP">
UPDATE IQAtblOffices
SET
IC='#Form.IC#',
<cfif Dump2 eq "<br />" OR NOT len(Dump2)>
	ICComments='#curdate# (#curtime#) - IC=#Form.IC# - Comments= No Comments<Br>#IC.ICComments#'
<cfelse>
	ICComments='#curdate# (#curtime#) - IC=#Form.IC# - #Dump2##IC.ICComments#'
</cfif>

WHERE ID = #URL.ID#
</cfquery>

<cflocation url="IC_Details.cfm?#CGI.QUERY_STRING#" addtoken="No">