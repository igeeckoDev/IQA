<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="EditData" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM xSNAPData
WHERE ID = #URL.ID#
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
SELECT OfficeName FROM IQAtblOffices
WHERE ID = #EditData.AuditOfficeNameID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="SNAP Data (Edit) for #Office.OfficeName#">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cfoutput>
    <script
        language="javascript"
        type="text/javascript"
        src="#IQADir#/tinymce/jscripts/tiny_mce/tiny_mce.js">
    </script>

    <script language="javascript" type="text/javascript">
    tinyMCE.init({
        mode : "textareas",
        content_css : "#SiteDir#SiteShared/cr_style.css"
    });
    </script>
</cfoutput>

<cfif isDefined("Form.Submit")>

<!--- Process Form.Notes --->
<cfif IsDefined("Form.Notes")>
    <!--- Check if Dump2 is not blank. --->
    <cfif len(Form.Notes)>
        <!--- If not, set valueCARs to value of Dump2 --->
        <cfset valueNotes = Form.Notes>
    <cfelse>
		<cfset valueNotes = "None">
	</cfif>
</cfif>

<!--- Process paragraph tags in Form.CARs --->
<cfset Dump = #replace(Form.CARs, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "", "All")#>

<!--- Process Form.CARs, which is DUMP2 after removing p tags --->
<cfif IsDefined("Dump2")>
    <!--- Check if Dump2 is not blank. --->
    <cfif len(Dump2)>
        <!--- If not, set valueCARs to value of Dump2 --->
        <cfset valueCARs = Dump2>
    <cfelse>
		<cfset valueCARs = "None">
	</cfif>
</cfif>

<!--- Process Form.L2EmpNo --->
<cfif IsDefined("Form.L2EmpNo")>
    <!--- Check if Form.L2EmpNo is not blank. --->
    <cfif len(Form.L2EmpNo)>
        <!--- If not, set valueL2EmpNo to value of Form.L2EmpNo --->
        <cfset valueL2EmpNo = Form.L2EmpNo>
	<cfelse>
		<cfset valueL2EmpNo = "00000">
    </cfif>
</cfif>

<!--- Process paragraph tags in Form.CARs --->
<cfset Dump3 = #replace(Form.ProjectsReviewed, "<p>", "", "All")#>
<cfset Dump4 = #replace(Dump3, "</p>", "", "All")#>

<!--- Process Form.ProjectsReviewed --->
<cfif IsDefined("Dump4")>
    <!--- Check if Form.ProjectsReviewed is not blank. --->
    <cfif len(Dump4)>
        <!--- If not, set valueL2EmpNo to value of Form.ProjectsReviewed --->
        <cfset valueProjectsReviewed = Dump4>
	<cfelse>
		<cfset valueProjectsReviewed = "None">
    </cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="UpdateData" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE xSNAPData
SET

Notes = '#valueNotes#',

<!--- For Function 1 WTDP or TCP --->
<cfif Form.FunctionType eq "Qualification">
	<cfif EditData.AuditYear LT 2014 AND Form.FunctionType2 eq "WTDP" AND Form.WTDPCompliance eq "NA"
	OR EditData.AuditYear LT 2014 AND Form.FunctionType2 eq "TCP" AND Form.TCPQualification eq "NA"
	OR EditData.AuditYear LT 2014 AND Form.FunctionType2 eq "PPP" AND Form.TCPQualification eq "NA"
	OR EditData.AuditYear GTE 2014 AND Form.ProgramCompliance eq "NA">
	<!--- fill values with NA when Program Compliance is NA --->
		<cfif EditData.AuditYear GTE 2014>
	        ProgramCompliance = 'NA',
        <cfelse>
	        WTDPCompliance='NA',
			TCPQualification='NA',
		</cfif>
        ProjectsReviewed='NA',
		ComplianceTo00LCS0258='NA',
		L2Competency='NA',
		L2EmpNo='00000',
        <cfif EditData.AuditYear GTE 2014>
        DAPAssessmentScope='NA',
		SignatorySignature='NA',
        </cfif>
		RecordsCompliance='NA',
		CARs='NA'
	<cfelse>
	<!--- Program Compliance is Yes or No, NOT NA --->
		<cfif EditData.AuditYear LT 2014>
			<cfif Form.FunctionType2 eq "WTDP">
                WTDPCompliance='#Form.WTDPCompliance#',
                TCPQualification='NA',
            <cfelseif Form.FunctionType2 eq "TCP">
                WTDPCompliance='NA',
                TCPQualification='#Form.TCPQualification#',
            <cfelseif Form.FunctionType2 eq "PPP">
                WTDPCompliance='NA',
                TCPQualification='#Form.TCPQualification#',
            </cfif>
		<cfelseif EditData.AuditYear GTE 2014>
        	ProgramCompliance = '#Form.ProgramCompliance#',
        </cfif>
		ProjectsReviewed='#valueProjectsReviewed#',
		ComplianceTo00LCS0258='#Form.ComplianceTo00LCS0258#',
		L2Competency='#Form.L2Competency#',
		L2EmpNo='#valueL2EmpNo#',
		L2EmpStatus='#Form.L2EmpStatus#',
        <cfif EditData.AuditYear GTE 2014>
            DAPAssessmentScope='#Form.DAPAssessmentScope#',
            <cfif Form.FunctionType2 NEQ "WTDP" AND Form.FunctionType2 NEQ "CB Scheme">
                SignatorySignature='#Form.SignatorySignature#',
            </cfif>
		</cfif>
		RecordsCompliance='#Form.RecordsCompliance#',
		CARs='#valueCARs#'
	</cfif>
