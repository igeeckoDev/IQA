<cfif NOT isDefined("URL.Year")>
	<cfset URL.Year = #curyear#>
</cfif>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="OSHA SNAP Data - #URL.Year#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
<cfset firstyear = 2010>
<cfset prevYear = #url.year# - 1>
<cfset nxtYear = #url.year# + 1>
<cfset twoYear = #url.year# + 2>

Select Year: 
<cfif url.year is #firstyear#>
<b>#url.year#</b> <a href="DAP_SNAP_Data.cfm?Year=#nxtYear#">[ #nxtyear# ]</a> <!---<a href="DAP_SNAP_Data.cfm?Year=#twoYear#">[ #twoYear# ]</a>--->
<cfelse>
<a href="DAP_SNAP_Data.cfm?Year=#prevYear#">[ #prevyear# ]</a> <b>#url.year#</b> <!---<a href="DAP_SNAP_Data.cfm?Year=#nextYear#">[ #nxtyear# ]</a>--->
</cfif><br /><br />

<b><a href="DAP_SNAP_Data_xls.cfm?Year=#URL.Year#">Output</a></b> data table to Excel<br><br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="SNAPDATA" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT xSNAPData.AuditYear, xSNAPData.AuditID, xSNAPData.FunctionType, xSNAPData.FunctionType2, xSNAPData.CARs, xSNAPData.AuditOfficeNameID, Corporate.IQAtblOffices.OfficeName, xSNAPData.ID, xSNAPData.ID, xSNAPData.ProgramCompliance, xSNAPData.TCPQualification, xSNAPData.WTDPCompliance

FROM xSNAPData, Corporate.IQAtblOffices

WHERE xSNAPData.AuditOfficeNameID = Corporate.IQAtblOffices.ID
AND xSNAPData.FunctionType = 'Qualification'
AND xSNAPData.Status = 'Complete'
AND xSNAPData.AuditYear = #URL.Year#

ORDER BY Corporate.IQAtblOffices.OfficeName, xSNAPData.FunctionType2, xSNAPData.AuditID
</cfquery>

<cfif SNAPData.RecordCount GT 0>
<table border="1">
<tr class="blog-title">
	<td colspan="6" align="center">Qualification</td>
</tr>
<tr align="center" class="blog-title">
	<td>Program</td>
	<td>Audit Number</td>
	<td>Office Name</td>
	<td>Program Compliance</td>
	<td>CARs</td>
	<td>View OSHA SNAP Record</td>
</tr>
<cfoutput query="SNAPData">
<cfset OutputCARs = ReReplaceNoCase(#CARs#, "<[^>]*>", "", "ALL")>

<cfif OutputCARs neq "None" and OutputCARs neq "NA" and OutputCARs neq "N/A" and OutputCARs neq "None." AND OutputCARs neq "Nonr">
<tr class="blog-content">
	<td>#FunctionType2#</td>
	<td>#AuditYear#-#AuditID#</td>
	<td>#OfficeName#</td>
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
	<td align="center"><a href="DAP_SNAP_Review.cfm?ID=#AuditID#&Year=#AuditYear#&OfficeID=#AuditOfficeNameID#">View</a></td>
</tr>
</cfif>
</cfoutput>
</tr>
</table>
<cfelse>
	<cfoutput>
		There are no Qualification records for #URL.Year#.
	</cfoutput>
</cfif>
<br><Br>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046"  username="#OracleDB_Username#" password="#OracleDB_Password#" NAME="SNAPDATA">
SELECT xSNAPData.AuditYear, xSNAPData.AuditID, xSNAPData.FunctionType, xSNAPData.FunctionType2, xSNAPData.CARs, xSNAPData.AuditOfficeNameID, Corporate.IQAtblOffices.OfficeName, xSNAPData.ID, xSNAPData.ID, xSNAPData.ProgramCompliance, xSNAPData.TCPQualification, xSNAPData.WTDPCompliance

FROM xSNAPData, Corporate.IQAtblOffices

WHERE xSNAPData.AuditOfficeNameID = Corporate.IQAtblOffices.ID
AND xSNAPData.FunctionType = 'Data Acceptance'
AND xSNAPData.Status = 'Complete'
AND xSNAPData.AuditYear = #URL.Year#

ORDER BY Corporate.IQAtblOffices.OfficeName, xSNAPData.FunctionType2, xSNAPData.AuditID
</cfquery>

<cfif SNAPData.RecordCount GT 0>
<table border="1">
<tr class="blog-title">
	<td colspan="6" align="center">Data Acceptance</td>
</tr>
<tr align="center" class="blog-title">
	<td>Program</td>
	<td>Audit Number</td>
	<td>Office Name</td>
	<td>Program Compliance</td>
	<td>CARs</td>
	<td>View OSHA SNAP Record</td>
</tr>
<cfoutput query="SNAPData">
<cfset OutputCARs = ReReplaceNoCase(#CARs#, "<[^>]*>", "", "ALL")>

<cfif OutputCARs neq "None" and OutputCARs neq "NA" and OutputCARs neq "N/A" and OutputCARs neq "None." AND OutputCARs neq "Nonr">
<tr class="blog-content">
	<td>#FunctionType2#</td>
	<td>#AuditYear#-#AuditID#</td>
	<td>#OfficeName#</td>
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
	<td align="center"><a href="DAP_SNAP_Review.cfm?ID=#AuditID#&Year=#AuditYear#&OfficeID=#AuditOfficeNameID#">View</a></td>
</tr>
</cfif>
</cfoutput>
</tr>
</table>
<cfelse>
	<cfoutput>
		There are no Data Acceptance records for #URL.Year#.
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->