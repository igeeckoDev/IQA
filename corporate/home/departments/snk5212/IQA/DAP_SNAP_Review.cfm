<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
SELECT OfficeName FROM IQAtblOffices
WHERE ID = #URL.OfficeID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT Month FROM AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="SNAP Data (Review) - #URL.Year#-#URL.ID#-IQA: #Office.OfficeName#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="Records" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="RecordsComplete" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND Status = 'Complete'
</cfquery>

<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
<!--- change this to 8 after PPP is added to report --->
	<cfset RecordQuantity = 8>
<cfelse>
	<cfset RecordQuantity = 7>
</cfif>

<cfoutput>
	<cfif Records.RecordCount eq RecordQuantity AND RecordsComplete.RecordCount eq RecordQuantity>
		<b>OSHA SNAP Data Status - <u><font color="red">Complete</font></u></b><br>
	<cfelseif Records.RecordCount eq RecordQuantity AND RecordsComplete.RecordCount lt RecordQuantity>
		<b>OSHA SNAP Data Status - <u><font color="red">Incomplete</font></u></b><br>
	<cfelseif Records.RecordCount LT RecordQuantity>
		<b>OSHA SNAP Data Status - <u><font color="red">Not All Records Added</font></u></b>
	</cfif>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataWTDP" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Qualification'
AND FunctionType2 = 'WTDP'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataTCP" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Qualification'
AND FunctionType2 = 'TCP'
</cfquery>

<cfoutput>
<br>
<b>Function 1 - Qualification</b><br>
</cfoutput>

<table border="1" class="blog-content">
<tr align="center" class="blog-title">
	<td width="200">Category</td>
	<td width="200">WTDP</td>
	<td width="200">TCP</td>
</tr>
<cfoutput>
<tr class="blog-content" valign="top">
	<td>WTDP Compliance</td>
	<td>#ReviewDataWTDP.WTDPCompliance#</td>
	<td>#ReviewDataTCP.WTDPCompliance#</td>
</tr>
<tr class="blog-content" valign="top">
	<td>TCP Qualification</td>
	<td>#ReviewDataWTDP.TCPQualification#</td>
	<td>#ReviewDataTCP.TCPQualification#</td>
</tr>
<tr class="blog-content" valign="top">
	<td>Projects Reviewed</td>
	<td>#replace(ReviewDataWTDP.ProjectsReviewed, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataTCP.ProjectsReviewed, ",", "<br>", "All")#</td>
</tr>
<tr class="blog-content" valign="top">
	<td>Compliance to:<Br>UL's Data Reporting and Recording Requirements (WTDP)<Br>00-OP-C0025 (TCP)</td>
	<td>#ReviewDataWTDP.ComplianceTo00LCS0258#</td>
	<td>#ReviewDataTCP.ComplianceTo00LCS0258#</td>
</tr>
<tr class="blog-content" valign="top">
	<td>L2 Competency</td>
	<td>#ReviewDataWTDP.L2Competency#</td>
	<td>#ReviewDataTCP.L2Competency#</td>
</tr>
<tr class="blog-content" valign="top">
	<td>L2 Employee Number</td>
	<td>#ReviewDataWTDP.L2EmpNo#</td>
	<td>#ReviewDataTCP.L2EmpNo#</td>
</tr>
<tr class="blog-content" valign="top">
	<td>L2 - Current Employee?</td>
	<td><cfif len(ReviewDataWTDP.L2EmpStatus)>#ReviewDataWTDP.L2EmpStatus#<cfelse>NA</cfif></td>
	<td><cfif len(ReviewDataTCP.L2EmpStatus)>#ReviewDataTCP.L2EmpStatus#<cfelse>NA</cfif></td>
</tr>
<tr class="blog-content" valign="top">
	<td>Records Compliance</td>
	<td>#ReviewDataWTDP.RecordsCompliance#</td>
	<td>#ReviewDataTCP.RecordsCompliance#</td>
</tr>
<tr class="blog-content" valign="top">
	<td>CARs</td>
	<td>#replace(ReviewDataWTDP.CARs, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataTCP.CARs, ",", "<br>", "All")#</td>