<!--- For any Function 2 Program --->
<cfelseif Form.FunctionType eq "Data Acceptance">
	<!--- fill values with NA when Program Compliance is NA --->
	<cfif Form.ProgramCompliance EQ "NA">
		ProgramCompliance='NA',
		DAPAssessmentScope='NA',
		SignatorySignature='NA',
		ProjectsReviewed='NA',
		ComplianceTo00LCS0258='NA',
		L2Competency='NA',
		L2EmpNo='00000',
		RecordsCompliance='NA',
		CARs='NA'
	<!--- Program Compliance is Yes or No, NOT NA --->
	<cfelse>
		ProgramCompliance='#Form.ProgramCompliance#',
		DAPAssessmentScope='#Form.DAPAssessmentScope#',
			<cfif Form.FunctionType2 NEQ "WTDP" AND Form.FunctionType2 NEQ "CB Scheme">
			SignatorySignature='#Form.SignatorySignature#',
			</cfif>
		ProjectsReviewed='#valueProjectsReviewed#',
		ComplianceTo00LCS0258='#Form.ComplianceTo00LCS0258#',
		L2Competency='#Form.L2Competency#',
		L2EmpNo='#valueL2EmpNo#',
		L2EmpStatus='#Form.L2EmpStatus#',
		RecordsCompliance='#Form.RecordsCompliance#',
		CARs='#valueCARs#'
	</cfif>
</cfif>

WHERE
ID = #Form.insertID#
</cfquery>

<cflocation url="DAP_SNAP_Review.cfm?ID=#Form.AuditID#&Year=#Form.AuditYear#&OfficeID=#Form.AuditOfficeNameID#" addtoken="no">

<cfelse>

<cfif isDefined("URL.ID") AND URL.ID NEQ "AddRow">
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="EditData" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * FROM xSNAPData
	WHERE ID = #URL.ID#
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
	SELECT OfficeName FROM IQAtblOffices
	WHERE ID = #EditData.AuditOfficeNameID#
	</cfquery>

