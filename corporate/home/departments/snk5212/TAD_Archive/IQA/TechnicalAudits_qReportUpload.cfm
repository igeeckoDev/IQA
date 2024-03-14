<cfif isDefined("Form.DueDate")>
	<!--- not a future date, go back to the form --->
	<cfif Form.DueDate lte curdate>
    	<cfif URL.Action eq "Corrective Actions Verified" AND Form.YesNoItem EQ "Yes">
        	<!--- do nothing, date is irrelevant --->
		<cfelse>
	    	<cflocation url="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&msg=The Due Date must be a future date" addtoken="no">
		</cfif>
   </cfif>
</cfif>

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
    <cfset AssignTaskTo = ReplyTo>
<cfelse>
	<cfset ReplyTo = "#Request.TechnicalAuditMailbox#">
    <cfset AssignTaskTo = "Technical Audit Manager">
</cfif>

<cfinclude template="TechnicalAudit_incAuditIdentifier.cfm">

<b>Current Action</b><br />
<cfoutput>
#URL.Action#<br /><br />
</cfoutput>

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

	<cfset ReviewLoc = #right(ProjectHandlerDept, 3)#>

    <cfset Identifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#_#URL.Action#">
    <cfset NotVerified_Identifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#_Corrective Actions Completed">
    <cfset NotCompleted_Identifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#_Non-Conformance Input Completed">
</cfoutput>