</tr>
<tr class="blog-content" valign="top">
	<td>Notes</td>
	<td>
	<cfset Dump = #replace(ReviewDataWTDP.Notes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
		<cfif len(Dump2)>
		#Dump2#
		<cfelse>
		None
		</cfif>
	</td>
	<td>
	<cfset Dump = #replace(ReviewDataTCP.Notes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
		<cfif len(Dump2)>
		#Dump2#
		<cfelse>
		None
		</cfif>
	</td>
</tr>
</cfoutput>
</table>

<br><Br>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataTPTDP" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Data Acceptance'
AND FunctionType2 = 'TPTDP'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataWTDP" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Data Acceptance'
AND FunctionType2 = 'WTDP'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataCTDP" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Data Acceptance'
AND FunctionType2 = 'CTDP'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataTCP" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Data Acceptance'
AND FunctionType2 = 'TCP'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataCBScheme" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Data Acceptance'
AND FunctionType2 = 'CB Scheme'
</cfquery>

<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataPPP" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * FROM xSNAPData
	WHERE AuditID = #URL.ID#
	AND AuditYear = #URL.Year#
	AND AuditOfficeNameID = #URL.OfficeID#
	AND FunctionType = 'Data Acceptance'
	AND FunctionType2 = 'PPP'
	</cfquery>
</cfif>

<cfoutput>
<b>Function 2 - Data Acceptance</b><br>
</cfoutput>

<table border="1" class="blog-content">
<tr align="center" class="blog-title">
	<td width="150">Category</td>
	<td>TPTDP</td>
	<td>WTDP</td>
	<td>CTDP</td>
	<td>TCP</td>
	<td>CB Scheme</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>PPP</td>
	</cfif>
</tr>
<cfoutput>
<tr class="blog-content" valign="top">
	<td>Program Compliance</td>
	<td>#ReviewDataTPTDP.ProgramCompliance#</td>
	<td>#ReviewDataWTDP.ProgramCompliance#</td>
	<td>#ReviewDataCTDP.ProgramCompliance#</td>
	<td>#ReviewDataTCP.ProgramCompliance#</td>
	<td>#ReviewDataCBScheme.ProgramCompliance#</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#ReviewDataPPP.ProgramCompliance#</td>
	</cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>Projects Reviewed</td>
	<td>#replace(ReviewDataTPTDP.ProjectsReviewed, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataWTDP.ProjectsReviewed, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataCTDP.ProjectsReviewed, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataTCP.ProjectsReviewed, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataCBScheme.ProjectsReviewed, ",", "<br>", "All")#</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#replace(ReviewDataPPP.ProjectsReviewed, ",", "<br>", "All")#</td>
	</cfif>
</tr>
<!--- Combined with Program Compliance. Duplicate Info
<tr class="blog-content" valign="top">
	<td>CB Scheme Compliance</td>
	<td>#ReviewDataTPTDP.CBSchemeCompliance#</td>
	<td>#ReviewDataWTDP.CBSchemeCompliance#</td>
	<td>#ReviewDataCTDP.CBSchemeCompliance#</td>
	<td>#ReviewDataTCP.CBSchemeCompliance#</td>
	<td>#ReviewDataCBScheme.CBSchemeCompliance#</td>