<cfset insertID = #URL.ID#>
<cfelseif isDefined("URL.ID") AND URL.ID EQ "AddRow">
<!--- need to add a row, as Function 2 has been skipped after adding Function 1 --->

	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="AddRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT MAX(ID)+1 as NewID FROM xSNAPData
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
	SELECT OfficeName FROM IQAtblOffices
	WHERE ID = #URL.AuditOfficeNameID#
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="InsertRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO xSNAPData(ID, AuditYear, AuditID, AuditOfficeNameID, FunctionType, FunctionType2, posted)
	VALUES(#AddRow.NewID#, #URL.AuditYear#, #URL.AuditID#, #URL.AuditOfficeNameID#, '#URL.FunctionType#', '#URL.FunctionType2#', #now()#)
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="InsertInitialValues" username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE xSNAPData
	SET
	<cfif URL.FunctionType eq "Qualification">
		WTDPCompliance='NA',
		TCPQualification='NA',
		ProjectsReviewed='NA',
		ComplianceTo00LCS0258='NA',
		L2Competency='NA',
		L2EmpNo='00000',
		RecordsCompliance='NA',
		CARs='NA'
	<cfelseif URL.FunctionType eq "Data Acceptance">
		ProgramCompliance='NA',
		DAPAssessmentScope='NA',
		SignatorySignature='NA',
		ProjectsReviewed='NA',
		ComplianceTo00LCS0258='NA',
		L2Competency='NA',
		L2EmpNo='00000',
		RecordsCompliance='NA',
		CARs='NA'
	</cfif>
	WHERE ID = #AddRow.NewID#
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AuditMonth" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT Month FROM AuditSchedule
	WHERE ID = #URL.AuditID#
	AND Year_ = #URL.AuditYear#
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="AddMonth" username="#OracleDB_Username#" password="#OracleDB_Password#">
	UPDATE xSNAPData
	SET
	AuditMonth = #AuditMonth.Month#
	WHERE ID = #AddRow.NewID#
	</cfquery>

	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="EditData" username="#OracleDB_Username#" password="#OracleDB_Password#">
	SELECT * FROM xSNAPData
	WHERE ID = #AddRow.NewID#
	</cfquery>

<cfset insertID = #AddRow.NewID#>
</cfif>

<br>
<cfoutput query="EditData">
<u>Audit</u>: #AuditYear#-#AuditID#-IQA<br>
<u>Office Name</u>: #Office.OfficeName#<br>
<u>Function/Program</u>: <cfif FunctionType2 eq "WTDP" OR FunctionType2 eq "TCP" OR FunctionType2 eq "PPP">Qualification <b>AND</b> Data Acceptance<cfelse>#FunctionType#</cfif> / #FunctionType2#
</cfoutput><br><br>

<cfform name="form" action="#CGI.Script_Name#?ID=#URL.ID#" method="POST">

<cfinput type="hidden" name="AuditYear" value="#EditData.AuditYear#">
<cfinput type="hidden" name="AuditID" value="#EditData.AuditID#">
<cfinput type="hidden" name="AuditOfficeNameID" value="#EditData.AuditOfficeNameID#">

<cfinput type="hidden" name="FunctionType" value="#EditData.FunctionType#">
<cfinput type="hidden" name="FunctionType2" value="#EditData.FunctionType2#">
<cfinput type="hidden" name="insertID" value="#insertID#">

<cfif EditData.FunctionType eq "Qualification">
<table border="1" class="blog-content" style="border-collapse: collapse;">
	<tr align="center" class="blog-title">
		<td>Category</td>
		<td><cfoutput>#EditData.FunctionType2#</cfoutput> - Current Values</td>
		<td><cfoutput>#EditData.FunctionType2#</cfoutput> - New Values</td>
	</tr>
<cfoutput query="EditData">
	<cfif EditData.AuditYear GTE 2014>
        <tr class="blog-content" valign="top">
            <td>Program Compliance/Qualification</td>
            <td><cfif len(ProgramCompliance)>#ProgramCompliance#<cfelse>No Value</cfif></td>
            <td>
            <cfset var1 = "#ProgramCompliance#">

            <cfinput type="Radio" value="Yes" name="ProgramCompliance"
                checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes

            <cfinput type="Radio" value="No" name="ProgramCompliance"
                checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No

            <cfinput type="Radio" value="NA" name="ProgramCompliance"
                checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
            </td>
        </tr>
	<cfelse>
        <tr class="blog-content" valign="top">
            <td>WTDP Compliance</td>
            <td><cfif len(WTDPCompliance)>#WTDPCompliance#<cfelse>No Value</cfif></td>
            <td>
            <cfif FunctionType2 eq "TCP">
            NA
            <cfelse>
            <cfset var1 = "#WTDPCompliance#">
            <cfinput type="Radio" value="Yes" name="WTDPCompliance"
                checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
            <cfinput type="Radio" value="No" name="WTDPCompliance"
                checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
            <cfinput type="Radio" value="NA" name="WTDPCompliance"
                checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
            </cfif>
            </td>
        </tr>
        <tr class="blog-content" valign="top">
            <td>TCP / PPP Qualification</td>
            <td><cfif len(TCPQualification)>#TCPQualification#<cfelse>No Value</cfif></td>
            <td>
            <cfif FunctionType2 eq "WTDP">
            NA
            <cfelse>
            <cfset var1 = "#TCPQualification#">
            <cfinput type="Radio" value="Yes" name="TCPQualification"
                checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
            <cfinput type="Radio" value="No" name="TCPQualification"
                checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
            <cfinput type="Radio" value="NA" name="TCPQualification"
                checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
            </cfif>
            </td>
        </tr>
	</cfif>
	<tr class="blog-content" valign="top">
		<td>Projects Reviewed</td>
		<td><cfif len(ProjectsReviewed)>#ProjectsReviewed#<cfelse>No Value</cfif></td>
		<td>
		<textarea name="ProjectsReviewed" cols="25" rows="2">#ProjectsReviewed#</textarea>
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>Compliance to <cfif FunctionType2 eq "WTDP">UL's Data Reporting and Recording Requirements<Cfelse>00-OP-C0025</cfif></td>
		<td><cfif len(Complianceto00LCS0258)>#Complianceto00LCS0258#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#Complianceto00LCS0258#">
		<cfinput type="Radio" value="Yes" name="Complianceto00LCS0258"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="Complianceto00LCS0258"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="Complianceto00LCS0258"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>L2 Competency</td>
		<td><cfif len(L2Competency)>#L2Competency#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#L2Competency#">
		<cfinput type="Radio" value="Yes" name="L2Competency"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="L2Competency"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="L2Competency"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>L2 Employee Number</td>
		<td><cfif len(L2EmpNo)>#L2EmpNo#<cfelse>No Value</cfif></td>
		<td>
	   	<cfinput class="blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="L2 Employee Number - Numbers only; Maximum 5 Digits" value="#L2EmpNo#" name="L2EmpNo">
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>L2 - Current Employee?</td>
		<td><cfif len(L2EmpStatus)>#L2EmpStatus#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#L2EmpStatus#">
		<cfinput type="Radio" value="Yes" name="L2EmpStatus"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="L2EmpStatus"
        	checked="#IIF(var1 neq 'Yes', DE('Yes'), DE('No'))#"> No
		</td>
	</tr>
    <cfif EditData.AuditYear GTE 2014>
        <tr class="blog-content" valign="top">
            <td>Signatory Signature</td>
            <td><cfif len(SignatorySignature)>#SignatorySignature#<cfelse>No Value</cfif></td>
            <td>
            <cfif FunctionType2 eq "WTDP" OR FunctionType2 eq "CB Scheme">
            NA
            <cfelse>
            <cfset var1 = "#SignatorySignature#">
            <cfinput type="Radio" value="Yes" name="SignatorySignature"
                checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
            <cfinput type="Radio" value="No" name="SignatorySignature"
                checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
            <cfinput type="Radio" value="NA" name="SignatorySignature"
                checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
            </cfif>
            </td>
        </tr>
        <tr class="blog-content" valign="top">
            <td>DAP Assessment/Scope</td>
            <td><cfif len(DAPAssessmentScope)>#DAPAssessmentScope#<cfelse>No Value</cfif></td>
            <td>
            <cfset var1 = "#DAPAssessmentScope#">
            <cfinput type="Radio" value="Yes" name="DAPAssessmentScope"
                checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
            <cfinput type="Radio" value="No" name="DAPAssessmentScope"
                checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
            <cfinput type="Radio" value="NA" name="DAPAssessmentScope"
                checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
            </td>
        </tr>
	</cfif>
	<tr class="blog-content" valign="top">
		<td>Records Compliance</td>
		<td><cfif len(RecordsCompliance)>#RecordsCompliance#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#RecordsCompliance#">
		<cfinput type="Radio" value="Yes" name="RecordsCompliance"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="RecordsCompliance"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="RecordsCompliance"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>CARs</td>
		<td><cfif len(CARs)>#CARs#<cfelse>No Value</cfif></td>
		<td>
		<textarea name="CARs" cols="25" rows="2">#CARs#</textarea>
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>Notes<br><br>
		<font class="warning">Please use plain text! Maximum 512 characters. You can use notepad application to remove any formatting (from word, notes, outlook, etc) if you have issues.</font>
		</td>
		<td><cfif len(Notes)>#Notes#<cfelse>None</cfif></td>
		<td>
		<textarea name="Notes" cols="25" rows="2"><cfif len(Notes)>#Notes#<cfelse>None</cfif></textarea>
		</td>
	</tr>
</cfoutput>
</table>
<cfelseif EditData.FunctionType eq "Data Acceptance">
<table border="1" class="blog-content">
	<tr align="center" class="blog-title">
		<td>Category</td>
		<td><cfoutput>#EditData.FunctionType2#</cfoutput> - Current Values</td>
		<td><cfoutput>#EditData.FunctionType2#</cfoutput> - New Values</td>
	</tr>
<cfoutput query="EditData">
	<tr class="blog-content" valign="top">
		<td>Program Compliance</td>
		<td><cfif len(ProgramCompliance)>#ProgramCompliance#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#ProgramCompliance#">
		<cfinput type="Radio" value="Yes" name="ProgramCompliance"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="ProgramCompliance"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="ProgramCompliance"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>Projects Reviewed</td>
		<td><cfif len(ProjectsReviewed)>#ProjectsReviewed#<cfelse>No Value</cfif></td>
		<td>
		<textarea name="ProjectsReviewed" cols="25" rows="2">#ProjectsReviewed#</textarea>
		</td>
	</tr>
	<!--- Duplicate Info. Combined with Program Compliance
	<tr class="blog-content" valign="top">
		<td>CB Scheme Compliance</td>
		<td><cfif len(CBSchemeCompliance)>#CBSchemeCompliance#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#CBSchemeCompliance#">
		<cfinput type="Radio" value="Yes" name="CBSchemeCompliance"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="CBSchemeCompliance"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="CBSchemeCompliance"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</td>
	</tr>
	--->
	<tr class="blog-content" valign="top">
		<td>Compliance to <cfif FunctionType2 eq "WTDP">UL's Data Reporting and Recording Requirements<Cfelse>00-OP-C0025</cfif></td>
		<td><cfif len(Complianceto00LCS0258)>#Complianceto00LCS0258#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#Complianceto00LCS0258#">
		<cfinput type="Radio" value="Yes" name="Complianceto00LCS0258"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="Complianceto00LCS0258"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="Complianceto00LCS0258"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>L2 Competency</td>
		<td><cfif len(L2Competency)>#L2Competency#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#L2Competency#">
		<cfinput type="Radio" value="Yes" name="L2Competency"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="L2Competency"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="L2Competency"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>L2 Employee Number</td>
		<td><cfif len(L2EmpNo)>#L2EmpNo#<cfelse>No Value</cfif></td>
		<td>
	   	<cfinput class="blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="L2 Employee Number - Numbers only; Maximum 5 Digits" value="#L2EmpNo#" name="L2EmpNo">
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>L2 - Current Employee?</td>
		<td><cfif len(L2EmpStatus)>#L2EmpStatus#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#L2EmpStatus#">
		<cfinput type="Radio" value="Yes" name="L2EmpStatus"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="L2EmpStatus"
        	checked="#IIF(var1 neq 'Yes', DE('Yes'), DE('No'))#"> No
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>Signatory Signature</td>
		<td><cfif len(SignatorySignature)>#SignatorySignature#<cfelse>No Value</cfif></td>
		<td>
		<cfif FunctionType2 eq "WTDP" OR FunctionType2 eq "CB Scheme">
		NA
		<cfelse>
		<cfset var1 = "#SignatorySignature#">
		<cfinput type="Radio" value="Yes" name="SignatorySignature"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="SignatorySignature"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="SignatorySignature"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</cfif>
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>DAP Assessment/Scope</td>
		<td><cfif len(DAPAssessmentScope)>#DAPAssessmentScope#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#DAPAssessmentScope#">
		<cfinput type="Radio" value="Yes" name="DAPAssessmentScope"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="DAPAssessmentScope"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="DAPAssessmentScope"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>Records Compliance</td>
		<td><cfif len(RecordsCompliance)>#RecordsCompliance#<cfelse>No Value</cfif></td>
		<td>
		<cfset var1 = "#RecordsCompliance#">
		<cfinput type="Radio" value="Yes" name="RecordsCompliance"
        	checked="#IIF(var1 eq 'Yes', DE('Yes'), DE('No'))#"> Yes
		<cfinput type="Radio" value="No" name="RecordsCompliance"
        	checked="#IIF(var1 eq 'No', DE('Yes'), DE('No'))#"> No
		<cfinput type="Radio" value="NA" name="RecordsCompliance"
        	checked="#IIF(var1 eq 'NA', DE('Yes'), DE('No'))#"> NA
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>CARs</td>
		<td><cfif len(CARs)>#CARs#<cfelse>No Value</cfif></td>
		<td>
		<textarea name="CARs" cols="25" rows="2" maxlength="512">#CARs#</textarea>
		</td>
	</tr>
	<tr class="blog-content" valign="top">
		<td>Notes
		<br><br>
		<font class="warning">Please use plain text! Maximum 512 characters. You can use notepad application to remove any formatting (from word, notes, outlook, etc) if you have issues.</font>
		</td>
		<td><cfif len(Notes)>#Notes#<cfelse>None</cfif></td>
		<td>
		<textarea name="Notes" cols="25" rows="2" maxlength="512"><cfif len(Notes)>#Notes#<cfelse>None</cfif></textarea>
		</td>
	</tr>
</cfoutput>
</table>
</cfif>

<INPUT TYPE="Submit" Name="Submit" value="Save Changes">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->