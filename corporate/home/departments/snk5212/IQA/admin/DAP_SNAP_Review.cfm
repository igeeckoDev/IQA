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

<cfif isDefined("URL.Validate") AND isDefined("URL.msg") AND isDefined("URL.rowID")>
<font color="red"><b>Validation Error</b></font><br>
	<cfoutput>
		<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ErrorRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
		SELECT * FROM xSNAPData
		WHERE ID = #URL.rowID#
		</cfquery>
	<u>Function/Program</u> - #ErrorRow.FunctionType# / #ErrorRow.FunctionType2#<br>
	<u>Field</u> - #URL.Validate#: #URL.msg#<br><br>

	Corrections are necessary before these records can be Completed. There may be additional errors, please check to ensure Employee Numbers are accurate and Project Numbers are included when necessary. If you are sure the employee number is valid, please contact Kai Huang to complete the record.<br><br>

	<cfif url.msg eq "Invalid Employee Number" AND url.validate eq "L2 Employee Number">
		<cflock scope="Session" timeout="5">
			<cfif SESSION.Auth.Username eq "Chris"
				OR SESSION.Auth.Username eq "CJones"
				OR SESSION.Auth.Username eq "Huang">

				<b>Note</b> - if the L2 Employee is an active employee but the validation is sending an error, click this link to complete the SNAP Record:
				<a href="DAP_SNAP_Complete.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#URL.OfficeID#&Complete=Yes">Complete DAP SNAP Record</a><br>
				(Option only available to Chris, Cliff, Kai)
				<br><br>
			</cfif>
		</cflock>
	</cfif>

	</cfoutput>
</cfif>

<cfif URL.Year gte 2011>
	<cfset RecordQuantity = 9>
<cfelseif URL.Year eq 2010>
	<cfif Audit.Month gte 9>
		<cfset RecordQuantity = 8>
	<cfelseif Audit.Month lt 9>
    	<cfset RecordQuantity = 7>
	</cfif>
</cfif>

<cfoutput>
	<cfif Records.RecordCount eq RecordQuantity AND RecordsComplete.RecordCount eq RecordQuantity>
		<b>OSHA SNAP Data Status - <u><font color="red">Complete</font></u></b><br>
		Due Date: #dateformat(Records.DueDate, "mm/dd/yyyy")#<br>
		Completed Date: #dateformat(Records.CompletedDate, "mm/dd/yyyy")#<br><br>

		Data is no longer editable. Please contact Kai Huang if a correction is required.
	<cfelseif Records.RecordCount eq RecordQuantity AND RecordsComplete.RecordCount lt RecordQuantity>
		<b>OSHA SNAP Data Status - <u><font color="red">Incomplete</font></u></b><br>
		When you have entered and verified all information, please click the link to
        <cfif URL.Year LT 2014>
        	<a href="DAP_SNAP_Validate.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#URL.OfficeID#"><b>Complete</b></a>.
        <cfelseif URL.Year GTE 2014>
        	<a href="DAP_SNAP_Validate_2014.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#URL.OfficeID#"><b>Complete</b></a>.
        </cfif>
        Once you have done this, your data will finalized and you will not be able to edit any longer.
	<cfelseif Records.RecordCount LT RecordQuantity>
		<b>OSHA SNAP Data Status - <u><font color="red">Not All Records Added</font></u></b>
	</cfif><Br>
</cfoutput>

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
AND FunctionType = 'Qualification'
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
AND FunctionType = 'Qualification'
AND FunctionType2 = 'TCP'
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataPPP" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Qualification'
AND FunctionType2 = 'PPP'
</cfquery>

<cfoutput>
<br>
<b>Function 1 - Qualification</b><br>
</cfoutput>

<table border="1" class="blog-content" style="border-collapse: collapse;">
<tr align="center" class="blog-title">
	<td width="200">Category</td>
	<td width="200">TPTDP</td>
	<td width="200">WTDP</td>
	<td width="200">CTDP</td>
	<td width="200">TCP</td>
    <cfif URL.Year gte 2011>
	<td width="200">PPP</td>
	</cfif>
