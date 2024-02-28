<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "DAP Client List">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfif NOT isDefined("URL.Order")>
	<cfset URL.Order = "DA">
</cfif>

<CFQUERY BLOCKFACTOR="100" name="DAPClientList" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM DAPClient
<cfif LEN("URL")>
WHERE 1 = 1
</cfif>
<cfif isDefined("URL.Status")>
	AND Status = '#URL.Status#'
</cfif>
<cfif isDefined("URL.Region")>
	AND Region = '#URL.Region#'
</cfif>
ORDER BY <cfif URL.Order eq "DA">DAFILENUMBER<cfelseif URL.Order eq "Client">CLIENTNAME</cfif>
</cfquery>

<CFQUERY BLOCKFACTOR="100" name="Regions" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT DISTINCT REGION
FROM DAPClient
WHERE 1 = 1
<cfif isDefined("URL.Status")>
	AND Status = '#URL.Status#'
</cfif>
ORDER BY Region
</cfquery>

<cfinclude template="#IQADir#cfscript_queryStringRemoveItem.cfm">
<cfset qs = cgi.query_string>

<cfoutput>
<cfset newURL = queryStringDeleteVar("Status", qs)>

<b>Status</b>: <cfif isDefined("URL.Status")><b>#Status#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
<SELECT NAME="StatusJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Status Below
	<option value="javascript:document.location.reload();">
	<OPTION VALUE="#CGI.ScriptName#?#newURL#&Status=Active">Active</OPTION>
	<OPTION VALUE="#CGI.ScriptName#?#newURL#&Status=Inactive">Inactive</OPTION>
</SELECT><br><br>

<cfset newURL = queryStringDeleteVar("Region", qs)>

<B>Region</B>: <cfif isDefined("URL.Region")><b>#Region#</b> [<A href="#CGI.ScriptName#?#newURl#">remove</A>]<cfelse>All</cfif><br>
<SELECT NAME="StatusJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Region Below
	<option value="javascript:document.location.reload();">
	<cfloop query="Regions">
		<OPTION VALUE="#CGI.ScriptName#?#newURL#&Region=#Region#">#Region#</OPTION>
	</cfloop>
</SELECT><br><br>

<cfset newURL = queryStringDeleteVar("Order", qs)>

<u>Order By</u>:
<cfif URL.Order eq "DA">
	<b>DA File Number</b> :: <a href="#CGI.ScriptName#?#newURL#&Order=Client">Client Name</a>
<cfelseif URL.Order eq "Client">
	<a href="#CGI.ScriptName#?#newURL#&Order=DA">DA File Number</a> :: <b>Client Name</b>
</cfif>
<br><br>

<b>Export Audit Schedule</b><br>
<a href="DAPClientList_ExportToExcel.cfm?#CGI.Query_String#" target="_blank">Export</a> DAP Client List to Excel<br><br>
</cfoutput>

<cflock scope="SESSION" timeout="10">
	<cfif SESSION.Auth.AccessLevel eq "Admin"
	  OR SESSION.Auth.AccessLevel eq "SU">
<a href="DAPClientList_Add.cfm">Add</a> DAP Client<br><br>
	</cfif>
</cflock>

<style type="text/css">
	tr.shade:nth-child(even) {background: #FFF}
	tr.shade:nth-child(odd) {background: #EEE}
</style>

<table border="1" width="900" style="border-collapse: collapse;">
<tr valign="top">
	<th>DA File Number</th>
	<th>Client Name</th>
	<th>Status</th>
	<th>Region</th>
	<!---
	<th>Anniversary Date</th>
	--->
	<th nowrap>DAP Participant Programs</th>
	<th>View Client Details / Add Audit</th>
</tr>
<cfoutput query="DAPClientList">
<tr valign="top" class="shade">
	<td>#DAFileNumber#</td>
	<td>#ClientName#</td>
	<td>
		<cfif len(status)>
			#Status#
		<cfelse>
			None Listed
		</cfif>
	</td>
	<td nowrap>#Region#</td>
	<!---
	<td>#dateformat(AnniversaryDate, "mm/dd/yyyy")#</td>
	--->
	<td>
		<cfif len(ACTL)><u>ACTL</u>: #ACTL#<br></cfif>
		<cfif len(CBTL)><u>CBTL</u>: #CBTL#<br></cfif>
		<cfif len(CTDP)><u>CTDP</u>: #CTDP#<br></cfif>
		<cfif len(CTF)><u>CTF Stage 3/4</u>: #CTF#<br></cfif>
		<cfif len(TCP)><u>TCP</u>: #TCP#<br></cfif>
		<cfif len(TPTDP)><u>TPTDP</u>: #TPTDP#<br></cfif>
		<cfif len(CAP)><u>CAP</u>: #CAP#<br></cfif>
		<cfif len(PPP)><u>PPP</u>: #PPP#<br></cfif>
	</td>
	<td align="center"><a href="DAPClientList_Details.cfm?rowID=#ID#"><img src="#IQADir#images/ico_article.gif" border="0"></a></td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->
