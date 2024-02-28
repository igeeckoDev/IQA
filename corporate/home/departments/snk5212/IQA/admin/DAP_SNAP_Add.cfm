<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="OfficeName">
SELECT OfficeName, ID, SuperLocation
FROM IQAtblOffices
WHERE ID = #URL.OfficeID#
</cfquery>

<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle="SNAP Data (Qualification) - #URL.Year#-#URL.ID#-IQA: #OfficeName.OfficeName#">
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

<!--- ID for WTDP Row --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewID" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID FROM xSNAPData
</cfquery>

<!--- ID for TCP Row --->
<cfset TCPNewID = #NewID.NewID# + 1>

<!--- ID for PPP Row --->
<cfset PPPNewID = #TCPNewID# + 1>

<!-- Process CARs field --->
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

<!--- add WTDP info first --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO xSNAPData
	(ID,
	AuditYear,
	AuditID,
	AuditOfficeNameID,
	FunctionType,
	FunctionType2,
	<cfif URL.Year GTE 2014>
    	ProgramCompliance,
        DAPAssessmentScope,
        SignatorySignature,
    <cfelse>
        WTDPCompliance,
        TCPQualification,
	</cfif>
    CARs,
	ProjectsReviewed,
	ComplianceTo00LCS0258,
	L2Competency,
	L2EmpNo,
	L2EmpStatus,
	RecordsCompliance,
	Posted,
	AuditMonth,
	Notes)

VALUES
	(#NewID.NewID#,
	#URL.Year#,
	#URL.ID#,
	#Form.AuditOfficeNameID#,
	'#Form.FunctionType#',
	'WTDP',
	<cfif URL.Year LT 2014 AND Form.WTDPCompliance_WTDP NEQ "NA"
		OR URL.Year GTE 2014 AND Form.ProgramCompliance_WTDP NEQ "NA">
	<!--- for Yes and No --->
		<cfif URL.Year GTE 2014>
			'#Form.ProgramCompliance_WTDP#',
            '#Form.DAPAssessmentScope_WTDP#',
	        '#Form.SignatorySignature_WTDP#',
		<cfelse>
            '#Form.WTDPCompliance_WTDP#',
            '#Form.TCPQualification_WTDP#',
		</cfif>
	'#Dump2#',
	'#Form.ProjectsReviewed_WTDP#',
	'#Form.ComplianceTo00LCS0258_WTDP#',
	'#Form.L2Competency_WTDP#',
	'#Form.L2EmpNo_WTDP#',
	'#Form.L2EmpStatus_WTDP#',
	'#Form.RecordsCompliance_WTDP#',
	<!--- for NA --->
	<cfelse>
		<cfif URL.Year GTE 2014>
    	'NA', <!--- Prog --->
        'NA', <!--- dap --->
        'NA', <!--- sig --->
		<cfelse>
    	'NA', <!--- wtdp --->
        'NA', <!--- tcp --->
        </cfif>
	'NA', <!--- dump2 --->
	'NA', <!--- proj --->
	'NA', <!--- comp --->
	'NA', <!--- L2 comp --->
	'00000', <!--- Emp No --->
	NULL, <!--- Emp Status --->
	'NA', <!--- Records --->
	</cfif>

#now()#, <!--- posted --->
#Form.Month#, <!--- month --->
'#valueNotes_WTDP#') <!--- notes --->
</cfquery>

<!-- Process CARs field --->
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

<!--- add TCP info --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO xSNAPData
	(ID,
	AuditYear,
	AuditID,
	AuditOfficeNameID,
	FunctionType,
	FunctionType2,
	<cfif URL.Year GTE 2014>
    	ProgramCompliance,
        DAPAssessmentScope,
        SignatorySignature,
    <cfelse>
        WTDPCompliance,
        TCPQualification,
	</cfif>
    CARs,
	ProjectsReviewed,
	ComplianceTo00LCS0258,
	L2Competency,
	L2EmpNo,
	L2EmpStatus,
	RecordsCompliance,
	Posted,
	AuditMonth,
	Notes)

