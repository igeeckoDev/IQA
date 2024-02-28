<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<a href="qManagementChain.cfm">GCAR Report - Exclude from Management Escalation Chain</a> :: Modify List<br><br>

<u>Available Actions</u><Br>
:: <a href="qManagementChain_Add.cfm">Add Name</a><br><br>

<cfquery name="qGetNames" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM GCAR_METRICS_ManagementChain
ORDER BY Name
</cfquery>

<table border="1">
<tr>
	<th width="150">Name</th>
	<th width="75">Edit</th>
	<th width="150">Status</th>
</tr>
<cfoutput query="qGetNames">
<tr>
	<td>#Name#</td>
	<td align="center"><a href="qManagementChain_ModifyItem.cfm?ID=#ID#">Edit</a></td>
	<td align="center">
		<cfif len(status)>
			<font class="warning">
				Removed :: <a href="qManagementChain_Status.cfm?ID=#ID#&Action=Reinstate">Reinstate</a>
			</font>
		<cfelse>
			Active :: <a href="qManagementChain_Status.cfm?ID=#ID#&Action=Remove">Remove</a>
		</cfif>
	</td>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->