</tr>
<cfoutput>
<cfif URL.Year LT 2014>
    <tr class="blog-content" valign="top">
        <td>WTDP Compliance</td>
		<td>#ReviewDataTPTDP.WTDPCompliance#</td>
        <td>#ReviewDataWTDP.WTDPCompliance#</td>
		<td>#ReviewDataCTDP.WTDPCompliance#</td>
        <td>#ReviewDataTCP.WTDPCompliance#</td>
        <cfif URL.Year gte 2011>
        <td>#ReviewDataPPP.WTDPCompliance#</td>
        </cfif>
    </tr>
    <tr class="blog-content" valign="top">
        <td>TCP / PPP Qualification</td>
		<td>#ReviewDataTPTDP.TCPQualification#</td>
        <td>#ReviewDataWTDP.TCPQualification#</td>
		<td>#ReviewDataCTDP.TCPQualification#</td>
        <td>#ReviewDataTCP.TCPQualification#</td>
        <cfif URL.Year gte 2011>
        <td>#ReviewDataPPP.TCPQualification#</td>
        </cfif>
    </tr>
<cfelseif URL.Year GTE 2014>
    <tr class="blog-content" valign="top">
        <td>Program Compliance/Qualification</td>
		<td>#ReviewDataTPTDP.ProgramCompliance#</td>		
        <td>#ReviewDataWTDP.ProgramCompliance#</td>
		<td>#ReviewDataCTDP.ProgramCompliance#</td>
        <td>#ReviewDataTCP.ProgramCompliance#</td>
        <cfif URL.Year gte 2011>
        <td>#ReviewDataPPP.ProgramCompliance#</td>
        </cfif>
    </tr>
</cfif>
<tr class="blog-content" valign="top">
	<td>Projects Reviewed</td>
	<td>#replace(ReviewDataTPTDP.ProjectsReviewed, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataWTDP.ProjectsReviewed, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataCTDP.ProjectsReviewed, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataTCP.ProjectsReviewed, ",", "<br>", "All")#</td>
    <cfif URL.Year gte 2011>
    <td>#replace(ReviewDataPPP.ProjectsReviewed, ",", "<br>", "All")#</td>
    </cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>Compliance to:<Br>UL's Data Reporting and Recording Requirements (WTDP)<Br>00-OP-C0025 (Others)</td>
	<td>#ReviewDataTPTDP.ComplianceTo00LCS0258#</td>
	<td>#ReviewDataWTDP.ComplianceTo00LCS0258#</td>
	<td>#ReviewDataCTDP.ComplianceTo00LCS0258#</td>
	<td>#ReviewDataTCP.ComplianceTo00LCS0258#</td>
    <cfif URL.Year gte 2011>
    <td>#ReviewDataPPP.ComplianceTo00LCS0258#</td>
    </cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>L2 Competency</td>
	<td>#ReviewDataTPTDP.L2Competency#</td>
	<td>#ReviewDataWTDP.L2Competency#</td>
	<td>#ReviewDataCTDP.L2Competency#</td>
	<td>#ReviewDataTCP.L2Competency#</td>
    <cfif URL.Year gte 2011>
    <td>#ReviewDataPPP.L2Competency#</td>
    </cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>L2 Employee Number</td>
	<td><cfif ReviewDataTPTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataTPTDP.L2EmpNo#</cfif></td>
	<td><cfif ReviewDataWTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataWTDP.L2EmpNo#</cfif></td>
	<td><cfif ReviewDataCTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataCTDP.L2EmpNo#</cfif></td>
	<td><cfif ReviewDataTCP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataTCP.L2EmpNo#</cfif></td>
    <cfif URL.Year gte 2011>
    <td><cfif ReviewDataPPP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataPPP.L2EmpNo#</cfif></td>
    </cfif>
</tr>
<!--- change value to N/A if Employee number = 00000 --->
<tr class="blog-content" valign="top">
	<td>L2 - Current Employee?</td>
	<td><cfif ReviewDataTPTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataWTDP.L2EmpStatus#</cfif></td>
	<td><cfif ReviewDataWTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataWTDP.L2EmpStatus#</cfif></td>
	<td><cfif ReviewDataCTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataWTDP.L2EmpStatus#</cfif></td>
	<td><cfif ReviewDataTCP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataTCP.L2EmpStatus#</cfif></td>
    <cfif URL.Year gte 2011>
    <td><cfif ReviewDataPPP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataPPP.L2EmpStatus#</cfif></td>
    </cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>Records Compliance</td>
	<td>#ReviewDataTPTDP.RecordsCompliance#</td>
	<td>#ReviewDataWTDP.RecordsCompliance#</td>
	<td>#ReviewDataCTDP.RecordsCompliance#</td>
	<td>#ReviewDataTCP.RecordsCompliance#</td>
    <cfif URL.Year gte 2011>
    <td>#ReviewDataPPP.RecordsCompliance#</td>
    </cfif>