VALUES
	(#TCPNewID#,
	#URL.Year#,
	#URL.ID#,
	#Form.AuditOfficeNameID#,
	'#Form.FunctionType#',
	'TCP',
	<cfif URL.Year LT 2014 AND Form.TCPQualification_TCP NEQ "NA"
		OR URL.Year GTE 2014 AND Form.ProgramCompliance_TCP NEQ "NA">
	<!--- for Yes and No --->
		<cfif URL.Year GTE 2014>
			'#Form.ProgramCompliance_TCP#',
            '#Form.DAPAssessmentScope_TCP#',
	        '#Form.SignatorySignature_TCP#',
		<cfelse>
            '#Form.WTDPCompliance_TCP#',
            '#Form.TCPQualification_TCP#',
		</cfif>
	'#Dump2#',
	'#Form.ProjectsReviewed_TCP#',
	'#Form.ComplianceTo00LCS0258_TCP#',
	'#Form.L2Competency_TCP#',
	'#Form.L2EmpNo_TCP#',
	'#Form.L2EmpStatus_TCP#',
	'#Form.RecordsCompliance_TCP#',
	<!--- for NA --->
	<cfelse>
		<cfif URL.Year GTE 2014>
    	'NA',
       	'NA',
		'NA',
		<cfelse>
    	'NA',
        'NA',
        </cfif>
	'NA',
	'NA',
	'NA',
	'NA',
	'00000',
	NULL,
	'NA',
	</cfif>

#now()#,
#Form.Month#,
'#valueNotes_TCP#')
</cfquery>

<!-- Process CARs field --->
<cfset Dump = #replace(Form.CARs_PPP, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "", "All")#>

<!--- Process Form.Notes_PPP --->
<cfif IsDefined("Form.Notes_PPP")>
    <!--- Check if not blank. --->
    <cfif len(Form.Notes_PPP)>
        <!--- If not, set valueNotes to value of Dump2 --->
        <cfset valueNotes_PPP = Form.Notes_PPP>
    <cfelse>
		<cfset valueNotes_PPP = "None">
	</cfif>
</cfif>

<!--- add PPP info --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO xSNAPData
	(ID,
	AuditYear,
	AuditID,
	AuditOfficeNameID,
	FunctionType,
	FunctionType2,
	<cfif URL.Year GTE 2014>
    	ProgramCompliance,
        DAPAssessmentScope,
        SignatorySignature,
    <cfelse>
        WTDPCompliance,
        TCPQualification,
	</cfif>
    CARs,
	ProjectsReviewed,
	ComplianceTo00LCS0258,
	L2Competency,
	L2EmpNo,
	L2EmpStatus,
	RecordsCompliance,
	Posted,
	AuditMonth,
	Notes)

VALUES
	(#PPPNewID#,
	#URL.Year#,
	#URL.ID#,
	#Form.AuditOfficeNameID#,
	'#Form.FunctionType#',
	'PPP',
	<cfif URL.Year LT 2014 AND Form.TCPQualification_PPP NEQ "NA"
		OR URL.Year GTE 2014 AND Form.ProgramCompliance_PPP NEQ "NA">
	<!--- for Yes and No --->
		<cfif URL.Year GTE 2014>
			'#Form.ProgramCompliance_PPP#',
            '#Form.DAPAssessmentScope_PPP#',
        	'#Form.SignatorySignature_PPP#',
		<cfelse>
            '#Form.WTDPCompliance_PPP#',
            '#Form.TCPQualification_PPP#',
		</cfif>
	'#Dump2#',
	'#Form.ProjectsReviewed_PPP#',
	'#Form.ComplianceTo00LCS0258_PPP#',
	'#Form.L2Competency_PPP#',
	'#Form.L2EmpNo_PPP#',
	'#Form.L2EmpStatus_PPP#',
	'#Form.RecordsCompliance_PPP#',
	<!--- for NA --->
	<cfelse>
		<cfif URL.Year GTE 2014>
    	'NA',
        'NA',
        'NA',
		<cfelse>
    	'NA',
        'NA',
        </cfif>
	'NA',
	'NA',
	'NA',
	'NA',
	'00000',
	NULL,
	'NA',
	</cfif>

#now()#,
#Form.Month#,
'#valueNotes_PPP#')
</cfquery>

