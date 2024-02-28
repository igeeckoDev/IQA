<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - Upload Revised Audit Report">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<!--- Audit Info --->
<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<!--- set replyTo address for TAM --->
<cfif len(Audit.TAM)>
	<cfset TAMEmail = "#Audit.TAM#">
<cfelse>
	<cfset TAMEmail = "#Request.TechnicalAuditMailbox#">
</cfif>

<!---
<cfif URL.Action eq "Audit Executed - Audit Report Posted">
	<cfif Audit.NCExist eq "Yes">
    	<cfset DueDateFieldLabel = "Non-Conformance Review">
    	<cfset DueDateFieldName = "Audit.NCReviewDueDate">
		<cfset DueDateField = "dateformat(Audit.NCReviewDueDate, 'mm/dd/yyyy')">
        <cfset EmailRecipients = "#TAMEmail#">
	<cfelse>
    	<cfset DueDateField = "">
    </cfif>
<cfelseif URL.Action eq "Non-Conformance Review Completed">
	<cfset DueDateFieldLabel = "Engineering Manager Review">
	<cfset DueDateFieldName = "Audit.EngManagerDueDate">
	<cfset DueDateField = "dateformat(Audit.EngManagerDueDate, 'mm/dd/yyyy')">
    <cfset EmailRecipients = "#Audit.EngManagerEmail#">
<cfelseif URL.Action eq "Engineering Manager Review Completed">
	<cfif Audit.AppealExist eq "Yes">
    	<!--- assigned --->
	    <cfif Audit.AppealAssign eq "Yes">
			<cfset DueDateFieldLabel = "Appeal Response">
            <cfset DueDateFieldName = "Audit.AppealResponseDueDate">
            <cfset DueDateField = "dateformat(Audit.AppealResponseDueDate, 'mm/dd/yyyy')">
            <cfset EmailRecipients = "">
        <!--- not assigned --->
		<cfelse>
			<cfset DueDateFieldLabel = "Appeal Assignment">
            <cfset DueDateFieldName = "Audit.AppealAssignDueDate">
            <cfset DueDateField = "dateformat(Audit.AppealAssignDueDate, 'mm/dd/yyyy')">
            <cfset EmailRecipients = "#Audit.AppealAssign#">
        </cfif>
	<cfelse>
    	<cfset DueDateFieldLabel = "Non-Conformance Assignment">
    	<cfset DueDateFieldName = "Audit.NCEnteredAssignDueDate">
    	<cfset DueDateField = "dateformat(Audit.NCEnteredAssignDueDate, 'mm/dd/yyyy')">
        <cfset EmailRecipients = "">
    </cfif>
<cfelseif URL.Action eq "Appeal Response Completed">
	<cfset DueDateFieldLabel = "Appeal Decision">
	<cfset DueDateFieldName = "Audit.AppealDecisionDueDate">
	<cfset DueDateField = "dateformat(Audit.AppealDecisionDueDate, 'mm/dd/yyyy')">
    <cfset EmailRecipients = "">
<cfelseif URL.Action eq "Appeal Decision Completed">
	<cfif len(Audit.NCEnteredAssign) AND Audit.NCEnteredAssign EQ "Yes">
    	<cfset DueDateFieldLabel = "Non-Conformance Input">
		<cfset DueDateFieldName = "Audit.NCEnteredDueDate">
		<cfset DueDateField = "dateformat(Audit.NCEnteredDueDate, 'mm/dd/yyyy')">
        <cfset EmailRecipients = "">
    <cfelse>
    	<cfset DueDateField = "">
	</cfif>
<cfelseif URL.Action eq "Non-Conformance Input Completed">
	<cfif AuditType2 eq "Full">
		<cfset DueDateFieldLabel = "Corrective Actions Closure Information">
        <cfset DueDateFieldName = "Audit.SRCARClosedDueDate">
        <cfset DueDateField = "dateformat(Audit.SRCARClosedDueDate, 'mm/dd/yyyy')">
        <cfset EmailRecipients = "">
	<cfelse>
		<cfset DueDateField = "">
	</cfif>    
<cfelseif URL.Action eq "Corrective Actions Completed">
	<cfset DueDateFieldLabel = "Corrective Actions Verification Information">
	<cfset DueDateFieldName = "Audit.SRCARVerifiedDueDate">
	<cfset DueDateField = "dateformat(Audit.SRCARVerifiedDueDate, 'mm/dd/yyyy')">
    <cfset EmailRecipients = "">  
<cfelseif URL.Action eq "Corrective Actions Verified" OR URL.Action CONTAINS "Audit Completed and Closed">
	<cfset DueDateField = "">
</cfif>
--->

<!--- Audit Identifier --->
<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<!--- Current Action --->
<b>Current Action</b><br />
<cfoutput>
#URL.Action#<br /><br />
</cfoutput>

