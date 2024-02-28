<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Audit Report Upload">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<b>Current Action</b><br />
<cfoutput>
#URL.Action#<br /><br />
</cfoutput>

<cfquery Datasource="UL06046" name="getROM"> 
SELECT 
	Corporate.IQARegion.TechnicalAudits_ROM as ROM, Corporate.IQAtblOffices.TechnicalAudits_SQM as SQM
FROM 
	Corporate.IQARegion, Corporate.IQASubRegion, Corporate.IQAtblOffices, UL06046.TechnicalAudits_AuditSchedule
WHERE 
	Corporate.IQARegion.Region = Corporate.IQASubRegion.Region
	AND Corporate.IQASubRegion.SubRegion = Corporate.IQAtblOffices.SubRegion
	AND Corporate.IQAtblOffices.OfficeName = UL06046.TechnicalAudits_AuditSchedule.OfficeName
    AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = '#Audit.OfficeName#'
</CFQUERY>

<!--- ensure directory exists for this audit --->
<!--- create directory name based on audit number --->
<cfset newDirectory = "#URL.Year#-#URL.ID#">
<!--- set current directory --->
<cfset currentDirectory = "#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#newDirectory#">

<!--- check if the directory DOES NOT exist, if it DOES exist - DO NOTHING --->
<cfif NOT DirectoryExists(currentDirectory)>
	<!--- create directory --->
	<cfdirectory action="create" directory="#currentDirectory#">
</cfif>

<!--- get audit identifier, add flag_currentStep to end --->
<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cfoutput query="Audit">
	<cfif AuditType2 eq "Full">
        <cfset AuditTypeID = "F">
    <cfelse>
        <cfset AuditTypeID = "P">
    </cfif>
    
    <cfif RequestType eq "Test">
    	<cfset RequestTypeID = "T">
    <cfelse>
    	<cfset RequestTypeID = "N">
    </cfif>

	<cfset AuditorLoc = #right(AuditorDept, 3)#>
    
    <cfif AuditType2 eq "Full">
        <cfset ReviewLoc = #right(ProjectPrimeReviewerDept, 3)#>
    <cfelse>
        <cfset ReviewLoc = #right(ProjectPrimeReviewerDept, 3)#>
    </cfif>

    <cfset Identifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#_#URL.Action#">
</cfoutput>

<!--- if form has been submitted --->
<cfif isDefined("Form.File") AND isDefined("Form.YesNoItem")>

<!--- upload file to temp location --->
<CFFILE ACTION="UPLOAD" 
    FILEFIELD="Form.File" 
    DESTINATION="#IQARootPath#TechAuditReports\TempUpload\" 
    NAMECONFLICT="OVERWRITE">

<!---- set the path and set file name, using cffile.serverfileext from cffile above --->
<cfset destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#Identifier#.#cffile.ServerFileExt#">

<cfset newFileName = "#Identifier#.#cffile.ServerFileExt#">

<!--- upload file to destination--->
<cffile action="upload" filefield="file" destination="#destination#" nameconflict="Overwrite">

<CFQUERY BLOCKFACTOR="100" NAME="checkMaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT Max(ID)+1 as maxID
FROM TechnicalAudits_ReportFiles
</CFQUERY>

<cfif NOT len(checkMaxID.MaxID)>
	<cfset checkMaxID.maxID = 1>
</cfif>

