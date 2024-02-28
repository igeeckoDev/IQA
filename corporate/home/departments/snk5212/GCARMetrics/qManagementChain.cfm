<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>GCAR Report - Exclude from Management Escalation Chain</b>

<cflock scope="Session" timeout="5">
	<cfif isDefined("SESSION.Auth.IsLoggedInApp") AND SESSION.Auth.IsLoggedInApp eq "#this.name#"
		AND isDefined("SESSION.Auth.IsLoggedIn") AND SESSION.Auth.IsLoggedIn eq "Yes">
	 :: <a href="qManagementChain_Modify.cfm">Modify List</a>
	</cfif>
</cflock><br><br>

<cfquery name="qGetNames" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT *
FROM GCAR_METRICS_ManagementChain
WHERE STATUS IS NULL
ORDER BY Name
</cfquery>

<table border=1>
<tr>
	<th>Name</th>
	<th>Quantity</th>
	<th>CAR Details</th>
</tr>
<cfloop query="qGetNames">
<tr valign=top>
	<cfoutput>
		<td>#Name#</td>
	</cfoutput>

	<cfquery name="qResults" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT CARNumber, docID, CARState, CARAdministrator
	FROM GCAR_Metrics
	WHERE (UPPER(CAROwnersManager) = UPPER('#Name#')
	OR UPPER(CAROwners2ndLevelManager) = UPPER('#Name#')
	OR UPPER(CAROwners3rdLevelManager) = UPPER('#Name#')
	OR UPPER(CAROwners4thLevelManager) = UPPER('#Name#'))
	AND (CARState <> 'Closed-Awaiting Verification'
	AND CARState <> 'Closed - Verified as Effective'
	AND CARState <> 'Closed - Verified as Ineffective')
	ORDER BY CARNumber, docID
	</cfquery>

	<cfif qResults.recordCount GT 0>
		<cfoutput>
			<td align=center>#qResults.recordCount#</td>
		</cfoutput>

		<td>
			<cfoutput query="qResults">
				<u>Number</u>: <a href="#Request.GCARLink##docID#">#CARNumber#</a><br>
				<u>State</u>: #CARState#<br>
				<u>CAR Champion</u>: #replace(CARAdministrator, "|", "<br>", "All")#<Br><br>
			</cfoutput>
		</td>
	<cfelseif qResults.recordCount EQ 0 OR NOT len(qResults.recordCount)>
		<td align=center>--</td>
		<td align=center>--</td>
	</cfif>
</tr>
</cfloop>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->