</tr>
<tr class="blog-content" valign="top">
	<td>CARs</td>
	<td>#replace(ReviewDataTPTDP.CARs, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataWTDP.CARs, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataCTDP.CARs, ",", "<br>", "All")#</td>
	<td>#replace(ReviewDataTCP.CARs, ",", "<br>", "All")#</td>
    <cfif URL.Year gte 2011>
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
    <cfif URL.Year gte 2011>
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
<!--- if the auditor is assigned (for DAP 1 and DAP 2 audits) --->
<cfif len(Records.AssignedTo)>
    <!--- Show edit for assigned auditor (Records.AssignedTo) as well as SU access level and Cliff Jones --->
    <cflock scope="SESSION" timeout="5">
        <cfif SESSION.Auth.UserName eq "CJones" 
			OR SESSION.Auth.AccessLevel eq "Huang" 
			OR SESSION.Auth.AccessLevel eq "SU" 
			OR SESSION.Auth.Name eq "#Records.AssignedTo#">

			<tr class="blog-content" valign="top" align="center">
                <td><b>Edit</b></td>
				<td>&nbsp;</td>
                <td><A href="DAP_SNAP_Edit.cfm?ID=#ReviewDataWTDP.ID#">Edit</A></td>
				<td>&nbsp;</td>
                <td><A href="DAP_SNAP_Edit.cfm?ID=#ReviewDataTCP.ID#">Edit</A></td>
                <cfif URL.Year gte 2011>
                <td><A href="DAP_SNAP_Edit.cfm?ID=#ReviewDataPPP.ID#">Edit</A></td>
                </cfif>
            </tr>
        </cfif>
    </cflock>
    <!--- /// --->
<cfelse>
    <tr class="blog-content" valign="top" align="center">
        <td><b>Edit</b></td>
		<td>&nbsp;</td>
        <td><A href="DAP_SNAP_Edit.cfm?ID=#ReviewDataWTDP.ID#">Edit</A></td>
        <td>&nbsp;</td>
		<td><A href="DAP_SNAP_Edit.cfm?ID=#ReviewDataTCP.ID#">Edit</A></td>
        <cfif URL.Year gte 2011>
        <td><A href="DAP_SNAP_Edit.cfm?ID=#ReviewDataPPP.ID#">Edit</A></td>
        </cfif>
    </tr>
</cfif>
<!--- /// --->
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

<cfif url.Year gte 2014>
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataWTDP" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * FROM xSNAPData
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND AuditOfficeNameID = #URL.OfficeID#
    AND FunctionType = 'Qualification'
    AND FunctionType2 = 'WTDP'
    </cfquery>
<cfelse>
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataWTDP" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * FROM xSNAPData
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND AuditOfficeNameID = #URL.OfficeID#
    AND FunctionType = 'Data Acceptance'
    AND FunctionType2 = 'WTDP'
    </cfquery>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataCTDP" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Data Acceptance'
AND FunctionType2 = 'CTDP'
</cfquery>

<cfif url.Year gte 2014>
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataTCP" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * FROM xSNAPData
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND AuditOfficeNameID = #URL.OfficeID#
    AND FunctionType = 'Qualification'
    AND FunctionType2 = 'TCP'
    </cfquery>
<cfelse>
    <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataTCP" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * FROM xSNAPData
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND AuditOfficeNameID = #URL.OfficeID#
    AND FunctionType = 'Data Acceptance'
    AND FunctionType2 = 'TCP'
    </cfquery>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataCBScheme" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE AuditID = #URL.ID#
AND AuditYear = #URL.Year#
AND AuditOfficeNameID = #URL.OfficeID#
AND FunctionType = 'Data Acceptance'
AND FunctionType2 = 'CB Scheme'
</cfquery>