<cfif isDefined("Form.Upload")>
    <!--- get ROM/SQM --->
    <cfquery Datasource="UL06046" name="getROM" username="#OracleDB_Username#" password="#OracleDB_Password#"> 
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
          
    <!--- get file name that is being renamed --->
    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#" maxrows="1">
    SELECT *
    FROM TechnicalAudits_ReportFiles
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    <cfif URL.Action CONTAINS "Audit Completed and Closed">
        <cfif Audit.NCExistPostAppeal eq "No">
			<cfset Step = "Non-Conformance Review Completed">
        <cfelseif Audit.NCExist eq "No">
           	<cfset Step = "Audit Executed - Audit Report Posted">
		<cfelseif Audit.AuditType2 eq "In-Process">
            <cfset Step = "Non-Conformance Input Completed">
        <cfelseif Audit.SRCARVerified eq "Yes">
            <cfset Step = "Corrective Actions Verified">
        </cfif>
        
        AND Flag_CurrentStep = '#Step#'
    	ORDER BY ID DESC
    <cfelse>
		AND Flag_CurrentStep = '#URL.Action#'
    </cfif>
    </cfquery>
    
    <cfdump var="#getFile#">
  
    <!--- create identifier which will be the NEW file name --->
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
        
        <cfset ReviewLoc = #right(ProjectHandlerDept, 3)#>
    
        <cfset Identifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#_#getFile.Flag_CurrentStep#">
    </cfoutput>
    
    <cfset CurrentStep = "#getFile.Flag_CurrentStep#">
      
    <cfoutput>
        <cfset FindExtLocation = #Find(".", getFile.reportFileName)#>
        <cfset getExtLength = len(getFile.reportFileName) - FindExtLocation>
        <cfset getFileExt = "#right(getFile.reportFileName, getExtLength)#">
        <cfset ReplacedFileName = "#Identifier#-ReplacedOn-#dateformat(now(), 'mmddyyyy')#-#timeformat(now(), 'hhmmss')#.#getFileExt#">
    </cfoutput>
    
    <cfset newFileName = "#Identifier#.#getFileExt#">
    
	<!--- add new file to database --->
    <!--- get maxID --->
    <CFQUERY BLOCKFACTOR="100" NAME="checkMaxID" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT Max(ID)+1 as maxID
    FROM TechnicalAudits_ReportFiles
    </CFQUERY>
    
    <cfif NOT len(checkMaxID.MaxID)>
        <cfset checkMaxID.maxID = 1>
    </cfif>
    
    <!--- update TechnicalAudits_ReportFiles table --->
    <CFQUERY BLOCKFACTOR="100" NAME="ReportFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    INSERT INTO TechnicalAudits_ReportFiles(ID, AuditYear, AuditID, DatePosted, PostedBy, Flag_CurrentStep, RevisionDetails)
    VALUES(#checkMaxID.maxID#, #URL.Year#, #URL.ID#, #CreateODBCDateTime(now())#, '<cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif>', '#getFile.Flag_CurrentStep#', <CFQUERYPARAM VALUE="#Form.RevisionDetails#" CFSQLTYPE="CF_SQL_CLOB">)
    </CFQUERY>
    
	<cfset HistoryUpdate = "<b>Audit Report Revised - New File Uploaded</b><br>Current Step: #Audit.Flag_CurrentStep#<br>Notes: #Form.RevisionDetails#<br>Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br>Date: #curdate# #curTime#">
    
    <!--- history update --->
    <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_AuditSchedule
    SET
    
    History = <CFQUERYPARAM VALUE="#Audit.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">
    
    WHERE
    ID = #URL.ID#
    AND Year_ = #URL.Year#
    </CFQUERY>
    
    <!--- rename the current file --->
    <CFFILE action="rename"
        source="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#getFile.reportFileName#"
        destination="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#ReplacedFileName#">
    
    <!--- rename file in db --->
    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_ReportFiles
    SET
    ReportFileName = '#ReplacedFileName#'
    WHERE ID = #getFile.ID#
    </cfquery>
    
    <!--- upload new file --->
        <!--- upload file to temp location --->
        <CFFILE ACTION="UPLOAD" 
            FILEFIELD="Form.File" 
            DESTINATION="#IQARootPath#TechAuditReports\TempUpload\" 
            NAMECONFLICT="OVERWRITE">

        <!---- set the path and set file name, using cffile.serverfileext from cffile above --->
        <cfset destination="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#newFileName#">
        
        <!--- upload file to destination--->
        <cffile action="upload" filefield="file" destination="#destination#" nameconflict="Overwrite">
    
    <!--- update TechnicalAudits_ReportFiles table --->
    <CFQUERY BLOCKFACTOR="100" NAME="ReportFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    UPDATE TechnicalAudits_ReportFiles
    SET 
    ReportFileName = '#newFileName#'
    WHERE ID = #checkMaxID.maxID#
    </CFQUERY>
    
	<cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">    
    
<!--- form not submitted --->
<cfelse>
	<Cfoutput>
    <!--- included for Form Validation and Formatted Form Textarea boxes --->
    <!--- form name and id must be "myform" --->
    <cfinclude template="#SiteDir#SiteShared/incValidator.cfm">
    
        <cfform action="#CGI.Script_Name#?#CGI.Query_String#" enctype="multipart/form-data" method="post" name="myform" id="myform">
        Audit Report File:<br />
        <cfinput 
            type="File" 
            size="50" 
            name="File"
            data-bvalidator="required" 
            data-bvalidator-msg="Audit Report File"><br><br />

        Revision Details:<Br>
        <cftextarea 
            name="RevisionDetails" 
            cols="60" 
            rows="4"
            data-bvalidator="required" 
            data-bvalidator-msg="Revision Details">No Comments Added</cftextarea>
    
        <input type="submit" name="upload" value="Submit Form and Continue">
        <input type="reset" name="upload" value="Reset Form"><br /><br />
        </cfform>
    </Cfoutput>
    
<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->