<!--- ID for Data Acceptance TPTDP Row --->
<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewID" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT MAX(ID)+1 as NewID FROM xSNAPData
</cfquery>

<!--- ID for other Data Acceptance Rows --->
<cfset NewID6 = #NewID.NewID# + 5>

<cfset arrayFunction2 = ArrayNew(1)>
	<CFSET arrayFunction2[1] = 'TPTDP'>
	<CFSET arrayFunction2[2] = 'WTDP'>
	<CFSET arrayFunction2[3] = 'CTDP'>
	<CFSET arrayFunction2[4] = 'TCP'>
	<CFSET arrayFunction2[5] = 'CB Scheme'>
	<CFSET arrayFunction2[6] = 'PPP'>

<cfset j = 1>

<cfloop index="i" from="#NewID.NewID#" to="#NewID6#">
<!--- add all new rows for Data Acceptance --->
	<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="NewRow" username="#OracleDB_Username#" password="#OracleDB_Password#">
	INSERT INTO xSNAPData
		(ID,
		AuditYear,
		AuditID,
		AuditOfficeNameID,
		FunctionType,
		FunctionType2,
		ProgramCompliance,
		ProjectsReviewed,
		ComplianceTo00LCS0258,
		L2Competency,
		L2EmpNo,
		L2EmpStatus,
		RecordsCompliance,
		DAPAssessmentScope,
		SignatorySignature,
		AuditMonth,
		Posted,
		CARs
        <cfif i eq 2
			OR i eq 4
			OR i eq 6>
        ,
        Status,
		CompletedDate
        </cfif>
        )

	VALUES
		(#i#,
		#URL.Year#,
		#URL.ID#,
		#Form.AuditOfficeNameID#,
		'Data Acceptance',
		'#Evaluate("arrayFunction2[#j#]")#',
		'NA',
		'NA',
		'NA',
		'NA',
		'00000',
		'NA',
		'NA',
		'NA',
		'NA',
		#Form.Month#,
		#now()#,
		'NA'
		<cfif i eq 2
	        OR i eq 4
	        OR i eq 6>
        ,
        'Complete',
		#completedDate#
        </cfif>
        )
	</cfquery>

<cfset j = j+1>
<!--- /// --->
</cfloop>

<cflocation url="DAP_SNAP_Review.cfm?Year=#URL.Year#&ID=#URL.ID#&OfficeID=#Form.AuditOfficeNameID#&Month=#Form.Month#" addtoken="no">

<cfelse>

<cfform name="form" action="#CGI.Script_Name#?#CGI.Query_String#" method="POST">
<br>

<cfoutput query="OfficeName">
	<cfif isDefined("URL.OfficeID") AND OfficeName.OfficeName NEQ "Global">
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="selOffice">
		SELECT OfficeName, ID
		FROM IQAtblOffices
		WHERE ID = #URL.OfficeID#
		</cfquery>

		<b>Office Name:</b><br>
		<cfinput type="hidden" name="AuditOfficeNameID" value="#ID#">
		#selOffice.OfficeName#
	<cfelseif SuperLocation EQ "Yes" AND NOT isDefined("URL.OfficeID")>
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="selOffice">
		SELECT OfficeName, ID
		FROM IQAtblOffices
		WHERE SuperLocationID = #ID#
		</cfquery>

		<b>Select Office Name:</b><br>
		<cfselect
	        name="AuditOfficeNameID"
	        size="#selOffice.recordcount#"
	        multiple="No"
	        required="yes"
			query="seloffice"
			value="ID"
			display="OfficeName"
	        message="Office Name"
	        class="blog-content"
			queryposition="below">
		</cfselect>
	<cfelseif OfficeName.OfficeName EQ "Global">
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="selOffice">
		SELECT OfficeName, ID
		FROM IQAtblOffices
		WHERE Exist = 'Yes'
		AND Physical = 'Yes'
		AND Finance = 'Yes'
		ORDER BY OfficeName
		</cfquery>

		<b>Select Office Name:</b><br>
		<cfselect
	        name="AuditOfficeNameID"
	        size="10"
	        multiple="No"
	        required="yes"
			query="seloffice"
			value="ID"
			display="OfficeName"
	        message="Office Name"
	        class="blog-content"
			queryposition="below">
		</cfselect>
	<cfelse>
		<b>Office Name:</b><br>
		<cfinput type="hidden" name="AuditOfficeNameID" value="#ID#">
		#OfficeName#
	</cfif><br><Br>