<!--- update TechnicalAudits_ReportFiles table --->
<CFQUERY BLOCKFACTOR="100" NAME="ReportFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
INSERT INTO TechnicalAudits_ReportFiles(ID, AuditYear, AuditID, DatePosted, PostedBy, ReportFileName, Flag_CurrentStep)
VALUES(#checkMaxID.maxID#, #URL.Year#, #URL.ID#, #CreateODBCDate(curdate)#, '', '#NewFileName#', '#URL.Action#')
</CFQUERY>

<!--- Audit Completed - Audit Report Posted --->
<cfif URL.Action eq "Audit Completed - Audit Report Posted">
	<!--- update TechnicalAudits_AuditSchedule table --->
    <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    NCExist = '#Form.YesNoItem#',
    ReportPostedDate = #createODBCDate(curdate)#,
    ReportPosted = 'Yes',
    
    <cfif FORM.YesNoItem eq "Yes">
        <cfset CurrentStep = "Audit Completed - Audit Report Posted">
        Flag_CurrentStep = 'Audit Completed - Audit Report Posted',
        <Cfset DueDate = DateAdd('d', 14, curdate)>
        NCReviewDueDate = #createODBCDate(DueDate)#
    <cfelseif FORM.YesNoItem eq "No">
        <cfset CurrentStep = "Audit Completed">
        Flag_CurrentStep = 'Audit Completed',
        AuditClosed = 'Yes',
        AuditCloseddate = #createODBCDate(curdate)#,
        AuditClosedConfirm = 'No'
    </cfif>
    
    WHERE
    ID = #URL.ID#
    AND Year_ = #URL.Year#
    </CFQUERY>

	<!--- get audit identifier, add flag_currentStep to end --->
    <CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT 
        *
    FROM 
        TechnicalAudits_AuditSchedule
    WHERE
        ID = #URL.ID#
        AND Year_ = #URL.Year#
    </cfquery>
    
    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ReportFileName, DatePosted
    FROM TechnicalAudits_ReportFiles
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND Flag_CurrentStep = 'Audit Completed - Audit Report Posted'
    </cfquery>
    
    <cfif Form.YesNoItem eq "No">
		<!--- send email to TAM/etc that report has been uploaded and NC Review is scheduled and due on NCReviewDuedate --->
        <!--- TO field: Technical Audit Manager goes here --->
        <cfmail
            to="#Request.TechnicalAuditManager#" 
            from="Internal.Quality_Audits@ul.com"
            cc="#getROM.ROM#"
            subject="Internal Technical Audits - Audit Report Posted, Audit Closed"
            query="Audit"
            type="html">
            Audit: #varAuditIdentifier#<br />
            Audit Report Posted: #dateformat(getFile.DatePosted, "mm/dd/yyyy")#<br /><br />
            
            This report was marked "No Non-Conformances Found"<br /><br />
            
            Please log in to the IQA Audit Database to view this audit.
        </cfmail>    	
    <cfelseif Form.YesNoItem eq "Yes">
		<!--- send email to TAM that report has been uploaded and NC Review is scheduled and due on NCReviewDuedate --->
        <cfmail
            to="#Request.TechnicalAuditManager#"
            from="Internal.Quality_Audits@ul.com"
            cc="#getROM.ROM#"
            subject="Internal Technical Audits - Audit Report Posted, Non-Conformance Review Scheduled"
            query="Audit"
            type="html">
            Audit: #varAuditIdentifier#<br />
            Audit Report Posted: #dateformat(getFile.DatePosted, "mm/dd/yyyy")#<br /><br />
            
            Non-Conformance Review (by Technical AuditManager) Scheduled:<br />
            Due Date: #dateformat(NCReviewDueDate, "mm/dd/yyyy")#<br /><br />
            
            Please log in to the IQA Audit Database to view this audit.
        </cfmail>
	</cfif>
<!--- Non-Conformance Review Completed --->
<cfelseif URL.Action eq "Non-Conformance Review Completed">
	<!--- update TechnicalAudits_AuditSchedule table --->
    <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    NCReviewDate = #createODBCDate(curdate)#,
    NCReview = 'Yes',
    <cfset CurrentStep = "Assign Non-Conformances to Engineering Manager">
    Flag_CurrentStep = 'Assign Non-Conformances to Engineering Manager'
    
    WHERE
    ID = #URL.ID#
    AND Year_ = #URL.Year#
    </CFQUERY>
<!--- Engineering Manager Review Completed --->
<cfelseif URL.Action eq "Engineering Manager Review Completed">
	<!--- update TechnicalAudits_AuditSchedule table --->
    <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    EngManagerReview = 'Yes',
    EngManagerReviewDate = #createODBCDate(curdate)#,
    AppealExist = '#Form.YesNoItem#',
 
    <Cfset DueDate = DateAdd('d', 14, curdate)>

	 <cfif Form.YesNoItem eq "Yes">
	    AppealResponseDueDate = #createODBCDate(DueDate)#,
		<cfset CurrentStep = "Assignment of Appeals">
        Flag_CurrentStep = 'Assignment of Appeals'
	<cfelseif Form.YesNoItem eq "No">
    	NCEnteredAssignDueDate = #createODBCDate(DueDate)#,
    	<cfset CurrentStep = "Assignment of Non-Conformances Input">
        Flag_CurrentStep = 'Assignment of Non-Conformances Input'
    </cfif>
    
    WHERE
    ID = #URL.ID#
    AND Year_ = #URL.Year#
    </CFQUERY>
    
	<!--- get audit identifier, add flag_currentStep to end --->
    <CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT 
        *
    FROM 
        TechnicalAudits_AuditSchedule
    WHERE
        ID = #URL.ID#
        AND Year_ = #URL.Year#
    </cfquery>
    
    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ReportFileName, DatePosted
    FROM TechnicalAudits_ReportFiles
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND Flag_CurrentStep = 'Engineering Manager Review Completed'
    </cfquery>
    
    <!--- send email to TAM that report has been uploaded and NC Review is scheduled and due on NCReviewDuedate --->
    <!--- To field: Technical Audit Manager goes here --->
    <cfmail
    	to="#Request.TechnicalAuditManager#"
        from="Internal.Quality_Audits@ul.com"
        subject="Internal Technical Audits - Engineering Manager Review Completed"
        query="Audit"
        type="html">
        Audit: #varAuditIdentifier#<br />
        Step Completed: Engineering Manager Review Completed<br />
        File Posted: #dateformat(getFile.DatePosted, "mm/dd/yyyy")#<br /><br />
		
		<cfif Form.YesNoItem eq "Yes">
            <cfset CurrentStep = "Assignment of Appeals">
            <cfset CurrentDueDate = #dateformat(AppealAssignDueDate, "mm/dd/yyyy")#>
        <cfelseif Form.YesNoItem eq "No">
            <cfset CurrentStep = "Assignment of Non-Conformances Input">
            <cfset CurrentDueDate = #dateformat(NCEnteredAssignDueDate, "mm/dd/yyyy")#>
        </cfif>

        Required Action: #CurrentStep#<br />
        Due Date: #CurrentDueDate#<br /><br />
        
        Please log in to the IQA Audit Database to view this audit.
    </cfmail>
    <!--- /// --->
<!--- Appeal Response Completed --->
<cfelseif URL.Action eq "Appeal Response Completed">
	<!--- update TechnicalAudits_AuditSchedule table --->
    <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    AppealResponse = 'Yes',
    AppealResponseDate = #createODBCDate(curdate)#,
    <Cfset DueDate = DateAdd('d', 14, curdate)>
    
	AppealDecisionAssignDueDate = #createODBCDate(DueDate)#,
   	<cfset CurrentStep = "Assignment of Appeal Decision">
    Flag_CurrentStep = 'Assignment of Appeal Decision'
    
    WHERE
    ID = #URL.ID#
    AND Year_ = #URL.Year#
    </CFQUERY>
    
	<!--- get audit identifier, add flag_currentStep to end --->
    <CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT 
        *
    FROM 
        TechnicalAudits_AuditSchedule
    WHERE
        ID = #URL.ID#
        AND Year_ = #URL.Year#
    </cfquery>
    
    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ReportFileName, DatePosted
    FROM TechnicalAudits_ReportFiles
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND Flag_CurrentStep = 'Appeal Response Completed'
    </cfquery>
    
    <!--- send email to TAM that report has been uploaded and NC Entering is scheduled and due on NCReviewDuedate --->
    <!--- To field: Technical Audit Manager goes here --->
    <cfmail
    	to="#Request.TechnicalAuditManager#"
        from="Internal.Quality_Audits@ul.com"
        cc="#getROM.ROM#, #getROM.SQM#"
        subject="Internal Technical Audits - Appeal Response Completed"
        query="Audit"
        type="html">      
        Audit: #Identifier#<br />
        Step Completed: Appeal Response Completed<br />
        File Posted: #dateformat(getFile.DatePosted, "mm/dd/yyyy")#<br /><br />
		
       	Required Action: #CurrentStep#<br />
        Due Date: #dateformat(NCEnteredAssignDueDate, "mm/dd/yyyy")#<br /><br />
       
        Please log in to the IQA Audit Database to view this audit.
    </cfmail>
    <!--- /// --->
<!--- Appeal Decision Completed --->
<cfelseif URL.Action eq "Appeal Decision Completed">
	<!--- update TechnicalAudits_AuditSchedule table --->
    <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    NCExistPostAppeal = '#Form.YesNoItem#',
    AppealDecision = 'Yes',
    AppealResponseDate = #createODBCDate(curdate)#,
    <Cfset DueDate = DateAdd('d', 14, curdate)>
    
    <cfif Form.YesNoItem eq "Yes">
		NCEnteredAssignDueDate = #createODBCDate(DueDate)#,
	   	<cfset CurrentStep = "Assignment of Non-Conformance Input">
        Flag_CurrentStep = 'Assign Non-Conformance Input'
	<cfelseif Form.YesNoItem eq "No">
		<cfset CurrentStep = "Audit Closed">
        Flag_CurrentStep = 'Audit Closed',
        AuditClosed = 'Yes',
        AuditCloseddate = #createODBCDate(curdate)#,
        AuditClosedConfirm = 'No'
    </cfif>
    
    WHERE
    ID = #URL.ID#
    AND Year_ = #URL.Year#
    </CFQUERY>
    
	<!--- get audit identifier, add flag_currentStep to end --->
    <CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT 
        *
    FROM 
        TechnicalAudits_AuditSchedule
    WHERE
        ID = #URL.ID#
        AND Year_ = #URL.Year#
    </cfquery>
    
    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ReportFileName, DatePosted
    FROM TechnicalAudits_ReportFiles
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND Flag_CurrentStep = 'Appeal Response Completed'
    </cfquery>
    
    <!--- send email to TAM that report has been uploaded and NC Entering is scheduled and due on NCReviewDuedate --->
    <!--- To field: Technical Audit Manager goes here --->
    <cfmail
    	to="#Request.TechnicalAuditManager#"
        from="Internal.Quality_Audits@ul.com"
        cc="#getROM.ROM#, #getROM.SQM#"
        subject="Internal Technical Audits - Appeal Decision Completed"
        query="Audit"
        type="html">
        Audit: #Identifier#<br />
        Step Completed: Appeal Decision Completed<br />
        File Posted: #dateformat(getFile.DatePosted, "mm/dd/yyyy")#<br /><br />
		
		<cfif Form.YesNoItem eq "Yes">
            <cfset CurrentStep = "Assignment of Non-Conformance Input">
        	Required Action: #CurrentStep#<br />
	        Due Date: #dateformat(NCEnteredAssignDueDate, "mm/dd/yyyy")#<br /><br />
        <cfelseif Form.YesNoItem eq "No">
            <cfset CurrentStep = "Audit Closed">
            Note: No Non-Conformances Remain after Appeals<br />
            Status: Audit Ready to be Closed<br /><br />
        </cfif>
       
        Please log in to the IQA Audit Database to view this audit.
    </cfmail>
    <!--- /// --->
</cfif>

<cfset HistoryUpdate = "
<cfif URL.Action eq 'Audit Completed - Audit Report Posted'>
Audit Report Uploaded<Br />
	<cfif Form.YesNoItem eq 'No'>
		No Non-Conformances were found<br />
	</cfif>

<cfelseif URL.Action eq 'Engineering Manager Review Completed'>
Engineering Manager Review Completed<br />
	<cfif Form.YesNoItem eq 'No'>
		No Appeals<br />
	</cfif>

<cfelseif URL.Action eq 'Non-Conformance Review Completed'>
Non-Conformance Review Completed<br />

<cfelseif URL.Action eq 'Appeal Response Completed'>
Appeal Response Completed<br />

<cfelseif URL.Action eq 'Appeal Decision Completed'>
Appeal Decision Completed<br />
	<cfif Form.YesNoItem eq 'No'>
    	No Non-Conformances remain after the Appeal Decision<br />
        Audit Closed<br />
    </cfif>
</cfif>

Current Step: #CurrentStep#<br />
Action by: [Person]<br />
Date: #curdate# #curTime#
">

<!--- history update --->
<CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

History = <CFQUERYPARAM VALUE="#Audit.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

WHERE
ID = #URL.ID#
AND Year_ = #URL.Year#
</CFQUERY>

<cflocation url="TechnicalAudits_viewAuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#&Action=#URL.Action#" addtoken="no">

<cfelse>

<cfif isDefined("Form.Upload")>
	<b><font class="warning">Form Validation Issues</font></b><br />
   	<u>Audit Report Upload</u>: Please attach the file.<br />
    <cfif URL.Action eq "Audit Completed - Audit Report Posted" OR URL.Action eq "Appeal Decision Completed">
    	<cfset Item = "Non-Conformances">
	<cfelseif URL.Action eq "Engineering Manager Review Completed">
    	<cfset Item = "Appeals">
	</cfif>
   	<u>Are there <cfoutput>#Item#</cfoutput> from this Audit?</u>: Please select Yes or No<br /><br />
</cfif>

<Cfoutput>
    <form action="#CGI.Script_Name#?#CGI.Query_String#" enctype="multipart/form-data" method="post">
    Upload Audit Report:<br />
    <input type="File" size="50" name="File"><br><br />
    
    <cfif URL.Action eq "Audit Completed - Audit Report Posted">
        Are there Non-Conformances from this Audit?<Br />
        Yes <input type="checkbox" name="YesNoItem" value="Yes" /> No <input type="checkbox" name="YesNoItem" value="No" />
        <br /><br />
    <cfelseif URL.Action eq "Engineering Manager Review Completed">
    	Are there Appeals from this Audit?<br />
        Yes <input type="checkbox" name="YesNoItem" value="Yes" /> No <input type="checkbox" name="YesNoItem" value="No" />
        <br /><br />
    <cfelseif URL.Action eq "Appeal Decision Completed">
        After the Appeal Decision, do any Non-Conformances remain?<Br />
        Yes <input type="checkbox" name="YesNoItem" value="Yes" /> No <input type="checkbox" name="YesNoItem" value="No" />
        <br /><br />
	<cfelse>
    	<input type="hidden" name="YesNoItem" value="NA" />
    </cfif>
       
    <input type="Submit" name="upload" value="Upload Audit Report">
    </form>
</Cfoutput>

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->