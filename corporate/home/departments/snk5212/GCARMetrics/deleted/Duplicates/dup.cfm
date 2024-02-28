<cfif isDefined("URL.var") AND NOT isDefined("URL.var2")>
	<cfif url.var eq "docID">
		<CFQUERY BLOCKFACTOR="100" NAME="DocID" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT docID, COUNT(docID) AS count
		FROM GCAR_Metrics_Check
		GROUP BY docID
		HAVING (COUNT(docID) > 1) 
		ORDER BY docID
		</cfquery>
		
	<table border="1">
		<tr>
			<td colspan="2" align="center"><strong>Duplicate docIDs</strong></td>
		</tr>
		<cfoutput query="DocID">
			<tr>
				<td>#docID#</td>
				<td>#count#</td>
			</tr>
		</cfoutput>
		</table>
	</cfif>

	<cfif url.var eq "CARNumber">
		<CFQUERY BLOCKFACTOR="100" NAME="DocID" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT CARNumber, COUNT(CARNumber) AS count
		FROM GCAR_Metrics_Check
		GROUP BY CARNumber
		HAVING (COUNT(CARNumber) > 1)
		ORDER BY CARNumber 
		</cfquery>
		
	<table border="1">
		<tr>
			<td colspan="2" align="center"><strong>Duplicate CAR Numbers</strong></td>
		</tr>
		<cfoutput query="DocID">
			<tr>
				<td>#CARNumber#</td>
				<td>#count#</td>
			</tr>
		</cfoutput>
		</table>
	</cfif>
<cfelseif isDefined("URL.var") AND isDefined("URL.var2")>
	<CFQUERY BLOCKFACTOR="100" NAME="DocID" DataSource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT CARNumber, docID
	FROM GCAR_Metrics_Check
	WHERE docID IN (
		SELECT docID
		FROM GCAR_Metrics_Check
		GROUP BY docID
		HAVING (COUNT(docID) > 1))
	ORDER BY CARNumber
	</cfquery>
	
	<table border="1">
		<tr>
			<td colspan="2" align="center"><strong>Duplicate CAR Numbers AND docIDs</strong></td>
		</tr>
	<cfoutput query="DocID">
		<tr>
			<td>#docID#</td>
			<td>#CARNumber#</td>
		</tr>
	</cfoutput>
	</table>
</cfif>