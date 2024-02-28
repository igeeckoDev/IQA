<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="SNAP Data (Data Acceptance) for #URL.Year#-#URL.ID#-IQA">
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

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Office">
SELECT OfficeName, ID
FROM IQAtblOffices
WHERE ID = #URL.OfficeID#
</cfquery>

<cfif isDefined("Form.Submit")>

<!--- ID for WTDP Row --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewID" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID FROM xSNAPData
</cfquery>

<!--- ID for New Rows --->
<cfset NewID2 = #NewID.NewID# + 1>
<cfset NewID3 = #NewID2# + 1>
<cfset NewID4 = #NewID3# + 1>
<cfset NewID5 = #NewID4# + 1>

<!--- TPTDP --->
<cfset Dump = #replace(Form.CARs_TPTDP, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "", "All")#>

<!--- Process Form.Notes_TPTDP --->
<cfif IsDefined("Form.Notes_TPTDP")>
    <!--- Check if not blank. --->
    <cfif len(Form.Notes_TPTDP)>
        <!--- If not, set valueNotes to value of Dump2 --->
        <cfset valueNotes_TPTDP = Form.Notes_TPTDP>
    <cfelse>
		<cfset valueNotes_TPTDP = "None">
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT

INTO xSNAPData
	(ID, AuditYear, AuditID, AuditOfficeNameID, FunctionType, FunctionType2, ProjectsReviewed, ComplianceTo00LCS0258, L2Competency, L2EmpNo, L2EmpStatus, RecordsCompliance, CARs, Posted, ProgramCompliance, DAPAssessmentScope, SignatorySignature, AuditMonth, Notes)