<!--- Review w/o file upload --->
<cfif isDefined("Form.Upload")>
	<cfif isDefined("Form.YesNoItem")>
    	<cfif URL.Action eq "Non-Conformance Review Completed" AND Form.YesNoItem eq "No">
			<!--- current file is copied and renamed since there are "no changes" to these files from the previous states --->
            <!--- get file name from audit report upload --->
            <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ReportFileName, DatePosted
            FROM TechnicalAudits_ReportFiles
            WHERE AuditID = #URL.ID#
            AND AuditYear = #URL.Year#
                <cfif URL.Action eq "Non-Conformance Review Completed">
                    AND Flag_CurrentStep = 'Audit Executed - Audit Report Posted'
                <cfelseif URL.Action eq "Engineering Manager Review Completed">
                    AND Flag_CurrentStep = 'Non-Conformance Review Completed'
                </cfif>
            </cfquery>

            <!--- copy Audit Report Posted file to TempUpload --->
            <CFFILE action="copy"
                source="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#getFile.reportFileName#"
                destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\TempUpload\">

            <cfoutput>
                <cfset FindExtLocation = #Find(".", getFile.reportFileName)#>
                <cfset getExtLength = len(getFile.reportFileName) - FindExtLocation>
                <cfset getFileExt = "#right(getFile.reportFileName, getExtLength)#">
            </cfoutput>

            <!--- rename/move the file from TempUpload to audit folder and name it with current action (Non-Conformance Review Completed) --->
            <CFFILE action="rename"
                source="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\TempUpload\#getFile.reportFileName#"
                destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#Identifier#.#getFileExt#">

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
        <cfelse>
			<!--- all other cases involve uploading a file--->
            <!--- no file --->
            <cfif NOT Len(FORM.File)>
                <cflocation url="TechnicalAudits_ReportUpload.cfm?ID=#URL.ID#&Year=#URL.Year#&Action=#URL.Action#&msg=Please Attach the Audit Report File" addtoken="no">
            <!--- file exists --->
			<cfelse>
            	<cfif URL.Action eq "Corrective Actions Verified" AND Form.YesNoItem eq "No">
                	<!--- get file name from audit report upload --->
                    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                    SELECT ReportFileName, DatePosted, ID
                    FROM TechnicalAudits_ReportFiles
                    WHERE AuditID = #URL.ID#
                    AND AuditYear = #URL.Year#
                    AND Flag_CurrentStep = 'Corrective Actions Completed'
                    </cfquery>

					<cfoutput>
						<cfset FindExtLocation = #Find(".", getFile.reportFileName)#>
                        <cfset getExtLength = len(getFile.reportFileName) - FindExtLocation>
                        <cfset getFileExt = "#right(getFile.reportFileName, getExtLength)#">
                        <cfset ReplacedFileName = "#NotVerified_Identifier#-ReplacedOn-#dateformat(now(), 'mmddyyyy')#-#timeformat(now(), 'hhmmss')#.#getFileExt#">
                    </cfoutput>

                    <!--- rename the current file --->
                    <CFFILE action="rename"
                        source="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#getFile.reportFileName#"
                        destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#ReplacedFileName#">

					<!--- rename file in db --->
                    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                    UPDATE TechnicalAudits_ReportFiles
                    SET
                    ReportFileName = '#ReplacedFileName#'
                    WHERE ID = #getFile.ID#
                    </cfquery>

					<!--- upload file to temp location --->
                    <CFFILE ACTION="UPLOAD"
                        FILEFIELD="Form.File"
                        DESTINATION="#IQARootPath#TechAuditReports\TempUpload\"
                        NAMECONFLICT="OVERWRITE">

                    <!---- set the path and set file name, using cffile.serverfileext from cffile above --->
                    <!--- upload corrective actions completed file - with new information --->
                    <cfset destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#NotVerified_Identifier#.#cffile.ServerFileExt#">

                    <cfset newFileName = "#NotVerified_Identifier#.#cffile.ServerFileExt#">

                    <!--- upload file to destination--->
                    <cffile action="upload" filefield="file" destination="#destination#" nameconflict="Overwrite">

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
                    INSERT INTO TechnicalAudits_ReportFiles(ID, AuditYear, AuditID, DatePosted, PostedBy, Flag_CurrentStep, RevisionDetails, ReportFileName)
                    VALUES(#checkMaxID.maxID#, #URL.Year#, #URL.ID#, #CreateODBCDateTime(now())#, '<cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif>', 'Corrective Actions Completed', 'Corrective Actions NOT Verified - Uploading new Corrective Actions Completed File', '#NotVerified_Identifier#.#cffile.ServerFileExt#')
                    </CFQUERY>

				<!--- Corrective Actions Completed = No --->
				<cfelseif URL.Action eq "Corrective Actions Completed" AND Form.YesNoItem eq "No">
                	<!--- get file name from audit report upload --->
                    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                    SELECT ReportFileName, DatePosted, ID
                    FROM TechnicalAudits_ReportFiles
                    WHERE AuditID = #URL.ID#
                    AND AuditYear = #URL.Year#
                    AND Flag_CurrentStep = 'Non-Conformance Input Completed'
                    </cfquery>

					<cfoutput>
						<cfset FindExtLocation = #Find(".", getFile.reportFileName)#>
                        <cfset getExtLength = len(getFile.reportFileName) - FindExtLocation>
                        <cfset getFileExt = "#right(getFile.reportFileName, getExtLength)#">
                        <cfset ReplacedFileName = "#NotCompleted_Identifier#-ReplacedOn-#dateformat(now(), 'mmddyyyy')#-#timeformat(now(), 'hhmmss')#.#getFileExt#">
                    </cfoutput>

                    <!--- rename the current file --->
                    <CFFILE action="rename"
                        source="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#getFile.reportFileName#"
                        destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#ReplacedFileName#">

					<!--- rename file in db --->
                    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                    UPDATE TechnicalAudits_ReportFiles
                    SET
                    ReportFileName = '#ReplacedFileName#'
                    WHERE ID = #getFile.ID#
                    </cfquery>

					<!--- upload file to temp location --->
                    <CFFILE ACTION="UPLOAD"
                        FILEFIELD="Form.File"
                        DESTINATION="#IQARootPath#TechAuditReports\TempUpload\"
                        NAMECONFLICT="OVERWRITE">

                    <!---- set the path and set file name, using cffile.serverfileext from cffile above --->
                    <!--- upload corrective actions completed file - with new information --->
                    <cfset destination="#request.applicationFolder#\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#NotCompleted_Identifier#.#cffile.ServerFileExt#">

                    <cfset newFileName = "#NotCompleted_Identifier#.#cffile.ServerFileExt#">

                    <!--- upload file to destination--->
                    <cffile action="upload" filefield="file" destination="#destination#" nameconflict="Overwrite">

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
                    INSERT INTO TechnicalAudits_ReportFiles(ID, AuditYear, AuditID, DatePosted, PostedBy, Flag_CurrentStep, RevisionDetails, ReportFileName)
                    VALUES(#checkMaxID.maxID#, #URL.Year#, #URL.ID#, #CreateODBCDateTime(now())#, '<cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif>', 'Non-Conformance Input Completed', 'Corrective Actions NOT Completed - Uploading new Non-Conformance Input Completed File', '#NotCompleted_Identifier#.#cffile.ServerFileExt#')
                    </CFQUERY>
				<cfelse>
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
			</cfif>
		</cfif>
	<!--- yes no item if is still open --->

		<!--- Audit Executed - Audit Report Posted --->
        <cfif URL.Action eq "Audit Executed - Audit Report Posted">
            <!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET

            NCExist = '#Form.YesNoItem#',
            ReportPostedDate = #createODBCDate(curdate)#,
            ReportPosted = 'Yes',
            <cfset Flag_CurrentStep = "Audit Executed - Audit Report Posted">
            Flag_CurrentStep = 'Audit Executed - Audit Report Posted',

            <cfif FORM.YesNoItem eq "Yes">
            	<Cfset DueDate = DateAdd('d', 14, curdate)>
                CurrentDueDate = #createODBCDate(DueDate)#,
    			CurrentDueDateField = 'NCReviewDueDate',
                NCReviewDueDate = #createODBCDate(DueDate)#
            <cfelseif FORM.YesNoItem eq "No">
                AuditClosed = 'Yes',
                AuditClosedDate = #createODBCDate(curdate)#,
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
            AND Flag_CurrentStep = 'Audit Executed - Audit Report Posted'
            </cfquery>


			<!--- cc field --->
            <cfif Audit.AuditType2 eq "Full">
                <cfset incCC = "#Audit.ROM#">
            <cfelseif Audit.AuditType2 eq "In-Process">
                <cfset incCC = "">
            </cfif>

            <!--- No NCs --->
            <cfif Form.YesNoItem eq "No">
				<!--- send email to TAM/etc that report has been uploaded and NC Review is scheduled and due on NCReviewDuedate --->

                <!--- EMAIL ID 5 / 5a --->

                <cfmail
                    to="#Request.TechnicalAuditMailbox#"
                    from="#Request.TechnicalAuditMailbox#"
                    cc="#incCC#, #ReplyTo#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Audit Report Posted, No Non-Conformances Identified - Audit Ready to be Closed"
                    query="Audit"
                    type="html">
                	Greetings,<br /><br />

                    This email is notification that the auditor has posted an audit without nonconformances or "Cannot be determined" items identified. This audit is now ready to close.<br /><br />

                    Click below to open the audit:<br />
                    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit</a><br><br>

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>
				</cfmail>
            <!--- NCs / CNBDs Exist --->

            <!--- EMAIL ID 4 and 4a --->

            <cfelseif Form.YesNoItem eq "Yes">
            	<cfmail
                to="#Request.TechnicalAuditMailbox#"
                from="#Request.TechnicalAuditMailbox#"
                cc="#incCC#, #ReplyTo#"
                subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Audit Report Posted, Non-Conformance Review Assigned"
                query="Audit"
                type="html">
                    This is notification that the audit report has been posted and you have been assigned the review of that report. <br /><br />

                    Task Assigned To:<br />
                    #AssignTaskTo# (Technical Audit Manager)<cfif Audit.AuditType2 eq "Full"><br />
                    #ROM# (Regional Operations Manager)</cfif><br /><br />

                    Click below to open the audit:<br />
                    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit</a><br /><br />

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

                    This task has a due date of: #dateformat(NCReviewDueDate, "mm/dd/yyyy")#
				</cfmail>
    		</cfif>
        </cfif>

		<!--- Non-Conformance Review Completed --->
        <cfif URL.Action eq "Non-Conformance Review Completed">
            <!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET

            NCReviewDate = #createODBCDate(curdate)#,
            NCReview = 'Yes',

            <cfset DueDate = Form.DueDate>

            CurrentDueDate = #createODBCDate(DueDate)#,
            CurrentDueDateFIeld = 'EngManagerDueDate',
            EngManagerDueDate = #CreateODBCDate(DueDate)#,
            EngManagerDate = #CreateODBCDate(curDate)#,
            EngManagerAssign = 'Yes',

            <cfset Flag_CurrentStep = "Non-Conformance Review Completed">
            Flag_CurrentStep = 'Non-Conformance Review Completed'

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

            <cfset HistoryUpdate =
            "Non-Conformance Assignment Letter Sent to #Audit.EngManagerEmail# (Engineering Manager): #dateformat(curdate, 'mm/dd/yyyy')#<br />
                Due Date: #dateformat(DueDate, 'mm/dd/yyyy')#<br />
                Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br />
                Date: #curdate# #curTime#">

            <cfmail
                to="#Audit.EngManagerEmail#"
                from="#Request.TechnicalAuditMailbox#"
                cc="#ReplyTo#"
                replyto="#ReplyTo#"
                subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Audit Non-Conformance Assignment"
                query="Audit"
                type="HTML">

                <Cfset DueDate = Form.DueDate>

                <!---- EMAIL ID 6 / 6a --->

                <cfinclude template="TechnicalAudits_EmailText_AssignNCs.cfm">
            </cfmail>
        </cfif>

		<!--- Engineering Manager Review Completed --->
        <cfif URL.Action eq "Engineering Manager Review Completed">
            <cfset Flag_CurrentStep = "Engineering Manager Review Completed">

            <!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET

            <cfif Form.YesNoItem NEQ "Yes">
            	<cfset varAppealsExist = "No">
            <cfelse>
            	<cfset varAppealsExist = "Yes">
            </cfif>

            EngManagerReview = 'Yes',
            EngManagerReviewDate = #createODBCDate(curdate)#,
            AppealExist = '#varAppealsExist#',

            <Cfset DueDate = DateAdd('d', 14, curdate)>

				<cfif Form.YesNoItem eq "NoSR">
                    <!--- 4 weeks / 28 days --->
                    <Cfset SRCARDueDate = DateAdd('d', 28, curdate)>
                    <cfset SRCARType = "SR">

					<!--- set SRCARClosedDueDate --->
                    SRCARType = '#SRCARType#',
                    SRCARClosedDueDate = #createODBCDate(SRCARDueDate)#,
                <!--- /// --->
                <cfelseif Form.YesNoItem eq "NoCAR">
                    <!--- 12 weeks / 84  days --->
                    <Cfset SRCARDueDate = DateAdd('d', 84, curdate)>
                    <cfset SRCARType = "CAR">

					<!--- set SRCARClosedDueDate --->
                    SRCARType = '#SRCARType#',
                    SRCARClosedDueDate = #createODBCDate(SRCARDueDate)#,
                </cfif>

			<cfif Form.YesNoItem eq "Yes">
                CurrentDueDate = #createODBCDate(DueDate)#,
                CurrentDueDateField = 'AppealAssignDueDate',
                AppealAssignDueDate = #createODBCDate(DueDate)#,
                Flag_CurrentStep = 'Engineering Manager Review Completed'
            <cfelseif Form.YesNoItem eq "NoCAR" OR Form.YesNoItem eq "NoSR" OR Form.YesNoItem eq "No">
                CurrentDueDate = #createODBCDate(DueDate)#,
                CurrentDueDateField = 'NCEnteredDueDate',
                NCExistPostAppeal = 'Yes',
                NCEnteredDueDate = #createODBCDate(DueDate)#,
                NCEnteredAssignDate = #createODBCDate(curdate)#,

				<cfif Audit.AuditType2 eq "Full">
                    <cfset AssignedTo = "#getROM.SQM#">
                <cfelseif Audit.AuditType2 eq "In-Process">
                    <cfset AssignedTo = "#ReplyTo#">
                </cfif>

				<!--- sqm for full and tam/deputy for in-process --->
				NCEnteredAssignEmail = '#AssignedTo#',
				<!--- /// --->

				NCEnteredAssign = 'Yes',
                NCEnteredAssignDueDate = #createODBCDate(DueDate)#,
                Flag_CurrentStep = 'Engineering Manager Review Completed'
            </cfif>

            WHERE
            ID = #URL.ID#
            AND Year_ = #URL.Year#
            </CFQUERY>

			<cfif isDefined("SRCARDueDate")>
                <!--- update TechnicalAudits_SRCAR table --->
                <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                UPDATE TechnicalAudits_SRCAR
                SET

                SRCARClosedDueDate = #createODBCDate(SRCARDueDate)#

                WHERE AuditID = #URL.ID#
                AND AuditYear = #URL.Year#
                </CFQUERY>
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

            <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ReportFileName, DatePosted
            FROM TechnicalAudits_ReportFiles
            WHERE AuditID = #URL.ID#
            AND AuditYear = #URL.Year#
            AND Flag_CurrentStep = 'Engineering Manager Review Completed'
            </cfquery>

            <!--- email to tam, rom that eng manager review has been completed, and either appeals need to be assigned (tam/rom) OR nc input has been auto-assigned --->
            <cfif Form.YesNoItem eq "Yes">

				<cfif Audit.AuditType2 eq "Full">
                    <cfset incTO = "#Audit.ROM#">
                    <cfset incCC = "#ReplyTo#, #getROM.SQM#">
                <cfelseif Audit.AuditType2 eq "In-Process">
                    <cfset incTO = "#ReplyTo#">
                </cfif>

                <!--- EMAIL ID 7 AND 7a --->

                <cfmail
                    to="#incTO#"
                    from="#Request.TechnicalAuditMailbox#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Engineering Manager Review Completed - Appeals Identified"
                    replyto="#ReplyTo#"
                    query="Audit"
                    type="html">
                    Greetings,<br /><br />

                    This is notification that the Engineering Manager has posted the audit summary report, which has appleals and/or responses to items where the auditor was unable to determine compliance.<br /><br />

                    Please proceed with assigning the Appeal Response to a PDE/RLR/SME.<br /><br />

					Click below to open the audit: #varAuditIdentifier#<br />
					<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

                    <cfset CurrentDueDate = #dateformat(AppealAssignDueDate, "mm/dd/yyyy")#>
                    <cfset Email_CurrentStep = "Assignment of Appeals / Appeal Response">

                    <cfif Audit.AuditType2 eq "Full">
                        Task Assigned to: #ROM# (Regional Operations Manager)<br />
                        Please work with #getROM.SQM# (Site Quality Manager) to accomplish this task.<br />
                        Note: The TAM can also complete this task: #AssignTaskTo#<br />
                    <cfelseif Audit.AuditType2 eq "In-Process">
	                    Task Assigned To: #AssignTaskTo# (Technical Audit Manager)<br />
                    </cfif><br />

                    Required Action: #Email_CurrentStep#<br /><Br />

					This Appeal Assignment to the PDE/RLR/SME has a due date of #dateformat(CurrentDueDate, "mm/dd/yyyy")#
                </cfmail>

			<!--- NC Input Assigned Email --->
            <cfelseif Form.YesNoItem eq "NoSR" OR Form.YesNoItem eq "NoCAR" OR Form.YesNoItem eq "No">
                 <cfif Audit.AuditType2 eq "Full">
                    <cfset incTO = "#ReplyTo#, #Audit.ROM#, #getROM.SQM#">
                <cfelseif Audit.AuditType2 eq "In-Process">
                    <cfset incTO = "#ReplyTo#">
                </cfif>

                <!--- EMAIL ID 8 and 8a --->

                <cfmail
                    to="#incTO#"
                    from="#Request.TechnicalAuditMailbox#"
                    replyTo="#ReplyTo#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Engineering Manager Review Completed - No Appeals"
                    query="Audit"
                    type="html">
                    This e-mail is notification that the Engineering Manager has posted the audit summary report without any appeals and/or responses to items that compliance could not be determined.<br /><br />

					You have been assigned the task of inputting the noncoformance(s) into the Technical Audit Database.<Br /><br />

                    <cfif Audit.AuditType2 eq "Full">
                    Task Assigned To: #getROM.SQM# (Site Quality Manager)
                    <cfelseif Audit.AuditType2 eq "In-Process">
                    Task Assigned To: #ReplyTo# (Technical Audit Manager)
                    </cfif><br /><br />

                    This task has a due date of: #dateformat(NCEnteredDueDate, "mm/dd/yyyy")#<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />
					<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>
                </cfmail>

                <cfif Form.YesNoItem eq "NoSR" OR Form.YesNoItem eq "NoCAR">
                	<!--- EMAIL ID 13 and 13a --->
                    <cfif Audit.AuditType2 eq "Full">
                    	<cfset incTO = "#ReplyTo#, #getROM.SQM#">
                	<cfelseif Audit.AuditType2 eq "In-Process">
                    	<cfset incTO = "#ReplyTo#">
                	</cfif>

                    <cfmail
                        to="#Audit.EngManagerEmail#, #incTO#"
                        replyto="#ReplyTo#"
                        from="#Request.TechnicalAuditMailbox#"
                        subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Due Date for Corrective Actions to be Completed"
                        query="Audit"
                        type="html">
                        Greetings,<br /><br />

                        This email is notification that item(s) of nonconformance remain. Please work with the <cfif Audit.AuditType2 eq "Full">Project Reviewer and the Site Quality Manager (SQM)<cfelseif Audit.AuditType2 eq "In-Process">Project Evaluator</cfif> on the corrective action and provide notification when complete.<br /><br />

                        Tasks Assigned to: #Audit.EngManagerEmail# (Engineering Manager)<br /><br />

                        <cfif Audit.AuditType2 eq "Full">
                        Any SRs associated with the corrective actions need to be communicated to the Site Quality Manager and provide notification when complete.<br /><br />
                        </cfif>

                        Due Date for the Corrective Action(s) to be completed: #dateformat(SRCARDueDate, "mm/dd/yyyy")#.<br /><br />

                        Click below to open the audit: #varAuditIdentifier#<br />
                		<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

						Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

                        For more information about this request, Training, OTL, or recording your hours spent, please refer to the Technical Audit Database Job Aid - <a href="http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/00-QA-J0413/00-QA-J0413.docx">00-QA-J0413</a>.<br /><br />

                        Should you have any questions, please contact any member of the audit team identified below.<br /><br />

                        Regards,<br /><br />

                        Technical Audit Team<br /><br />

                        #ReplyTo# (Technical Audit Manager)<Br />
                        <cfif Audit.AuditType2 eq "Full">
                        #getROM.SQM# (Site Quality Manager)
                        </cfif>
                    </cfmail>
                </cfif>
            </cfif>
		</cfif>

		<!--- Appeal Response Completed --->
        <cfif URL.Action eq "Appeal Response Completed">
            <!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET

            <Cfset DueDate = DateAdd('d', 14, curdate)>

            AppealResponse = 'Yes',
            AppealResponseDate = #createODBCDate(curdate)#,
            AppealDecisionAssign = 'Yes',
            AppealDecisionAssignDate = #createODBCDate(curdate)#,
            AppealDecisionDueDate = #createODBCDate(DueDate)#,

            CurrentDueDate = #createODBCDate(DueDate)#,
          	CurrentDueDateFIeld = 'AppealDecisionDueDate',
            <cfif Audit.AuditType2 eq "Full">
                AppealDecisionEmail = '#getROM.SQM#',
            <cfelseif Audit.AuditType2 eq "In-Process">
                AppealDecisionEmail = '#ReplyTo#',
            </cfif>

            <!---
            AppealDecisionAssignDueDate = #createODBCDate(DueDate)#,
            --->

            <cfset Flag_CurrentStep = "Appeal Response Completed">
            Flag_CurrentStep = 'Appeal Response Completed'

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

            <cfif Audit.AuditType2 eq "Full">
                <cfset incTo = "#getROM.SQM#">
                <cfset incCC = "#Audit.ROM#, #ReplyTo#">
            <cfelseif Audit.AuditType2 eq "In-Process">
                <cfset incTo = "#ReplyTo#">
                <cfset incCC = "">
            </cfif>

            <!--- send email to TAM that report has been uploaded and NC Entering is scheduled and due on NCReviewDuedate --->
            <!--- To field: Technical Audit Manager goes here --->
            <!--- EMAIL ID 10 and 10a --->

            <cfmail
                to="#incTo#"
                from="#Request.TechnicalAuditMailbox#"
                cc="#incCC#"
                replyto="#ReplyTo#"
                subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Appeal Response Submitted, Appeal Decision Assigned"
                query="Audit"
                type="html">
                This is a notification that the PDE/RLR/SME has submitted their appeal response and you have been assigned the task of reviewing the response(s) to make a final conclusion on whether an item of nonconformance remains.<Br /><br />

                Task Assigned to: #AppealDecisionEmail# (Site Quality Manager)<br />
                <cfif Audit.AuditType2 eq "Full">
                Note - #ROM# (Regional Operations Manager)<br />
                #AssignTaskTo# (Technical Audit Manager) can also accomplish this task<br /><br />
                </cfif>

                Click below to open the audit: #varAuditIdentifier#<br />
                <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                Link to Audit
                </a><br /><br />

				Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

                This task has a due date of: #dateformat(AppealDecisionDueDate, "mm/dd/yyyy")#<br /><br />

                After completion, upload the updated summary report using the audit link above.
            </cfmail>
		</cfif>

		<!--- Appeal Decision Completed --->
        <cfif URL.Action eq "Appeal Decision Completed">
			<!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET

            <cfif Form.YesNoItem eq "YesSR" OR Form.YesNoItem eq "YesCAR" OR Form.YesNoItem eq "Yes">
				<cfset vYesNoItem = "Yes">
            <cfelse>
            	<cfset vYesNoItem = "No">
            </cfif>

            NCExistPostAppeal = '#vYesNoItem#',
            AppealDecision = 'Yes',
            AppealDecisionDate = #createODBCDate(curdate)#,
            <Cfset DueDate = DateAdd('d', 14, curdate)>

            <cfif Form.YesNoItem eq "YesSR" OR Form.YesNoItem eq "YesCAR" OR Form.YesNoItem eq "Yes">
            CurrentDueDate = #createODBCDate(DueDate)#,
            CurrentDueDateFIeld = 'NCEnteredDueDate',
            NCEnteredDueDate = #createODBCDate(DueDate)#,
            NCEnteredAssignDate = #createODBCDate(curdate)#,
            <!--- TAM for In-Process, SQM for Full --->
            <cfif Audit.AuditType2 eq "Full">
	            NCEnteredAssignEmail = '#getROM.SQM#',
			<cfelseif Audit.AuditType2 eq "In-Process">
				NCEnteredAssignEmail = '#replyTo#',
			</cfif>
            NCEnteredAssign = 'Yes',
            NCEnteredAssignDueDate = #createODBCDate(DueDate)#,

			<cfif Form.YesNoItem eq "YesSR">
                <!--- 4 weeks / 28 days --->
                <Cfset SRCARDueDate = DateAdd('d', 28, curdate)>
                <cfset SRCARType = "SR">
            <cfelseif Form.YesNoItem eq "YesCAR">
                <!--- 12 weeks / 84  days --->
                <Cfset SRCARDueDate = DateAdd('d', 84, curdate)>
                <cfset SRCARType = "CAR">
            </cfif>

			<!--- set SRCARClosedDueDate --->
            SRCARType = '#SRCARType#',
            SRCARClosedDueDate = #createODBCDate(SRCARDueDate)#,
            <!--- /// --->

            <cfelseif Form.YesNoItem eq "No">
				<!---
                <cfset Email_CurrentStep = "Audit Ready to be Closed">
                <cfset Flag_CurrentStep = "Appeal Decision Completed">
                Flag_CurrentStep = 'Appeal Decision Completed',
                AuditClosed = 'Yes',
                AuditCloseddate = #createODBCDate(curdate)#,
                AuditClosedConfirm = 'No'
                --->
                CurrentDueDate = #createODBCDate(DueDate)#,
          		CurrentDueDateFIeld = 'NCEnteredDueDate',
                NCEnteredDueDate = #createODBCDate(DueDate)#,
                NCEnteredAssignDate = #createODBCDate(curdate)#,
                <!--- TAM for In-Process, SQM for Full --->
				<cfif Audit.AuditType2 eq "Full">
                    NCEnteredAssignEmail = '#getROM.SQM#',
                <cfelseif Audit.AuditType2 eq "In-Process">
                    NCEnteredAssignEmail = '#replyTo#',
                </cfif>
	            NCEnteredAssign = 'Yes',
                NCEnteredAssignDueDate = #createODBCDate(DueDate)#,
			</cfif>

			<cfset Email_CurrentStep = "Non-Conformance Input">
            <cfset Flag_CurrentStep = "Appeal Decision Completed">
            Flag_CurrentStep = 'Appeal Decision Completed'

            WHERE
            ID = #URL.ID#
            AND Year_ = #URL.Year#
            </CFQUERY>

			<cfif isDefined("SRCARDueDate")>
				<!--- update TechnicalAudits_SRCAR table --->
                <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                UPDATE TechnicalAudits_SRCAR
                SET

                SRCARClosedDueDate = #createODBCDate(SRCARDueDate)#

                WHERE AuditID = #URL.ID#
                AND AuditYear = #URL.Year#
                </CFQUERY>
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

            <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT ReportFileName, DatePosted
            FROM TechnicalAudits_ReportFiles
            WHERE AuditID = #URL.ID#
            AND AuditYear = #URL.Year#
            AND Flag_CurrentStep = 'Appeal Decision Completed'
            </cfquery>

			<cfif Audit.AuditType2 eq "Full">
                <cfset incCC = "#ReplyTo#, #getROM.SQM#, #Audit.ROM#">
            <cfelseif Audit.AuditType2 eq "In-Process">
                <cfset incCC = "#ReplyTo#">
            </cfif>

			<!--- EMAIL ID 13 and 13a --->

            <!--- email about SRCARClosedDueDate --->
			<cfif Form.YesNoItem eq "YesSR" OR Form.YesNoItem eq "YesCAR">
                <cfmail
                    to="#Audit.EngManagerEmail#"
                    cc="#incCC#"
                    replyto="#ReplyTo#"
                    from="#Request.TechnicalAuditMailbox#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Due Date for Corrective Actions to be Completed"
                    query="Audit"
                    type="html">
                    Greetings,<br /><br />

                    This email is notification that item(s) of nonconformance remain. Please work with the <cfif Audit.AuditType2 eq "Full">Project Reviewer and the Site Quality Manager (SQM)<cfelseif Audit.AuditType2 eq "In-Process">Project Evaluator</cfif> on the corrective action and provide notification when complete.<br /><br />

                    Tasks Assigned to: #Audit.EngManagerEmail# (Engineering Manager)<br /><br />

                    <cfif Audit.AuditType2 eq "Full">
                    Any SRs associated with the corrective actions need to be communicated to the Site Quality Manager and provide notification when complete.<br /><br />
                    </cfif>

                    Due Date for the Corrective Action(s) to be completed: #dateformat(SRCARDueDate, "mm/dd/yyyy")#.<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />
            <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

                    For more information about this request, Training, OTL, or recording your hours spent, please refer to the Technical Audit Database Job Aid - <a href="http://dcs.ul.com/function/dcs/ControlledDocumentLibrary/00-QA-J0413/00-QA-J0413.docx">00-QA-J0413</a>.<br /><br />

                    Should you have any questions, please contact any member of the audit team identified below.<br /><br />

                    Regards,<br /><br />

                    Technical Audit Team<br /><br />

                    #ReplyTo# (Technical Audit Manager)<Br />
                    <cfif Audit.AuditType2 eq "Full">
                    #getROM.SQM# (Site Quality Manager)
                    </cfif>
                </cfmail>
            </cfif>

			<cfif Audit.AuditType2 eq "Full">
                <cfset incTO = "#getROM.SQM#">
                <cfset incCC = "#ReplyTo#">
            <cfelseif Audit.AuditType2 eq "In-Process">
                <cfset incTO = "#ReplyTo#">
                <cfset incCC = "">
            </cfif>

            <!--- send email to TAM that report has been uploaded and NC Entering is scheduled and due on NCReviewDuedate --->
            <!--- To field: Technical Audit Manager goes here --->

			<!--- EMAIL ID 11 and 11a --->

            <cfmail
                to="#incTo#"
                from="#Request.TechnicalAuditMailbox#"
                cc="#incCC#"
                replyto="#ReplyTo#"
                subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Appeal Decision Completed, Non-Conformance Input Assigned"
                query="Audit"
                type="html">
				This is notification that the appeal decision is completed.<br /><br />

                You have been assigned the task of inputting the Nonconformance(s) into the Technical Audit Database.<br /><br />

				<cfif Audit.AuditType2 eq "Full">
                Task Assigned To: #getROM.SQM# (Site Quality Manager)<br />
                Note - #ROM# (Regional Operations Manager) can also accomplish this task<br /><br />
                <cfelseif Audit.AuditType2 eq "In-Process">
				Task Assigned To: #replyTo# (Technical Audit Manager)<br /><Br />
				</cfif>

                Click below to open the audit: #varAuditIdentifier#<br />
                <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                Link to Audit
                </a><br /><br />

				Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>

				This task has a due date of: #dateformat(NCEnteredDueDate, "mm/dd/yyyy")#
        	</cfmail>
		</cfif>

		<!--- Non-Conformance Input Completed --->
        <cfif URL.Action eq "Non-Conformance Input Completed">
            <cfif isDefined("Form.EmpNo")>
                <CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
                SELECT employee_email
                FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
                WHERE employee_number = '#form.EmpNo#'
                </CFQUERY>
            </cfif>

            <!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET

			<cfif Audit.NCExistPostAppeal eq "No">
                AuditClosed = 'Yes',
                AuditCloseddate = #createODBCDate(curdate)#,
                AuditClosedConfirm = 'No',
            <cfelseif Audit.NCExistPostAppeal eq "Yes">
                CurrentDueDate = #createODBCDate(Audit.SRCARClosedDueDate)#,
                CurrentDueDateFIeld = 'SRCARClosedDueDate',
            </cfif>

            NCEntered = 'Yes',
            <cfif isDefined("Form.EmpNo")>
                NCEnteredEmail = '#NameLookup.employee_email#',
            </cfif>

            NCEnteredDate = #createODBCDate(curdate)#,
            <cfset Flag_CurrentStep = "Non-Conformance Input Completed">
            Flag_CurrentStep = 'Non-Conformance Input Completed'

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
            AND Flag_CurrentStep = 'Non-Conformance Input Completed'
            </cfquery>

			<cfif Audit.NCExistPostAppeal eq "No">
                <!--- send email to SQM that report and NCs have been completed, and include SR/CAR Closure Due Date information --->
                <!--- Email ID 19 and 19a --->

                <cfmail
                    to="#ReplyTo#"
                    from="#Request.TechnicalAuditMailbox#"
                    replyTo="#ReplyTo#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Non-Conformance Input Completed, Audit Ready to be Closed"
                    query="Audit"
                    type="html">
                    This is notification that the nonconformance information has been entered into the Technical Audit Database.<br /><br />

                    Required Action: Audit Ready to be Closed<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />
                    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit
                    </a><br /><br />

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>
                </cfmail>
                <!--- /// --->
            <cfelseif Audit.NCExistPostAppeal eq "Yes">
                <!--- EMAIL ID 12 and 12a --->

            <cfif Audit.AuditType2 eq "Full">
            	<cfset incTo = "#getROM.SQM#">
            <cfelseif Audit.AuditType2 eq "In-Process">
            	<cfset incTo = "#replyTo#">
            </cfif>

                <!--- send email to SQM that report and NCs have been completed, and include SR/CAR Closure Due Date information --->
                <cfmail
                    to="#incTo#"
                    from="#Request.TechnicalAuditMailbox#"
                    replyto="#ReplyTo#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Non-Conformance Input Completed"
                    query="Audit"
                    type="html">
                    Greetings,<br /><br />

                    This is notification that the nonconformance information has been entered into the Technical Audit Database.<br /><br />

                    Corrective Actions need to be closed by the due date listed below. Please work with #Audit.EngManagerEmail# (Engineering Manager) to ensure these actions are completed and enter the information into the Technical audit Database.<br /><br />

                    <cfif AuditType2 eq "Full">
                    Task assigned to: #getROM.SQM# (Site Quality Manager)<Br /><br />
                    <cfelseif AuditType2 eq "In-Process">
                    Task assigned to: #replyTo# (Technical Audit Manager)<br /><br />
                    </cfif>

                    This task has a due date of #dateformat(SRCARClosedDueDate, "mm/dd/yyyy")#<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />
                    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit
                    </a>

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>
                </cfmail>
                <!--- /// --->
            </cfif>
		</cfif>

		<!--- Corrective Actions Completed --->
        <cfif URL.Action eq "Corrective Actions Completed">
            <cfif isDefined("Form.EmpNo")>
                <CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
                SELECT employee_email
                FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
                WHERE employee_number = '#form.EmpNo#'
                </CFQUERY>
            </cfif>

            <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT * FROM TechnicalAudits_SRCAR
            WHERE AuditID = #URL.ID#
            AND AuditYear = #URL.Year#
            </CFQUERY>

            <!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET

            <cfif Form.YesNoItem eq "Yes">
                <cfif isDefined("Form.EmpNo")>
                SRCARClosedName = '#NameLookup.employee_email#',
                </cfif>

                SRCARClosed = 'Yes',
                SRCARClosedDate = #createODBCDate(curdate)#,
                SRCARVerifiedDueDate = #createODBCDate(Form.DueDate)#,

                CurrentDueDate = #createODBCDate(Form.DueDate)#,
                CurrentDueDateFIeld = 'SRCARVerifiedDueDate',

                <cfset Flag_CurrentStep = "Corrective Actions Completed">
                Flag_CurrentStep = 'Corrective Actions Completed'
            <cfelseif Form.YesNoItem eq "No">
                SRCARClosed = 'No',
                SRCARClosedDueDate = #createODBCDate(Form.DueDate)#,

                CurrentDueDate = #createODBCDate(Form.DueDate)#,
                CurrentDueDateFIeld = 'SRCARClosedDueDate',

                <cfset Flag_CurrentStep = "Non-Conformance Input Completed">
                Flag_CurrentStep = 'Non-Conformance Input Completed'
            </cfif>

            WHERE
            ID = #URL.ID#
            AND Year_ = #URL.Year#
            </CFQUERY>

            <!--- update TechnicalAudits_SRCAR table --->
            <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_SRCAR
            SET

            <cfif Form.YesNoItem eq "Yes">
                SRCARClosed = 'Yes',
                SRCARClosedDate = #createODBCDate(curdate)#,
                SRCARVerifiedDueDate = #createODBCDate(Form.DueDate)#
            <cfelseif Form.YesNoItem eq "No">
                SRCARClosed = 'No',
                SRCARClosedDueDate = #createODBCDate(Form.DueDate)#
            </cfif>

            WHERE AuditID = #URL.ID#
            AND AuditYear = #URL.Year#
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

            <cfif Flag_CurrentStep eq "Corrective Actions Completed">
                <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT ReportFileName, DatePosted
                FROM TechnicalAudits_ReportFiles
                WHERE AuditID = #URL.ID#
                AND AuditYear = #URL.Year#
                AND Flag_CurrentStep = '#Flag_CurrentStep#'
                </cfquery>

				<cfif audit.AuditType2 eq "Full">
                    <cfset incTo = "#getROM.SQM#">
                <cfelseif Audit.AuditType2 eq "In-Process">
                    <cfset incTo = "#replyTo#">
                </cfif>

                <!--- EMAIL ID 14 and 14a --->

                <!--- send email to SQM that report and Corrective Actions have been completed, and include SR/CAR Verify Due Date information --->
                <cfmail
                    to="#incTo#"
                    from="#Request.TechnicalAuditMailbox#"
                    replyto="#ReplyTo#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Corrective Actions Completed"
                    query="Audit"
                    type="html">
                    Greetings,<br /><br />

                    This e-mail is notification that work has been completed for this technical audit and it is ready to have the corrective actions verified.<br /><br />

                    <font class="warning">If this is an Observation CAR</font>, verification should occur immediately. Please follow the link below to provide verification information.
                    <br /><br />

                    <cfif Audit.AuditType2 eq "Full">
					Task Assigned To: #getROM.SQM# (Site Quality Manager)<br />
                    Note - #ROM# (Regional Operations Manager) can also accomplish this task
                    <cfelseif Audit.AuditType2 eq "In-Process">
                    Task Assigned To: #replyTo# (Technical Audit Manager)
                    </cfif><br /><br />

                    This task has a due date of #dateformat(SRCARVerifiedDueDate, "mm/dd/yyyy")#<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />
                    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit
                    </a><br><br>

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>
                </cfmail>
                <!--- /// --->
            <cfelseif Flag_CurrentStep eq "Non-Conformance Input Completed">
                <!--- send email to SQM that report and Corrective Actions have NOT been completed, and include NEW SR/CAR Complete Due Date information --->

                <!--- EMAIL ID 14 and 14a --->

                <cfif audit.AuditType2 eq "Full">
                    <cfset incTo = "#getROM.SQM#">
                <cfelseif Audit.AuditType2 eq "In-Process">
                    <cfset incTo = "#replyTo#">
                </cfif>

                <cfmail
                    to="#incTo#"
                    from="#Request.TechnicalAuditMailbox#"
                    replyTo="#ReplyTo#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Corrective Actions Not Completed - New Due Date Set"
                    query="Audit"
                    type="html">
                    This e-mail is notification that work has been completed for this technical audit and corrective action has not yet been completed for this technical audit.<br /><br />

					<cfif Audit.AuditType2 eq "Full">
					Task Assigned To: #getROM.SQM# (Site Quality Manager)<br />
                    Note - #ROM# (Regional Operations Manager) can also accomplish this task
                    <cfelseif Audit.AuditType2 eq "In-Process">
                    Task Assigned To: #replyTo# (Technical Audit Manager)
                    </cfif><br /><br />

                    This task has a new due date of #dateformat(SRCARClosedDueDate, "mm/dd/yyyy")#<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />
                    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit</a><br><br>

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>
                </cfmail>
                <!--- /// --->
            </cfif>
		</cfif>

		<!--- Corrective Actions Verified --->
        <cfif URL.Action eq "Corrective Actions Verified">
            <cfif isDefined("Form.EmpNo")>
                <CFQUERY NAME="NameLookup" datasource="OracleNet" Timeout="600">
                SELECT employee_email
                FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW
                WHERE employee_number = '#form.EmpNo#'
                </CFQUERY>
            </cfif>

            <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT * FROM TechnicalAudits_SRCAR
            WHERE AuditID = #URL.ID#
            AND AuditYear = #URL.Year#
            </CFQUERY>

            <!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET

            <cfif Form.YesNoItem eq "Yes">
                <cfif isDefined("Form.EmpNo")>
                SRCARVerifiedName = '#NameLookup.employee_email#',
                </cfif>

                SRCARVerified = 'Yes',
                SRCARVerifiedDate = #createODBCDate(curdate)#,
                AuditClosed = 'Yes',
                AuditCloseddate = #createODBCDate(curdate)#,
                AuditClosedConfirm = 'No',

                <cfset Flag_CurrentStep = "Corrective Actions Verified">
                Flag_CurrentStep = 'Corrective Actions Verified'
            <cfelseif Form.YesNoItem eq "No">
                CurrentDueDate = #createODBCDate(Form.DueDate)#,
                CurrentDueDateFIeld = 'SRCARVerifiedDueDate',

                SRCARVerified = 'No',
                SRCARVerifiedDueDate = #createODBCDate(Form.DueDate)#,

                <cfset Flag_CurrentStep = "Corrective Actions Completed">
                Flag_CurrentStep = 'Corrective Actions Completed'
            </cfif>

            WHERE
            ID = #URL.ID#
            AND Year_ = #URL.Year#
            </CFQUERY>

            <!--- update TechnicalAudits_SRCAR table --->
            <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_SRCAR
            SET

            <cfif Form.YesNoItem eq "Yes">
                SRCARVerified = 'Yes',
                SRCARVerifiedDate = #createODBCDate(curdate)#
            <cfelseif Form.YesNoItem eq "No">
                SRCARVerified = 'No',
                SRCARVerifiedDueDate = #createODBCDate(Form.DueDate)#
            </cfif>

            WHERE AuditID = #URL.ID#
            AND AuditYear = #URL.Year#
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

            <cfif Flag_CurrentStep eq "Corrective Actions Verified">
                <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                SELECT ReportFileName, DatePosted
                FROM TechnicalAudits_ReportFiles
                WHERE AuditID = #URL.ID#
                AND AuditYear = #URL.Year#
                AND Flag_CurrentStep = '#Flag_CurrentStep#'
                </cfquery>

                <!--- send email to SQM that report and Corrective Actions have been completed, and include SR/CAR Verify Due Date information --->
                <!--- EMAIL ID 15 / 15a --->

                <cfmail
                    to="#ReplyTo#"
                    from="#Request.TechnicalAuditMailbox#, #EngManagerEmail#"
                    cc="#ReplyTo#"
                    replyTo="#ReplyTo#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Corrective Actions Verified"
                    query="Audit"
                    type="html">
                    This e-mail is notification that corrective actions have been completed and verified, and this audit is ready to be closed.<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />
                    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit
                    </a><Br><br>

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>
                </cfmail>
                <!--- /// --->
            <cfelseif Flag_CurrentStep eq "Corrective Actions Completed">

			<cfif Audit.AuditType2 eq "Full">
            	<cfset incTo = "#getROM.SQM#">
            <cfelseif Audit.AuditType2 eq "In-Process">
            	<cfset incTo = "#replyTo#">
            </cfif>

                <!--- send email to SQM that report and Corrective Actions have NOT been completed, and include NEW SR/CAR Complete Due Date information --->
                <cfmail
                    to="#incTo#"
                    from="#Request.TechnicalAuditMailbox#"
                    cc="#ReplyTo#"
                    replyTo="#ReplyTo#"
                    subject="Internal Technical Audit of Project #ProjectNumber# (#AuditType2#) - Corrective Actions Not Verified - New Due Date Set"
                    query="Audit"
                    type="html">
                    This e-mail is notification that corrective actions are not able to be verified at this time.<br /><br />

					<cfif Audit.AuditType2 eq "Full">
					Task Assigned To: #getROM.SQM# (Site Quality Manager)<br />
                    Note - #ROM# (Regional Operations Manager) can also accomplish this task
                    <cfelseif Audit.AuditType2 eq "In-Process">
                    Task Assigned To: #replyTo# (Technical Audit Manager)
                    </cfif><br /><br />

                    This task has a new due date of #dateformat(Form.DueDate, "mm/dd/yyyy")#<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />
                    <a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit</a><br><br>

					Note: Please use Internet Explorer to follow this link. If IE is not your default browser, right-click the link above and select "Copy Hyperlink" in order to paste this link into IE.<br><br>
                </cfmail>
			</cfif>
        </cfif>

		<cfif URL.Action eq "Engineering Manager Review Completed" AND Form.YesNoItem eq "No">
            <cfset HistoryInclude = "No Appeals<br>">
        <cfelseif URL.Action eq "Non-Conformance Input Completed">
            <cfset HistoryInclude = "Non-Conformance Input Completed<Br>">
        <cfelseif URL.Action eq "Audit Executed - Audit Report Posted" AND Form.YesNoItem eq "No">
            <Cfset HistoryInclude = "No Non-Conformances or CNBDs were found<br>">
        <cfelseif URL.Action eq "Appeal Decision Completed" AND Form.YesNoItem eq "No">
            <cfset HistoryInclude = "No Non-Conformances remain after Appeal Decision<br>">
		<cfelseif URL.Action eq "Corrective Actions Completed" AND Form.YesNoItem eq "Yes">
            <cfset HistoryInclude = "Corrective Actions Completed<br>">
        <cfelseif URL.Action eq "Corrective Actions Completed" AND Form.YesNoItem eq "No">
            <cfset HistoryInclude = "Corrective Actions Not Completed - New Due Date Assigned<br>">
        <cfelseif URL.Action eq "Corrective Actions Verified" AND Form.YesNoItem eq "Yes">
            <cfset HistoryInclude = "Corrective Actions Verified<br>">
        <cfelseif URL.Action eq "Corrective Actions Verified" AND Form.YesNoItem eq "No">
            <cfset HistoryInclude = "Corrective Actions Not Verified - New Due Date Assigned<br>">
        <cfelse>
            <cfset HistoryInclude = "">
        </cfif>

        <cfset HistoryUpdate = "Current Step: #Flag_CurrentStep#<br>#HistoryInclude#Action by: <cfif isDefined('SESSION.Auth')>#SESSION.Auth.Name#/#Session.Auth.UserName#</cfif><br>Date: #curdate# #curTime#">

        <!--- history update --->
        <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE TechnicalAudits_AuditSchedule
        SET

        History = <CFQUERYPARAM VALUE="#Audit.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">

        WHERE
        ID = #URL.ID#
        AND Year_ = #URL.Year#
        </CFQUERY>

        <!--- this is set up so that the SQM or TAM can stay logged in to do CA Completed and CA Verified sections if they are to be done at the same time --->
		<cfif URL.Action eq "Corrective Actions Completed" OR URL.Action eq "Corrective Actions Verified" AND Form.YesNoItem eq "No">
            <cflocation url="TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
        <cfelse>
            <cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
        </cfif>

	<!--- form.yesnoitem not selected --->
	<cfelse>
       	<cflocation url="TechnicalAudits_ReportUpload.cfm?ID=#URL.ID#&Year=#URL.Year#&Action=#URL.Action#&msg=Please Select Yes/No" addtoken="no">
	</cfif>

<!--- form not submitted --->
<cfelse>

	<cfif isDefined("url.msg")>
        <cfoutput>
            <font class="warning"><b>Validation Error</b>: #url.msg#</font><br /><br />
        </cfoutput>
    </cfif>

<Cfoutput>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

    <cfform action="#CGI.Script_Name#?#CGI.Query_String#" enctype="multipart/form-data" method="post" name="myform" id="myform">
    Audit Report File:<br />
    <input type="File" size="50" name="File"><br><br />

    <cfif isDefined("Form.EmpNo")>
    	<input type="hidden" name="EmpNo" value="#Form.EmpNo#" />
    </cfif>

    <cfif URL.Action eq "Audit Executed - Audit Report Posted">
        <div align="Left" class="blog-time">
        <br />
        <b>Instructions</b><br />
        <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_Links
        WHERE Label = 'Instructions'
        </cfquery>
        See <a href="#DocumentLinks.HTTPLINK#">#DocumentLinks.HTTPLINKNAME#</a><br />
        Section 9.6 Complete audit<br /><br />
        </div>

        Are there Non-Conformances or "Could Not Be Determined" Items from this Audit?<Br />
        Yes <input type="radio" name="YesNoItem" value="Yes" />
        No <input type="radio" name="YesNoItem" value="No" data-bvalidator="required" data-bvalidator-msg="Please Select Yes or No" />
        <br /><br />
    <cfelseif URL.Action eq "Engineering Manager Review Completed">
        <div align="Left" class="blog-time">
        <br />
        <b>Instructions</b><br />
        <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_Links
        WHERE Label = 'Instructions'
        </cfquery>
        See <a href="#DocumentLinks.HTTPLINK#">#DocumentLinks.HTTPLINKNAME#</a><br />
        Section 9.8 Engineering Manager Response<br /><br />
        </div>

            Are there Appeals from this Audit?<br />

            <b>Appeals Exist</b><br />
            Yes <input type="radio" name="YesNoItem" value="Yes" /><br /><br />

            <b>No Appeals</b><br />
            Is Testing or Construction Review required as a result of the Audit Non-Conformances?<Br /><br />

            Testing or Construction Review is required <input type="radio" name="YesNoItem" value="NoCAR" /><br />
            Testing or Construction Review is <b><font color="red">NOT</font></b> required <input type="radio" name="YesNoItem" value="NoSR" data-bvalidator="required" data-bvalidator-msg="Please Select a value to describe the Non-Conformances" />
            <br /><br />
	<cfelseif URL.Action eq "Appeal Response Completed">
        <div align="Left" class="blog-time">
        <br />
        <b>Instructions</b><br />
        <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_Links
        WHERE Label = 'Instructions'
        </cfquery>
        See <a href="#DocumentLinks.HTTPLINK#">#DocumentLinks.HTTPLINKNAME#</a><br />
        Section 9.10 Respond to Appeals<br /><br />
        </div>

    	<input type="hidden" name="YesNoItem" value="NA" />
    <cfelseif URL.Action eq "Non-Conformance Input Completed">
        <div align="Left" class="blog-time">
        <br />
        <b>Instructions</b><br />
        <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_Links
        WHERE Label = 'Instructions'
        </cfquery>
        See <a href="#DocumentLinks.HTTPLINK#">#DocumentLinks.HTTPLINKNAME#</a><br />
        Section 9.12 Input Non-Conformances<br /><br />
        </div>

    	<input type="hidden" name="YesNoItem" value="NA" />
	<cfelseif URL.Action eq "Appeal Decision Completed">
        <div align="Left" class="blog-time">
        <br />
        <b>Instructions</b><br />
        <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_Links
        WHERE Label = 'Instructions'
        </cfquery>
        See <a href="#DocumentLinks.HTTPLINK#">#DocumentLinks.HTTPLINKNAME#</a><br />
        Section 9.11 Appeal Decision<br /><br />
        </div>

            After the Appeal Decision, are there any Non-Conformances?<br />

            <u>Yes, Non-Conformances Exist</u><br />
             :: Testing or Construction Review is Required <input type="radio" name="YesNoItem" value="YesCAR" /><br />
             :: Testing or Construction Review is <b><font color="red">NOT</font></b> required <input type="radio" name="YesNoItem" value="YesSR" /><br /><br />

            <u>No, Non-Conformances Do Not Exist</u> <input type="radio" name="YesNoItem" value="No" data-bvalidator="required" data-bvalidator-msg="Please Select a value to describe the Non-Conformances" /><br /><br />
    <Cfelseif URL.Action eq "Non-Conformance Review Completed">
        <div align="Left" class="blog-time">
        <br />
        <b>Instructions</b><br />
        <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_Links
        WHERE Label = 'Instructions'
        </cfquery>
        See <a href="#DocumentLinks.HTTPLINK#">#DocumentLinks.HTTPLINKNAME#</a><br />
        Section 9.7 Non-Conformance Review<br /><br />
        </div>

        After the Non-Conformance Review, do you want to upload a revised report?<Br />
        Yes <input type="radio" name="YesNoItem" value="Yes" />
        No <input type="radio" name="YesNoItem" value="No" data-bvalidator="required" data-bvalidator-msg="Please Select Yes or No" />
        <br /><br />

        <!--- set due date for Eng Manager --->
        Set Due Date for the Engineering Manager to complete their Non-Conformance Review:<br />
        Note: An email will be sent to the Engineering Manager when this form is submitted.<br /><br />

        <Cfset DueDate = DateAdd('d', 14, curdate)>

        Set Due Date:<br />
        <div style="position:relative; z-index:3">
        	<cfinput
            	type="datefield"
                name="DueDate"
                required="yes"
                value="#dateformat(DueDate, 'mm/dd/yyyy')#"
                message="Please include the due date"
                validate="date">
        </div>
        <br /><br />
	<cfelseif URL.Action eq "Corrective Actions Completed">
        <div align="Left" class="blog-time">
        <br />
        <b>Instructions</b><br />
        <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_Links
        WHERE Label = 'Instructions'
        </cfquery>
        See <a href="#DocumentLinks.HTTPLINK#">#DocumentLinks.HTTPLINKNAME#</a><br />
        Section 9.13 Add Corrective Action Closure Information<br /><br />
        </div>

        <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_SRCAR
        WHERE AuditID = #URL.ID#
        AND AuditYear = #URL.Year#
        </CFQUERY>

        Are the Corrective Actions listed below Completed? Please upload a revised report.<Br />
        Yes <input type="radio" name="YesNoItem" value="Yes">
        No <input type="radio" name="YesNoItem" value="No" data-bvalidator="required" data-bvalidator-msg="Please Select Yes or No">
        <br /><br />

        <Cfset DueDate = DateAdd('d', 14, curdate)>

        Set the new Due Date.<br />
        <div style="position:relative; z-index:3">
        	<cfinput
            	type="datefield"
                name="DueDate"
                required="yes"
                value="#dateformat(DueDate, 'mm/dd/yyyy')#"
                message="Please include the due date"
                validate="date">
        </div>
        <br /><br /><br />
        <u>Note:</u><br />
        :: If Corrective Actions are completed, this due date will be for Verifying the Corrective Actions.<br />
        :: If the Corrective Actions are NOT completed, this due date will be for Completing the Corrective Actions.<br /><br />
	<cfelseif URL.Action eq "Corrective Actions Verified">
        <div align="Left" class="blog-time">
        <br />
        <b>Instructions</b><br />
        <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_Links
        WHERE Label = 'Instructions'
        </cfquery>
        See <a href="#DocumentLinks.HTTPLINK#">#DocumentLinks.HTTPLINKNAME#</a><br />
        Section 9.14 Add Corrective Action Verification Information<br /><br />
        </div>

        <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        SELECT * FROM TechnicalAudits_SRCAR
        WHERE AuditID = #URL.ID#
        AND AuditYear = #URL.Year#
        </CFQUERY>

        Are the Corrective Actions listed below Verified? Please upload a revised report.<Br />
        Yes <input type="radio" name="YesNoItem" value="Yes">
        No <input type="radio" name="YesNoItem" value="No" data-bvalidator="required" data-bvalidator-msg="Please Select Yes or No">
        <br /><br />

        <Cfset DueDate = DateAdd('d', 14, curdate)>

        Set the new Due Date.<br />
        :: If Corrective Actions are verified, <u>no due date is required</u>, please disregard the date listed in the date field.<br />
        :: If the Corrective Actions are NOT verified, this due date will be for Verifying the Corrective Actions.<br />
        <div style="position:relative; z-index:3">
        	<cfinput
            	type="datefield"
                name="DueDate"
                required="yes"
                value="#dateformat(DueDate, 'mm/dd/yyyy')#"
                message="Please include the due date"
                validate="date">
        </div>
        <br /><br />
	<cfelse>
    	<input type="hidden" name="YesNoItem" value="NA" />
    </cfif>

        <input type="submit" name="upload" value="Submit Form and Continue">
        <input type="reset" name="upload" value="Reset Form"><br /><br />
    </cfform>

<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

	<cfif URL.Action eq "Corrective Actions Completed" OR URL.Action eq "Corrective Actions Completed">
        <br />
        <b>SR / CAR Information</b><br />

        <table border="1">
        <tr>
            <th align="center">Issue Type</th>
            <th align="center">Number</th>
            <th align="center">Due Date</th>
            <th align="center">Additional SR/CAR Numbers</th>
        </tr>
        <cfloop query="SRCAR">
        <tr>
            <td valign="top">#IssueType#</td>
            <td valign="top">#SRCARNumber#</td>
            <td valign="top">#Dateformat(SRCARClosedDueDate, "mm/dd/yyyy")#</td>
            <td valign="top"><cfif len(SRCAR_AdditionalNumbers)>#replace(SRCAR_AdditionalNumbers, ",", "<br />", "All")#<cfelse>N/A</cfif></td>
        </tr>
        </cfloop>
        </table><br /><br />
    </cfif>
</Cfoutput>
</cfif>