</cfoutput>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT AuditSchedule.Month, AuditSchedule.AuditType2, AuditSchedule.OfficeName
FROM AuditSchedule
WHERE AuditSchedule.ID = #URL.ID#
AND AuditSchedule.Year_ = #URL.Year#
</cfquery>

<b>Function 1 - Qualification</b><br><br>
<cfinput type="hidden" name="FunctionType" value="Qualification">
<cfinput type="hidden" name="Month" value="#Audit.Month#">

<cfoutput>
<Table class="blog-content" border="1">
<tr align="center">
	<td><b>Categories</b></td>
	<td><b>WTDP</b></td>
	<td><b>TCP</b></td>
    <td><b>PPP</b></td>
</tr>
<cfif URL.Year GTE 2014>
    <tr>
        <td>Program Compliance</td>
        <cfset fieldname = "ProgramCompliance">
        <td>
            <cfinput type="Radio" value="Yes" name="#fieldname#_WTDP" checked> Yes
            <cfinput type="Radio" value="No" name="#fieldname#_WTDP"> No
            <cfinput type="Radio" value="NA" name="#fieldname#_WTDP"> NA
        </td>
        <td>
            <cfinput type="Radio" value="Yes" name="#fieldname#_TCP" checked> Yes
            <cfinput type="Radio" value="No" name="#fieldname#_TCP"> No
            <cfinput type="Radio" value="NA" name="#fieldname#_TCP"> NA
        </td>
        <td>
            <cfinput type="Radio" value="Yes" name="#fieldname#_PPP" checked> Yes
            <cfinput type="Radio" value="No" name="#fieldname#_PPP"> No
            <cfinput type="Radio" value="NA" name="#fieldname#_PPP"> NA
        </td>
    </tr>
<cfelse>
    <tr>
        <td>WTDP Compliance</td>
        <cfset fieldname = "WTDPCompliance">
        <td>
            <cfinput type="Radio" value="Yes" name="#fieldname#_WTDP" checked> Yes
            <cfinput type="Radio" value="No" name="#fieldname#_WTDP"> No
            <cfinput type="Radio" value="NA" name="#fieldname#_WTDP"> NA
        </td>
        <td>
            <cfinput type="hidden" value="NA" name="#fieldname#_TCP" checked> <strong>NA</strong>
        </td>
        <td>
            <cfinput type="hidden" value="NA" name="#fieldname#_PPP" checked> <strong>NA</strong>
        </td>
    </tr>
    <tr>
        <td>TCP / PPP Qualification</td>
        <cfset fieldname = "TCPQualification">
        <td>
            <cfinput type="hidden" value="NA" name="#fieldname#_WTDP" checked> <strong>NA</strong>
        </td>
        <td>
            <cfinput type="Radio" value="Yes" name="#fieldname#_TCP" checked> Yes
            <cfinput type="Radio" value="No" name="#fieldname#_TCP"> No
            <cfinput type="Radio" value="NA" name="#fieldname#_TCP"> NA
        </td>
        <td>
            <cfinput type="Radio" value="Yes" name="#fieldname#_PPP" checked> Yes
            <cfinput type="Radio" value="No" name="#fieldname#_PPP"> No
            <cfinput type="Radio" value="NA" name="#fieldname#_PPP"> NA
        </td>
    </tr>
</cfif>
<tr>
	<td>Projects Reviewed</td>
	<cfset fieldname = "ProjectsReviewed">
	<td>
		<textarea name="#fieldname#_WTDP" cols="25" rows="2">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_TCP" cols="25" rows="2">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_PPP" cols="25" rows="2">None</textarea>
	</td>