<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<cfif url.Year gte 2014>
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataPPP" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM xSNAPData
        WHERE AuditID = #URL.ID#
        AND AuditYear = #URL.Year#
        AND AuditOfficeNameID = #URL.OfficeID#
        AND FunctionType = 'Qualification'
        AND FunctionType2 = 'PPP'
        </cfquery>
	<cfelse>
        <CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="ReviewDataPPP" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM xSNAPData
        WHERE AuditID = #URL.ID#
        AND AuditYear = #URL.Year#
        AND AuditOfficeNameID = #URL.OfficeID#
        AND FunctionType = 'Data Acceptance'
        AND FunctionType2 = 'PPP'
        </cfquery>
	</cfif>
</cfif>

<cfoutput>
<b>Function 2 - Data Acceptance</b><br>
</cfoutput>

<table border="1" class="blog-content" style="border-collapse: collapse;">
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
	<td><cfif ReviewDataTPTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataTPTDP.L2EmpNo#</cfif></td>
	<td><cfif ReviewDataWTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataWTDP.L2EmpNo#</cfif></td>
	<td><cfif ReviewDataCTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataCTDP.L2EmpNo#</cfif></td>
	<td><cfif ReviewDataTCP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataTCP.L2EmpNo#</cfif></td>
	<td><cfif ReviewDataCBScheme.L2EmpNo eq "00000">NA<cfelse>#ReviewDataCBScheme.L2EmpNo#</cfif></td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td><cfif ReviewDataPPP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataPPP.L2EmpNo#</cfif></td>
	</cfif>
</tr>
<!--- change value to N/A if Employee number = 00000 --->
<tr class="blog-content" valign="top">
	<td>L2 - Current Employee?</td>
	<td><cfif ReviewDataTPTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataTPTDP.L2EmpStatus#</cfif></td>
	<td><cfif ReviewDataWTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataWTDP.L2EmpStatus#</cfif></td>
	<td><cfif ReviewDataCTDP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataCTDP.L2EmpStatus#</cfif></td>
	<td><cfif ReviewDataTCP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataTCP.L2EmpStatus#</cfif></td>
	<td><cfif ReviewDataCBScheme.L2EmpNo eq "00000">NA<cfelse>#ReviewDataCBScheme.L2EmpStatus#</cfif></td>
	<cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
	<td><cfif ReviewDataPPP.L2EmpNo eq "00000">NA<cfelse>#ReviewDataPPP.L2EmpStatus#</cfif></td>
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

<!--- if the auditor is assigned (for DAP 1 and DAP 2 audits) --->
<cfif len(Records.AssignedTo)>
	<!--- Show edit for assigned auditor (Records.AssignedTo) as well as SU access level and Cliff Jones --->
    <cflock scope="SESSION" timeout="5">
        <cfif SESSION.Auth.UserName eq "CJones" 
			OR SESSION.Auth.UserName eq "Huang"
			OR SESSION.Auth.AccessLevel eq "SU" 
			OR SESSION.Auth.Name eq "#Records.AssignedTo#">
            			
			<cfset incString = "AuditOfficeNameID=#URL.OfficeID#&AuditID=#URL.ID#&AuditYear=#URL.Year#&FunctionType=Data Acceptance">
            <tr class="blog-content" valign="top" align="center">
                <td><b>Edit</b></td>
                <td>
					<cfif ReviewDataTPTDP.Recordcount eq 0>
                        <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=TPTDP">Edit</a>
                    <cfelse>
                        <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataTPTDP.ID#">Edit</a>
                    </cfif>
                </td>
                <td>
					<cfif URL.Year GTE 2014>
                	<!--- disable edit
                    <cfif ReviewDataWTDP.Recordcount eq 0>
                        <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=WTDP">Edit</a>
                    <cfelse>
                        <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataWTDP.ID#">Edit</a>
                    </cfif>
                    --->
                    &nbsp;
                    <cfelse>
						<cfif ReviewDataWTDP.Recordcount eq 0>
                            <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=WTDP">Edit</a>
                        <cfelse>
                            <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataWTDP.ID#">Edit</a>
                        </cfif>
                    </cfif>
                </td>
                <td>
                    <cfif ReviewDataCTDP.Recordcount eq 0>
                        <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=CTDP">Edit</a>
                    <cfelse>
                        <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataCTDP.ID#">Edit</a>
                    </cfif>
                </td>
                <td>
					<cfif URL.Year GTE 2014>
                	<!--- disable edit>
                    <cfif ReviewDataTCP.Recordcount eq 0>
                        <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=TCP">Edit</a>
                    <cfelse>
                        <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataTCP.ID#">Edit</a>
                    </cfif>
					--->
                    &nbsp;
					<cfelse>
						<cfif ReviewDataTCP.Recordcount eq 0>
                            <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=TCP">Edit</a>
                        <cfelse>
                            <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataTCP.ID#">Edit</a>
                        </cfif>
                    </cfif>
                </td>
                <td>
                    <cfif ReviewDataCBScheme.Recordcount eq 0>
                        <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=CB Scheme">Edit</a>
                    <cfelse>
                        <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataCBScheme.ID#">Edit</a>
                    </cfif>
                </td>
                <cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
                <td>
					<cfif URL.Year GTE 2014>
                    <!--- disable edit
                        <cfif ReviewDataPPP.Recordcount eq 0>
                            <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=PPP">Edit</a>
                        <cfelse>
                            <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataPPP.ID#">Edit</a>
                        </cfif>
                    --->
                    &nbsp;
                    <cfelse>
                        <cfif ReviewDataPPP.Recordcount eq 0>
                            <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=PPP">Edit</a>
                        <cfelse>
                            <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataPPP.ID#">Edit</a>
                        </cfif>
                    </cfif>
				</td>
                </cfif>
            </tr>
        </cfif>
    </cflock>
    <!--- /// --->
