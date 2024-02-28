<cfsavecontent variable="output">
	<cfcontent type="application/msexcel">
	<cfcontent type="text/html">
	
<cfif NOT isDefined("URL.Year")>
	<cfset URL.Year = #curyear#>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPDATA" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT xSNAPData.AuditYear, xSNAPData.AuditID, xSNAPData.FunctionType, xSNAPData.FunctionType2, xSNAPData.CARs, xSNAPData.AuditOfficeNameID, Corporate.IQAtblOffices.OfficeName, xSNAPData.ID, xSNAPData.ID, xSNAPData.ProgramCompliance, xSNAPData.TCPQualification, xSNAPData.WTDPCompliance

FROM xSNAPData, Corporate.IQAtblOffices

WHERE xSNAPData.AuditOfficeNameID = Corporate.IQAtblOffices.ID
AND xSNAPData.FunctionType = 'Qualification'
AND xSNAPData.Status = 'Complete'
AND xSNAPData.AuditYear = #URL.Year#

ORDER BY Corporate.IQAtblOffices.OfficeName, xSNAPData.FunctionType2, xSNAPData.AuditID
</cfquery>

<table border="1">
<tr class="blog-title">
	<td colspan="5" align="center">Qualification</td>
</tr>
<tr align="center" class="blog-title">
	<td>Office Name</td>
	<td>Program</td>
	<td>Audit Number</td>
	<td>Program Compliance</td>
	<td>CARs</td>
</tr>
<cfoutput query="SNAPData">
<cfset OutputCARs = ReReplaceNoCase(#CARs#, "<[^>]*>", "", "ALL")>

<cfif OutputCARs neq "None" and OutputCARs neq "NA" and OutputCARs neq "N/A" and OutputCARs neq "None." AND OutputCARs neq "Nonr">
<tr class="blog-content" valign="top">
	<td>#OfficeName#</td>
	<td>#FunctionType2#</td>
	<td>#AuditYear#-#AuditID#</td>
	<td>
	<cfif FunctionType eq "Qualification">
		<cfif FunctionType2 eq "TCP">
			#TCPQualification#
		<cfelseif FunctionType2 eq "WTDP">
			#WTDPCompliance#
		</cfif>
	<cfelseif FunctionType eq "Data Acceptance">
	#ProgramCompliance#
	</cfif>
	</td>
	<td>#OutputCARs#</td>
</tr>
</cfif>
</cfoutput>
</tr>
</table>
<br><Br>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPDATA" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT xSNAPData.AuditYear, xSNAPData.AuditID, xSNAPData.FunctionType, xSNAPData.FunctionType2, xSNAPData.CARs, xSNAPData.AuditOfficeNameID, Corporate.IQAtblOffices.OfficeName, xSNAPData.ID, xSNAPData.ID, xSNAPData.ProgramCompliance, xSNAPData.TCPQualification, xSNAPData.WTDPCompliance

FROM xSNAPData, Corporate.IQAtblOffices

WHERE xSNAPData.AuditOfficeNameID = Corporate.IQAtblOffices.ID
AND xSNAPData.FunctionType = 'Data Acceptance'
AND xSNAPData.Status = 'Complete'
AND xSNAPData.AuditYear = #URL.Year#

ORDER BY Corporate.IQAtblOffices.OfficeName, xSNAPData.FunctionType2, xSNAPData.AuditID
</cfquery>

<table border="1">
<tr class="blog-title">
	<td colspan="5" align="center">Data Acceptance</td>
</tr>
<tr align="center" class="blog-title">
	<td>Office Name</td>
	<td>Program</td>
	<td>Audit Number</td>
	<td>Program Compliance</td>
	<td>CARs</td>
</tr>
<cfoutput query="SNAPData">
<cfset OutputCARs = ReReplaceNoCase(#CARs#, "<[^>]*>", "", "ALL")>

<cfif OutputCARs neq "None" and OutputCARs neq "NA" and OutputCARs neq "N/A" and OutputCARs neq "None." AND OutputCARs neq "Nonr">
<tr class="blog-content" valign="top">
	<td>#OfficeName#</td>
	<td>#FunctionType2#</td>
	<td>#AuditYear#-#AuditID#</td>
	<td>
	<cfif FunctionType eq "Qualification">
		<cfif FunctionType2 eq "TCP">
			#TCPQualification#
		<cfelseif FunctionType2 eq "WTDP">
			#WTDPCompliance#
		</cfif>
	<cfelseif FunctionType eq "Data Acceptance">
	#ProgramCompliance#
	</cfif>
	</td>
	<td>#OutputCARs#</td>
</tr>
</cfif>
</cfoutput>
</tr>
</table>

<cfheader name="Content-Disposition" value="attachment; filename=Test.xls">
</cfsavecontent>

<cfoutput>#output#</cfoutput>