</tr>
--->
<tr class="blog-content" valign="top">
	<td>Compliance to:<Br>UL's Data Reporting and Recording Requirements (WTDP)<Br>00-OP-C0025 (Others)</td>
	<td>#ReviewDataTPTDP.Complianceto00LCS0258#</td>
	<td>#ReviewDataWTDP.Complianceto00LCS0258#</td>
	<td>#ReviewDataCTDP.Complianceto00LCS0258#</td>
	<td>#ReviewDataTCP.Complianceto00LCS0258#</td>
	<td>#ReviewDataCBScheme.Complianceto00LCS0258#</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#ReviewDataPPP.Complianceto00LCS0258#</td>
	</cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>L2 Competency</td>
	<td>#ReviewDataTPTDP.L2Competency#</td>
	<td>#ReviewDataWTDP.L2Competency#</td>
	<td>#ReviewDataCTDP.L2Competency#</td>
	<td>#ReviewDataTCP.L2Competency#</td>
	<td>#ReviewDataCBScheme.L2Competency#</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#ReviewDataPPP.L2Competency#</td>
	</cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>L2 Employee Number</td>
	<td>#ReviewDataTPTDP.L2EmpNo#</td>
	<td>#ReviewDataWTDP.L2EmpNo#</td>
	<td>#ReviewDataCTDP.L2EmpNo#</td>
	<td>#ReviewDataTCP.L2EmpNo#</td>
	<td>#ReviewDataCBScheme.L2EmpNo#</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#ReviewDataPPP.L2EmpNo#</td>
	</cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>L2 - Current Employee?</td>
	<td>#ReviewDataTPTDP.L2EmpStatus#</td>
	<td>#ReviewDataWTDP.L2EmpStatus#</td>
	<td>#ReviewDataCTDP.L2EmpStatus#</td>
	<td>#ReviewDataTCP.L2EmpStatus#</td>
	<td>#ReviewDataCBScheme.L2EmpStatus#</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#ReviewDataPPP.L2EmpStatus#</td>
	</cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>Signatory Signature</td>
	<td>#ReviewDataTPTDP.SignatorySignature#</td>
	<td>NA</td>
	<td>#ReviewDataCTDP.SignatorySignature#</td>
	<td>#ReviewDataTCP.SignatorySignature#</td>
	<td>NA</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#ReviewDataPPP.SignatorySignature#</td>
	</cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>DAP Assessment/Scope</td>
	<td>#ReviewDataTPTDP.DAPAssessmentScope#</td>
	<td>#ReviewDataWTDP.DAPAssessmentScope#</td>
	<td>#ReviewDataCTDP.DAPAssessmentScope#</td>
	<td>#ReviewDataTCP.DAPAssessmentScope#</td>
	<td>#ReviewDataCBScheme.DAPAssessmentScope#</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#ReviewDataPPP.DAPAssessmentScope#</td>
	</cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>Records Compliance</td>
	<td>#ReviewDataTPTDP.RecordsCompliance#</td>
	<td>#ReviewDataWTDP.RecordsCompliance#</td>
	<td>#ReviewDataCTDP.RecordsCompliance#</td>
	<td>#ReviewDataTCP.RecordsCompliance#</td>
	<td>#ReviewDataCBScheme.RecordsCompliance#</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#ReviewDataPPP.RecordsCompliance#</td>
	</cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>CARs</td>
	<td>#replace(ReviewDataTPTDP.CARs, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataWTDP.CARs, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataCTDP.CARs, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataTCP.CARs, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataCBScheme.CARs, ",", "<br>", "All")#</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>#replace(ReviewDataPPP.CARs, ",", "<br>", "All")#</td>
	</cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>Notes</td>
	<td>
	<cfset Dump = #replace(ReviewDataTPTDP.Notes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
		<cfif len(Dump2)>
		#Dump2#
		<cfelse>
		None
		</cfif>
	</td>
	<td>
	<cfset Dump = #replace(ReviewDataWTDP.Notes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
		<cfif len(Dump2)>
		#Dump2#
		<cfelse>
		None
		</cfif>
	</td>
	<td>
	<cfset Dump = #replace(ReviewDataCTDP.Notes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
		<cfif len(Dump2)>
		#Dump2#
		<cfelse>
		None
		</cfif>
	</td>
	<td>
	<cfset Dump = #replace(ReviewDataTCP.Notes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
		<cfif len(Dump2)>
		#Dump2#
		<cfelse>
		None
		</cfif>
	</td>
	<td>
	<cfset Dump = #replace(ReviewDataCBScheme.Notes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
		<cfif len(Dump2)>
		#Dump2#
		<cfelse>
		None
		</cfif>
	</td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td>
	<cfset Dump = #replace(ReviewDataPPP.Notes, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
		<cfif len(Dump2)>
		#Dump2#
		<cfelse>
		None
		</cfif>
	</td>
	</cfif>
</tr>
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->