VALUES
	(#NewID.NewID#, #URL.Year#, #URL.ID#, #URL.OfficeID#, '#Form.FunctionType#', 'TPTDP', '#Form.ProjectsReviewed_TPTDP#', '#Form.ComplianceTo00LCS0258_TPTDP#', '#Form.L2Competency_TPTDP#', '#Form.L2EmpNo_TPTDP#', '#Form.L2EmpStatus_TPTDP#', '#Form.RecordsCompliance_TPTDP#', '#Dump2#', #now()#, '#Form.ProgramCompliance_TPTDP#', '#Form.DAPAssessmentScope_TPTDP#', '#Form.SignatorySignature_TPTDP#', #URL.Month#, '#valueNotes_TPTDP#')
</cfquery>

<!--- WTDP --->
<cfset Dump = #replace(Form.CARs_WTDP, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "", "All")#>

<!--- Process Form.Notes_WTDP --->
<cfif IsDefined("Form.Notes_WTDP")>
    <!--- Check if not blank. --->
    <cfif len(Form.Notes_WTDP)>
        <!--- If not, set valueNotes to value of Dump2 --->
        <cfset valueNotes_WTDP = Form.Notes_WTDP>
    <cfelse>
		<cfset valueNotes_WTDP = "None">
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO xSNAPData
	(ID, AuditYear, AuditID, AuditOfficeNameID, FunctionType, FunctionType2, ProjectsReviewed, ComplianceTo00LCS0258, L2Competency, L2EmpNo, L2EmpStatus, RecordsCompliance, CARs, Posted, ProgramCompliance, DAPAssessmentScope, SignatorySignature, AuditMonth, Notes)

VALUES
	(#NewID2#, #URL.Year#, #URL.ID#, #URL.OfficeID#, '#Form.FunctionType#', 'WTDP', '#Form.ProjectsReviewed_WTDP#', '#Form.ComplianceTo00LCS0258_WTDP#', '#Form.L2Competency_WTDP#', '#Form.L2EmpNo_WTDP#', '#Form.L2EmpStatus_WTDP#',  '#Form.RecordsCompliance_WTDP#', '#Dump2#', #now()#, '#Form.ProgramCompliance_WTDP#', '#Form.DAPAssessmentScope_WTDP#', '#Form.SignatorySignature_WTDP#', #URL.Month#, '#valueNotes_WTDP#')
</cfquery>

<!--- CTDP --->
<cfset Dump = #replace(Form.CARs_CTDP, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "", "All")#>

<!--- Process Form.Notes_CTDP --->
<cfif IsDefined("Form.Notes_CTDP")>
    <!--- Check if not blank. --->
    <cfif len(Form.Notes_CTDP)>
        <!--- If not, set valueNotes to value of Dump2 --->
        <cfset valueNotes_CTDP = Form.Notes_CTDP>
    <cfelse>
		<cfset valueNotes_CTDP = "None">
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT

INTO xSNAPData
	(ID, AuditYear, AuditID, AuditOfficeNameID, FunctionType, FunctionType2, ProjectsReviewed, ComplianceTo00LCS0258, L2Competency, L2EmpNo, L2EmpStatus, RecordsCompliance, CARs, Posted, ProgramCompliance, DAPAssessmentScope, SignatorySignature, AuditMonth, Notes)

VALUES
	(#NewID3#, #URL.Year#, #URL.ID#, #URL.OfficeID#, '#Form.FunctionType#', 'CTDP', '#Form.ProjectsReviewed_CTDP#', '#Form.ComplianceTo00LCS0258_CTDP#', '#Form.L2Competency_CTDP#', '#Form.L2EmpNo_CTDP#', '#Form.L2EmpStatus_CTDP#',  '#Form.RecordsCompliance_CTDP#', '#Dump2#', #now()#, '#Form.ProgramCompliance_CTDP#', '#Form.DAPAssessmentScope_CTDP#', '#Form.SignatorySignature_CTDP#', #URL.Month#, '#valueNotes_CTDP#')
</cfquery>

<!--- TCP --->
<cfset Dump = #replace(Form.CARs_TCP, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "", "All")#>

<!--- Process Form.Notes_TCP --->
<cfif IsDefined("Form.Notes_TCP")>
    <!--- Check if not blank. --->
    <cfif len(Form.Notes_TCP)>
        <!--- If not, set valueNotes to value of Dump2 --->
        <cfset valueNotes_TCP = Form.Notes_TCP>
    <cfelse>
		<cfset valueNotes_TCP = "None">
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT

INTO xSNAPData
	(ID, AuditYear, AuditID, AuditOfficeNameID, FunctionType, FunctionType2, ProjectsReviewed, ComplianceTo00LCS0258, L2Competency, L2EmpNo, L2EmpStatus, RecordsCompliance, CARs, Posted, ProgramCompliance, DAPAssessmentScope, SignatorySignature, AuditMonth, Notes)

VALUES
	(#NewID4#, #URL.Year#, #URL.ID#, #URL.OfficeID#, '#Form.FunctionType#', 'TCP', '#Form.ProjectsReviewed_TCP#', '#Form.ComplianceTo00LCS0258_TCP#', '#Form.L2Competency_TCP#', '#Form.L2EmpNo_TCP#', '#Form.L2EmpStatus_TCP#', '#Form.RecordsCompliance_TCP#', '#Dump2#', #now()#, '#Form.ProgramCompliance_TCP#', '#Form.DAPAssessmentScope_TCP#', '#Form.SignatorySignature_TCP#', #URL.Month#, '#valueNotes_TCP#')
</cfquery>

<!--- CB Scheme--->
<cfset Dump = #replace(Form.CARs_CBScheme, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "", "All")#>

<!--- Process Form.Notes_TCP --->
<cfif IsDefined("Form.Notes_CBScheme")>
    <!--- Check if not blank. --->
    <cfif len(Form.Notes_CBScheme)>
        <!--- If not, set valueNotes to value of Dump2 --->
        <cfset valueNotes_CBScheme = Form.Notes_CBScheme>
    <cfelse>
		<cfset valueNotes_CBScheme = "None">
	</cfif>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT

INTO xSNAPData
	(ID, AuditYear, AuditID, AuditOfficeNameID, FunctionType, FunctionType2, ProjectsReviewed, ComplianceTo00LCS0258, L2Competency, L2EmpNo, L2EmpStatus, RecordsCompliance, CARs, Posted, ProgramCompliance, DAPAssessmentScope, SignatorySignature, AuditMonth, Notes)

VALUES
	(#NewID5#, #URL.Year#, #URL.ID#, #URL.OfficeID#, '#Form.FunctionType#', 'CB Scheme', '#Form.ProjectsReviewed_CBScheme#', '#Form.ComplianceTo00LCS0258_CBScheme#', '#Form.L2Competency_CBScheme#', '#Form.L2EmpNo_CBScheme#', '#Form.L2EmpStatus_CBScheme#', '#Form.RecordsCompliance_CBScheme#', '#Dump2#', #now()#, '#Form.ProgramCompliance_CBScheme#', '#Form.DAPAssessmentScope_CBScheme#', '#Form.SignatorySignature_CBScheme#', #URL.Month#, '#valueNotes_CBScheme#')
</cfquery>

<cflocation url="DAP_SNAP_Review.cfm?#CGI.Query_String#" addtoken="no">

<cfelse>

<cfform name="form" action="#CGI.Script_Name#?#CGI.Query_String#" method="POST">
<br>

<cfset Type1 = "TPTDP">
<cfset Type2 = "WTDP">
<cfset Type3 = "CTDP">
<cfset Type4 = "TCP">
<cfset Type5 = "CBScheme">
<cfset cols = 20>
<cfset rows = 1>

<cfoutput>
<b>Function 2 - Data Acceptance</b><br>
	<cfinput type="hidden" name="FunctionType" value="Data Acceptance">
<u>Office</u> - #Office.OfficeName#<br><br>

<Table class="blog-content" border="1">
<tr align="center">
	<td><b>Categories</b></td>
	<td><b>TPTDP</b></td>
	<td><b>WTDP</b></td>
	<td><b>CTDP</b></td>
	<td><b>TCP</b></td>
	<td><b>CB Scheme</b></td>
</tr>
<!--- Program Compliance --->
<tr>
	<td>Program Compliance</td>
	<cfset fieldname = "ProgramCompliance">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type1#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type1#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type1#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type2#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type2#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type2#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type3#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type3#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type3#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type4#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type4#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type4#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type5#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type5#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type5#"> NA
	</td>
</tr>
<!--- Projects Reviewed --->
<tr>
	<td>Projects Reviewed</td>
	<cfset fieldname = "ProjectsReviewed">
	<td>
		<textarea name="#fieldname#_#Type1#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type2#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type3#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type4#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type5#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
</tr>
<!--- CB Scheme Compliance REMOVED. Duplicate Info. (See Program Compliance)
<tr>
	<td>CB Scheme Compliance</td>
	<cfset fieldname = "CBSchemeCompliance">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type1#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type1#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type1#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type2#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type2#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type2#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type3#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type3#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type3#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type4#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type4#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type4#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type5#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type5#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type5#"> NA
	</td>
</tr>
--->
<!--- Compliance to 00-LC-S0258 --->
<tr>
	<td>Compliance to:<Br>UL's Data Reporting and Recording Requirements (WTDP)<Br>00-OP-C0025 (Others)</td>
	<cfset fieldname = "ComplianceTo00LCS0258">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type1#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type1#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type1#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type2#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type2#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type2#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type3#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type3#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type3#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type4#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type4#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type4#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type5#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type5#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type5#"> NA
	</td>
</tr>
<!--- L2 Competency --->
<tr>
	<td>L2 Competency</td>
	<cfset fieldname = "L2Competency">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type1#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type1#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type1#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type2#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type2#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type2#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type3#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type3#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type3#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type4#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type4#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type4#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type5#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type5#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type5#"> NA
	</td>
</tr>
<!--- L2 Employee Number --->
<tr>
	<td>L2 Employee Number</td>
	<cfset fieldname = "L2EmpNo">
	<td>
		<cfinput class="Blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="#Type1# L2 Employee Number: Numbers only; Maximum 5 Digits" value="L2 Employee Number" name="#fieldname#_#Type1#">
	</td>
	<td>
		<cfinput class="Blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="#Type2# L2 Employee Number: Numbers only; Maximum 5 Digits" value="L2 Employee Number" name="#fieldname#_#Type2#">
	</td>
	<td>
		<cfinput class="Blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="#Type3# L2 Employee Number: Numbers only; Maximum 5 Digits" value="L2 Employee Number" name="#fieldname#_#Type3#">
	</td>
	<td>
		<cfinput class="Blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="#Type4# L2 Employee Number: Numbers only; Maximum 5 Digits" value="L2 Employee Number" name="#fieldname#_#Type4#">
	</td>
	<td>
		<cfinput class="Blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="#Type5# L2 Employee Number: Numbers only; Maximum 5 Digits" value="L2 Employee Number" name="#fieldname#_#Type5#">
	</td>
</tr>
<!--- L2 Employee Status --->
<tr>
	<td>L2 - Current Employee?</td>
	<cfset fieldname = "L2EmpStatus">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type1#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type1#"> No
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type2#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type2#"> No
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type3#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type3#"> No
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type4#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type4#"> No
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type5#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type5#"> No
	</td>
</tr>
<!--- Signatory Signature --->
<tr>
	<td>Signatory Signature</td>
	<cfset fieldname = "SignatorySignature">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type1#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type1#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type1#"> NA
	</td>
	<td>
        <cfinput type="Hidden" value="NA" name="#fieldname#_#Type2#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type3#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type3#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type3#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type4#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type4#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type4#"> NA
	</td>
	<td>
        <cfinput type="Hidden" value="NA" name="#fieldname#_#Type5#"> NA
	</td>
</tr>
<!--- DAP Assessment/Scope --->
<tr>
	<td>DAP Assessment/Scope</td>
	<cfset fieldname = "DAPAssessmentScope">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type1#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type1#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type1#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type2#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type2#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type2#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type3#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type3#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type3#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type4#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type4#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type4#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type5#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type5#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type5#"> NA
	</td>
</tr>
<!--- Records Compliance --->
<tr>
	<td>Records Compliance</td>
	<cfset fieldname = "RecordsCompliance">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type1#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type1#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type1#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type2#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type2#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type2#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type3#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type3#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type3#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type4#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type4#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type4#"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_#Type5#" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_#Type5#"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_#Type5#"> NA
	</td>
</tr>
<!-- CARs --->
<tr>
	<td>CARs</td>
	<cfset fieldname = "CARs">
	<td>
		<textarea name="#fieldname#_#Type1#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type2#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type3#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type4#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type5#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
</tr>
<!-- Notes --->
<tr>
	<td>Notes</td>
	<cfset fieldname = "Notes">
	<td>
		<textarea name="#fieldname#_#Type1#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type2#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type3#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type4#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_#Type5#" cols="#cols#" rows="#rows#">None</textarea>
	</td>
</tr>
</TABLE><br><br>
</cfoutput>

<INPUT TYPE="Submit" Name="Submit" value="Save and Review Data">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->