<cfelse>
	<cfset incString = "AuditOfficeNameID=#URL.OfficeID#&AuditID=#URL.ID#&AuditYear=#URL.Year#&FunctionType=Data Acceptance">
	<tr class="blog-content" valign="top" align="center">
        <td><b>Edit</b></td>
        <td>
            <cfif ReviewDataTPTDP.Recordcount eq 0>
                <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=TPTDP">Edit</a>
            <cfelse>
                <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataTPTDP.ID#">Edit</a>
            </cfif>
        </td>
        <td>
            <cfif URL.Year GTE 2014>
            <!--- disable edit
            <cfif ReviewDataWTDP.Recordcount eq 0>
                <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=WTDP">Edit</a>
            <cfelse>
                <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataWTDP.ID#">Edit</a>
            </cfif>
            --->
            &nbsp;
            <cfelse>
                <cfif ReviewDataWTDP.Recordcount eq 0>
                    <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=WTDP">Edit</a>
                <cfelse>
                    <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataWTDP.ID#">Edit</a>
                </cfif>
            </cfif>
        </td>
        <td>
            <cfif ReviewDataCTDP.Recordcount eq 0>
                <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=CTDP">Edit</a>
            <cfelse>
                <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataCTDP.ID#">Edit</a>
            </cfif>
        </td>
        <td>
            <cfif URL.Year GTE 2014>
            <!--- disable edit>
            <cfif ReviewDataTCP.Recordcount eq 0>
                <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=TCP">Edit</a>
            <cfelse>
                <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataTCP.ID#">Edit</a>
            </cfif>
            --->
            &nbsp;
            <cfelse>
                <cfif ReviewDataTCP.Recordcount eq 0>
                    <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=TCP">Edit</a>
                <cfelse>
                    <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataTCP.ID#">Edit</a>
                </cfif>
            </cfif>
        </td>
        <td>
            <cfif ReviewDataCBScheme.Recordcount eq 0>
                <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=CB Scheme">Edit</a>
            <cfelse>
                <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataCBScheme.ID#">Edit</a>
            </cfif>
        </td>
        <cfif URL.Year gt 2010 OR URL.Year eq 2010 AND Audit.Month gte 9>
        <td>
            <cfif URL.Year GTE 2014>
            <!--- disable edit
                <cfif ReviewDataPPP.Recordcount eq 0>
                    <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=PPP">Edit</a>
                <cfelse>
                    <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataPPP.ID#">Edit</a>
                </cfif>
            --->
            &nbsp;
            <cfelse>
                <cfif ReviewDataPPP.Recordcount eq 0>
                    <a href="DAP_SNAP_Edit.cfm?ID=AddRow&#incString#&FunctionType2=PPP">Edit</a>
                <cfelse>
                    <a href="DAP_SNAP_Edit.cfm?ID=#ReviewDataPPP.ID#">Edit</a>
                </cfif>
            </cfif>
        </td>
        </cfif>
    </tr>
</cfif>
<!--- /// --->
</cfoutput>
</table>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->