</tr>
<tr>
	<td>Compliance to:<Br>UL's Data Reporting and Recording Requirements (WTDP)<Br>00-OP-C0025 (Others)</td>
	<cfset fieldname = "ComplianceTo00LCS0258">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_WTDP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_WTDP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_WTDP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_TCP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_TCP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_TCP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_PPP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_PPP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_PPP"> NA
	</td>
</tr>
<tr>
	<td>L2 Competency</td>
	<cfset fieldname = "L2Competency">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_WTDP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_WTDP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_WTDP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_TCP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_TCP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_TCP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_PPP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_PPP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_PPP"> NA
	</td>
</tr>
<tr>
	<td>L2 Employee Number</td>
	<cfset fieldname = "L2EmpNo">
	<td>
	   	<cfinput class="blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="WTDP: L2 Employee Number - Numbers only; Maximum 5 Digits" value="L2 Employee Number" name="#fieldname#_WTDP">
	</td>
	<td>
	   	<cfinput class="blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="TCP: L2 Employee Number - Numbers only; Maximum 5 Digits" value="L2 Employee Number" name="#fieldname#_TCP">
	</td>
	<td>
	   	<cfinput class="blog-content" type="text" size="39" validate="zipcode" maxlength="5" message="PPP: L2 Employee Number - Numbers only; Maximum 5 Digits" value="L2 Employee Number" name="#fieldname#_PPP">
	</td>
</tr>
<tr>
	<td>L2 - Current Employee?</td>
	<cfset fieldname = "L2EmpStatus">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_WTDP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_WTDP"> No
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_TCP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_TCP"> No
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_PPP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_PPP"> No
	</td>
</tr>
<cfif URL.Year GTE 2014>
<!--- Signatory Signature --->
<tr>
	<td>Signatory Signature</td>
	<cfset fieldname = "SignatorySignature">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_WTDP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_WTDP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_WTDP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_TCP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_TCP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_TCP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_PPP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_PPP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_PPP"> NA
	</td>
</tr>
<!--- DAP Assessment/Scope --->
<tr>
	<td>DAP Assessment/Scope</td>
	<cfset fieldname = "DAPAssessmentScope">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_WTDP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_WTDP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_WTDP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_TCP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_TCP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_TCP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_PPP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_PPP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_PPP"> NA
	</td>
</tr>
</cfif>
<tr>
	<td>Records Compliance</td>
	<cfset fieldname = "RecordsCompliance">
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_WTDP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_WTDP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_WTDP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_TCP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_TCP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_TCP"> NA
	</td>
	<td>
	   	<cfinput type="Radio" value="Yes" name="#fieldname#_PPP" checked> Yes
        <cfinput type="Radio" value="No" name="#fieldname#_PPP"> No
        <cfinput type="Radio" value="NA" name="#fieldname#_PPP"> NA
	</td>
</tr>
<tr>
	<td>CARs</td>
	<br><br>
	<font class="warning">Please use plain text! Maximum 512 characters. You can use notepad application to remove any formatting (from word, notes, outlook, etc) if you have issues.</font>
	<cfset fieldname = "CARs">
	<td>
		<textarea name="#fieldname#_WTDP" cols="25" rows="2">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_TCP" cols="25" rows="2">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_PPP" cols="25" rows="2">None</textarea>
	</td>
</tr>
<tr>
	<td>
	Notes
	<br><br>
	<font class="warning">Please use plain text! Maximum 512 characters. You can use notepad application to remove any formatting (from word, notes, outlook, etc) if you have issues.</font>
	<cfset fieldname = "Notes">
	</td>
	<td>
		<textarea name="#fieldname#_WTDP" cols="25" rows="2">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_TCP" cols="25" rows="2">None</textarea>
	</td>
	<td>
		<textarea name="#fieldname#_PPP" cols="25" rows="2">None</textarea>
	</td>
</tr>
</TABLE><br><br>
</cfoutput>

<INPUT TYPE="Submit" Name="Submit" value="Save and Continue">
</cfform>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->