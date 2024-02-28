<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
	*
FROM
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<!--- set replyTo address --->
<cfif len(Audit.TAM)>
	<cfset ReplyTo = "#Audit.TAM#">
<cfelse>
	<cfset ReplyTo = "#Request.TechnicalAuditMailbox#">
</cfif>

<cfif Audit.NCExistPostAppeal eq "No">
	<!--- EMAIL ID 17 / 17 a --->
	<cfset Step = "Audit Completed and Closed - No Non-Conformances Found After Appeals">
<cfelseif Audit.NCExist eq "No">
	<!--- EMAIL ID 16 / 16 a--->
	<cfset Step = "Audit Completed and Closed - No Non-Conformances Identified">
<cfelseif Audit.SRCARVerified eq "Yes">
	<!--- EMAIL ID 18 / 18 a --->
	<cfset Step = "Audit Completed and Closed - Corrective Actions Verified">
</cfif>

<cfif Step eq "Audit Completed and Closed - Corrective Actions Verified">
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

        <cfset Identifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#_#URL.Action#">
    </cfoutput>

	<!--- get file name from audit report upload --->
    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT ReportFileName, DatePosted
    FROM TechnicalAudits_ReportFiles
    WHERE AuditID = #URL.ID#
    AND AuditYear = #URL.Year#
    AND Flag_CurrentStep = 'Corrective Actions Verified'
    </cfquery>

    <!--- copy Audit Report Posted file to TempUpload --->
    <CFFILE action="copy"
        source="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#getFile.reportFileName#"
        destination="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\TempUpload\">

    <cfoutput>
    <cfset FindExtLocation = #Find(".", getFile.reportFileName)#>
    <cfset getExtLength = len(getFile.reportFileName) - FindExtLocation>
    <cfset getFileExt = "#right(getFile.reportFileName, getExtLength)#">
    </cfoutput>

    <!--- rename/move the file from TempUpload to audit folder and name it with current action --->
    <CFFILE action="rename"
        source="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\TempUpload\#getFile.reportFileName#"
        destination="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#Identifier#.#getFileExt#">

    <cfset NewFileName = "#Identifier#.#getFileExt#">

	<!---Actions taken regardless of file upload or not --->
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
    VALUES(#checkMaxID.maxID#, #URL.Year#, #URL.ID#, #CreateODBCDate(curdate)#, '<cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif>', '#NewFileName#', '#URL.Action#')
    </CFQUERY>
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

Flag_CurrentStep = '#Step#',
AuditClosedConfirmDate = #createODBCDate(curdate)#,
AuditClosedConfirm = 'Yes'

WHERE
ID = #URL.ID#
AND Year_ = #URL.Year#
</CFQUERY>

<CFQUERY Datasource="UL06046" NAME="History" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT History
FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID#
AND Year_ = #URL.Year#
</cfquery>

<cfset HistoryUpdate = "Current Step: #Step#<br>Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br>Date: #curdate# #curTime#">

<!--- history update --->
<CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
UPDATE TechnicalAudits_AuditSchedule
SET

History = <CFQUERYPARAM VALUE="#History.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

WHERE
ID = #URL.ID#
AND Year_ = #URL.Year#
</CFQUERY>

<cfif Audit.AuditType2 eq "Full" OR Audit.AuditType2 eq "In-Process">
    <CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT
        *
    FROM
        TechnicalAudits_AuditSchedule
    WHERE
        ID = #URL.ID#
        AND Year_ = #URL.Year#
    </cfquery>

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

	<cfif Audit.AuditType2 eq "Full">
        <cfset incTo = "#Audit.EngManagerEmail#, #replyTo#, #getROM.ROM#, #getROM.SQM#">
    <cfelse>
        <cfset incTo = "#Audit.EngManagerEmail#, #replyTo#">
    </cfif>

    <cfmail
        to="#incTo#"
        Subject="#Flag_CurrentStep#"
        from="#Request.TechnicalAuditMailbox#"
        replyto="#replyTo#"
        type="html"
        query="Audit">

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

        <cfset varAuditIdentifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#">

	<!--- No NCs OR No NCs after appeal --->
    <cfif NCExistPostAppeal eq "No" OR NCExist eq "No">
    <!--- EMAIL ID 16 / 16 a---><!--- EMAIL ID 17 / 17 a --->
        Congratulations!<br /><br />

        This email is notification that the <cfif AuditType2 eq "Full">Full<cfelseif AuditType2 eq "In-Process">In-Process</cfif> Internal Technical Audit identified below has been completed and closed. The results of the project audit demonstrated full compliance.<br /><br />

        A detailed review and analysis was conducted in order to determine that the supporting documents, data recording and /or decision granting certification fulfilled UL requirements and were technically correct.<br /><br />

        Project Number: #ProjectNumber#<br /><br />

        Click below to open the audit: #varAuditIdentifier#<br />
        <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

		Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

        On behalf of UL, we thank you for the valuable and continued contributions.<br /><br />

        Regards,<br /><br />

        Technical Audit Team<br /><br />

        #ReplyTo# (Technical Audit Manager)<Br />
        <cfif AuditType2 eq "Full">
            #getROM.ROM# (Regional Operations Manager)<br />
            #getROM.SQM# (Site Quality Manager)
    	</cfif>
    <!--- Corrective Actions Verified --->
    <cfelseif Audit.SRCARVerified eq "Yes">
    <!--- EMAIL ID 18 / 18 a --->
        Greetings,<br /><br />

        This email is notification that the <cfif AuditType2 eq "Full">Full<cfelseif AuditType2 eq "In-Process">In-Process</cfif> Technical Audit identified below has been completed and closed.<br /><br />

        We verified the corrective actions related to the non-conforming items and deemed the actions as effective. As such, we are closing this audit.<br /><br />

        Click below to open the audit: #varAuditIdentifier#<br />
        <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

		Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

		On behalf of UL, we thank you for the valuable and continued contributions.<br /><br />

        Regards,

        #ReplyTo# (Technical Audit Manager)<Br />
        <cfif AuditType2 eq "Full">
            #getROM.ROM# (Regional Operations Manager)<br />
            #getROM.SQM# (Site Quality Manager)
    	</cfif>
    </cfif>
    </cfmail>
</cfif>

<cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">