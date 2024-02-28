<!--- Start of Page File --->
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<b>GCAR Report - Observations - Root Cause Categories</b><Br><br>

<cfquery name="qResults" datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT CARNumber, docID, CARState, CARAdministrator
FROM GCAR_Metrics
WHERE CARFindOrObservation = 'Observation'
AND CARRootCauseCategory <> 'Root Cause not Required'
AND (CARState <> 'Closed-Awaiting Verification'
AND CARState <> 'Closed - Verified as Effective'
AND CARState <> 'Closed - Verified as Ineffective'
AND CARState <> 'Awaiting Response'
AND CARState <> 'Response Overdue'
AND CARState <> 'Response Escalated'
AND CARState <> 'Response Escalated 2'
AND CARState <> 'Response Escalated 3'
AND CARState <> 'Response Manual Escalation'
AND CARState <> 'Received Response'
AND CARState <> 'Pending Response Date Extension'
AND CARState <> 'Pending Response Date Extension (Corporate)')
ORDER BY CARNumber, docID
</cfquery>

<cfif qResults.RecordCount GT 0>
	<table border=1>
	<tr>
		<th>CAR Details</th>
	</tr>
	<cfoutput query="qResults">
		<tr valign=top>
			<td><a href="#Request.GCARLink##docID#">#CARNumber#</a><br>
				#CARState#<br>
				#replace(CARAdministrator, "|", "<br>", "All")#<Br><br>
			</td>
		</tr>
	</cfoutput>
	</table>
<cfelse>
	No CARs Found
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->