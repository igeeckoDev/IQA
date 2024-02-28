<!--- States handled on this page:
1. Audit Executed - Audit Report Posted 
	a) NC/CNBD Exist
	b) NC/CNBD do not exist
2. Non-Conformance Review Completed
	a) file upload
	b) no file upload
3. Engineering Manager Review Completed
	a) file upload
	b) no file upload
4. Appeal Response Completed
5. Appeal Decision Completed
	a) NC/CNBD Exist
	b) NC/CNBD do not exist
6. Non-Conformance Input Completed
--->

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
<cfset currentDirectory = "d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#newDirectory#">

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
    <cfset NotVerified_Identifier = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#_Corrective Actions Completed">
</cfoutput>

<!--- Review w/o file upload --->
<cfif isDefined("Form.Upload")>
	<cfif isDefined("Form.YesNoItem")>
    	<cfif URL.Action eq "Non-Conformance Review Completed" AND Form.YesNoItem eq "No">
        <!--- OR URL.Action eq "Engineering Manager Review Completed" AND Form.YesNoItem eq "No" --->

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
                    source="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#getFile.reportFileName#"
                    destination="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\TempUpload\">
                    
                <cfoutput>
                    <cfset FindExtLocation = #Find(".", getFile.reportFileName)#>
                    <cfset getExtLength = len(getFile.reportFileName) - FindExtLocation>
                    <cfset getFileExt = "#right(getFile.reportFileName, getExtLength)#">
                </cfoutput>
                
                <!--- rename/move the file from TempUpload to audit folder and name it with current action (Non-Conformance Review Completed) --->
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

		<!--- no file! --->
    	<cfelseif URL.Action eq "Corrective Actions Completed" AND Form.YesNoItem eq "No">
            <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            SELECT * FROM TechnicalAudits_SRCAR
            WHERE AuditID = #URL.ID#
            AND AuditYear = #URL.Year#
            </CFQUERY>
        
        <cfelse>
			<!--- all other cases involve uploading a file--->
            <cfif NOT Len(FORM.File)>
                <cflocation url="TechnicalAudits_ReportUpload.cfm?ID=#URL.ID#&Year=#URL.Year#&Action=#URL.Action#&msg=Please Attach the Audit Report File" addtoken="no">
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
                        source="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#getFile.reportFileName#"
                        destination="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#ReplacedFileName#">
                    
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
                    <cfset destination="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#NotVerified_Identifier#.#cffile.ServerFileExt#">
                    
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
				<cfelse>
					<!--- upload file to temp location --->
                    <CFFILE ACTION="UPLOAD" 
                        FILEFIELD="Form.File" 
                        DESTINATION="#IQARootPath#TechAuditReports\TempUpload\" 
                        NAMECONFLICT="OVERWRITE">
                    
                    <!---- set the path and set file name, using cffile.serverfileext from cffile above --->
                    <cfset destination="d:\webserver\corporate\home\departments\snk5212\IQA\TechAuditReports\#URL.Year#-#URL.ID#\#Identifier#.#cffile.ServerFileExt#">
                    
                    <cfset newFileName = "#Identifier#.#cffile.ServerFileExt#">
                    
                    <!--- upload file to destination--->
                    <cffile action="upload" filefield="file" destination="#destination#" nameconflict="Overwrite">
				</cfif>
            </cfif>
		</cfif>
        
		<!--- For all cases EXCEPT Correction Actions Completed AND Form.YesNoItem eq No--->
		<cfif URL.Action NEQ "Corrective Actions Completed"
			OR URL.Action EQ "Corrective Actions Completed" AND Form.YesNoItem NEQ "No"
			>
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
    			CurrentDueDateFIeld = 'NCReviewDueDate',
                
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
            
            <!--- No NCs or CNBDs --->
            <cfif Form.YesNoItem eq "No">
                <cfset incSubject = "No Non-Conformances Identified - Audit Ready to be Closed">
            <!--- NC or CNBDs exist --->
            <cfelseif Form.YesNoItem eq "Yes">
                <cfset incSubject = "Non-Conformance Review Assigned">
            </cfif>
            
            <!--- cc field --->
            <cfif Audit.AuditType2 eq "Full">
                <cfset incCC = "#Audit.ROM#">
            <cfelseif Audit.AuditType2 eq "In-Process">
                <cfset incCC = "">
            </cfif>
            
            <!--- send email to TAM/etc that report has been uploaded and NC Review is scheduled and due on NCReviewDuedate --->
            <cfmail
                to="#Request.TechnicalAuditManager#, #replyTo#, #getROM.SQM#, #AuditorEmail#, #AuditorManagerEmail#" 
                from="#Request.TechnicalAuditMailbox#"
                cc="#incCC#, #ReplyTo#"
                subject="Internal Technical Audit (#AuditType2#) - Audit Report Posted, #incSubject#"
                query="Audit"
                type="html">                
                <cfif Form.YesNoItem eq "No">
					Congratulations - <cfif AuditType2 eq "Full">A Full Technical<cfelseif AuditType2 eq "In-Process">An In-Process</cfif> Audit was completed with no non-conformances.<br /><br />
                    
                    A detailed review and analysis was conducted in order to determine that the supporting documents, data recording and/or decision granting certification fulfilled UL requirements and were technically correct. The results of the project audit demonstrated full compliance.<br /><br />
                    
                    Click below to open the audit:<br />
                    <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit</a><br /><br />

					On behalf of UL, we thank you for the valuable and continued contributions to be the Fasted, Highest Quality &amp; Most Customer Friendly third party Conformity Assessment Company in the world.<br<br />
                    
                    Regards,<br /><br />
                    
                    Technical Audit Team<br /><br />
                    
                    <cfif len(Audit.TAM)>
                        #Audit.TAM# (Technical Audit Manager)
                        <cfset AssignTaskTo = ReplyTo>
                    <cfelse>
                        #Request.TechnicalAuditMailbox# (Technical Audit Manager)
                    </cfif><br />
                    
                    #Audit.ROM# (Regional Operations Manager)
                <cfelseif Form.YesNoItem eq "Yes">
                    This is notification that the auditor has posted an audit report and you have been assigned the review of that report. <br /><br />
                    
                    Task Assigned To:<br />
                    #AssignTaskTo# (Technical Audit Manager)<cfif Audit.AuditType2 eq "Full">, #ROM# (Regional Operations Manager)</cfif><br /><br />
                    
                    Click below to open the audit:<br />
                    <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit</a><br /><br />
                    
                    This task has a due date of: #dateformat(NCReviewDueDate, "mm/dd/yyyy")#
                </cfif>
			</cfmail>
        </cfif>

		<!--- Non-Conformance Review Completed --->
        <cfif URL.Action eq "Non-Conformance Review Completed">
            <!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET
            
            NCReviewDate = #createODBCDate(curdate)#,
            NCReview = 'Yes',
            <Cfset DueDate = DateAdd('d', 14, curdate)>
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
                Action by: [Role]<br />
                Date: #curdate# #curTime#">
                
            <cfmail 
                to="#Audit.EngManagerEmail#" 
                from="#Request.TechnicalAuditMailbox#"
                cc="#Request.TechnicalAuditMailbox#"
                replyto="#ReplyTo#"
                subject="Internal Technical Audit (#AuditType2#) - Audit Non-Conformance Assignment"
                query="Audit"
                type="HTML">
                
                <Cfset DueDate = DateAdd('d', 14, curdate)>
                
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
            
            <cfif Audit.AuditType2 eq "Full">
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
			</cfif>

			<cfif Form.YesNoItem eq "Yes">
                CurrentDueDate = #createODBCDate(DueDate)#,
                CurrentDueDateField = 'AppealAssignDueDate',
                AppealAssignDueDate = #createODBCDate(DueDate)#,
                Flag_CurrentStep = 'Engineering Manager Review Completed'
            <cfelseif Form.YesNoItem eq "NoCAR" OR Form.YesNoItem eq "NoSR" OR Form.YesNoItem eq "No">
                CurrentDueDate = #createODBCDate(DueDate)#,
                CurrentDueDateFIeld = 'NCEnteredDueDate',
                NCExistPostAppeal = 'Yes',
                NCEnteredDueDate = #createODBCDate(DueDate)#,
                NCEnteredAssignDate = #createODBCDate(curdate)#,
                NCEnteredAssignEmail = '#getROM.SQM#',
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
                    <cfset incTO = "#ReplyTo#, #Audit.ROM#, #getROM.SQM#">
                <cfelseif Audit.AuditType2 eq "In-Process">
                    <cfset incTO = "#ReplyTo#">
                </cfif>

                <cfmail
                    to="#incTO#"
                    from="#Request.TechnicalAuditMailbox#"
                    subject="Internal Technical Audit (#AuditType2#) - Engineering Manager Review Completed - Appeals Identified"
                    query="Audit"
                    type="html">
                    This is notification that the Engineering Manager has posted his report and there are appeals for some or all of the items. You have been assigned the task of assigning the appeals to a PDE.<br /><br />
                    
                    Audit Identifier: #varAuditIdentifier#<br /><br />

					Click below to open the audit: #varAuditIdentifier#<br />
					<a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />
                    
                    <cfset CurrentDueDate = #dateformat(AppealAssignDueDate, "mm/dd/yyyy")#>
                    <cfset Email_CurrentStep = "Assignment of Appeals / Appeal Response">
                    
                    Task Assigned to: #AssignTaskTo# (TAM)<cfif Audit.AuditType2 eq "Full">, #getROM.SQM# (SQM), #ROM# (ROM)</cfif><br />
                    Required Action: #Email_CurrentStep#<br />
					This task has a due date of #dateformat(CurrentDueDate, "mm/dd/yyyy")#
                </cfmail>
            <!--- NC Input Assigned Email --->
            <cfelseif Form.YesNoItem eq "NoSR" OR Form.YesNoItem eq "NoCAR" OR Form.YesNoItem eq "No">
                 <cfif Audit.AuditType2 eq "Full">
                    <cfset incTO = "#ReplyTo#, #Audit.ROM#, #getROM.SQM#">
                <cfelseif Audit.AuditType2 eq "In-Process">
                    <cfset incTO = "#ReplyTo#, #getROM.SQM#">
                </cfif>
                
                <cfmail
                    to="#incTO#"
                    from="#Request.TechnicalAuditMailbox#"
                    replyTo="#ReplyTo#"
                    subject="Internal Technical Audit (#AuditType2#) - Engineering Manager Review Completed - No Appeals"
                    query="Audit"
                    type="html">
                    This is notification that the Engineering Manager has posted his report and there are NO appeals.<br /><br />

					You have been assigned the task of inputting the NCs into the Technical Audit Database.<Br /><br />
                    
                    Audit Identifier: #varAuditIdentifier#<br /><br />
					
                    Task Assigned To: #getROM.SQM# (Site Quality Manager)<cfif Audit.AuditType2 eq "Full">, #ROM# (Regional Operations Manager)</cfif><br />
                    This task has a due date of: #dateformat(NCEnteredDueDate, "mm/dd/yyyy")#<br /><br />
                    
                    Click below to open the audit: #varAuditIdentifier#<br />
					<a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />
        
                    Technical Audit Manager - Please log in to the IQA Audit Database to view the audit details and perform the assigned task.
                </cfmail>
                
                <cfif Form.YesNoItem eq "NoSR" OR Form.YesNoItem eq "NoCAR">
					<cfif Audit.AuditType2 eq "Full">
                        <cfmail
                            to="#Audit.EngManagerEmail#"
                            cc="#getROM.SQM#, #Audit.ROM#"
                            replyto="#ReplyTo#"
                            from="#Request.TechnicalAuditMailbox#"
                            subject="Internal Technical Audit (#AuditType2#) - Due Date for Corrective Actions to be Completed"
                            query="Audit"
                            type="html">
                            Greetings -<br /><br />
                            
                            This email is notification that the appeal decision has been completed and you have been assigned tasks for this audit.<br /><br />
                            
                            Tasks Assigned to: #Audit.EngManagerEmail# (Engineering Manager)<br /><br />
                            
                            Tasks:<Br />                            
                            1. Communicate <cfif Form.YesNoItem eq "YesSR">SR<cfelseif Form.YesNoItem eq "YesCAR">CAR</cfif> Number(s) to the SQM and ROM (listed below)<br />
                            2. Due Date for the Corrective Action(s) to be completed: #dateformat(SRCARDueDate, "mm/dd/yyyy")#. This information must be communicated to the SQM and ROM.<br /><br />
                            
                            Click below to open the audit: #varAuditIdentifier#<br />
					<a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a><br /><br />
                            
                            If you have any questions, please contact any member of the Technical Audit Team.<br /><br />
                            
                            Regards,<br /><br />
                            
                            Technical Audit Team<br /><br />
                            
                            <cfif len(Audit.TAM)>
                                #TAM# (Technical Audit Manager)
                            <cfelse>
                                #Request.TechnicalAuditMailbox# (Technical Audit Manager)
                            </cfif><br />
                            
                            #ROM# (Regional Operations Manager)<br />
                            #getROM.SQM# (Site Quality Manager)
                        </cfmail>
                    </cfif>
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
            <cfmail
                to="#incTo#"
                from="#Request.TechnicalAuditMailbox#"
                cc="#incCC#"
                replyto="#ReplyTo#"
                subject="Internal Technical Audit (#AuditType2#) - Appeal Response Submitted, Appeal Decision Assigned"
                query="Audit"
                type="html">
                This is a notification that the PDE has submitted their appeal response and you have been assigned the task of reviewing that decision.<Br /><br />
                
                Task Assigned to: #AppealDecisionEmail#<br />
                <cfif Audit.AuditType2 eq "Full">
                Note - #ROM# and #AssignTaskTo# can also accomplish this task<br /><br />
                </cfif>
                
                Click below to open the audit: #varAuditIdentifier#<br />                
                <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                Link to Audit
                </a><br /><br />

                This task has a due date of: #dateformat(AppealResponseDueDate, "mm/dd/yyyy")#
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
                NCEnteredAssignEmail = '#getROM.SQM#',
                NCEnteredAssign = 'Yes',
                
                <cfif Audit.AuditType2 eq "Full">
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
                </cfif>
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
                NCEnteredAssignEmail = '#getROM.SQM#',
                NCEnteredAssign = 'Yes',
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
            
            <cfif Form.YesNoItem eq "YesSR" OR Form.YesNoItem eq "YesCAR" OR Form.YesNoItem eq "Yes">
                <cfif Audit.AuditType2 eq "Full">
                    <cfset incTO = "#getROM.SQM#">
                    <cfset incCC = "#Audit.ROM#, #ReplyTo#, #Audit.EngManagerEmail#">
                <cfelseif Audit.AuditType2 eq "In-Process">
                    <cfset incTO = "#getROM.SQM#">
                    <cfset incCC = "#ReplyTo#, #Audit.EngManagerEmail#">
                </cfif>
            <cfelseif Form.YesNoItem eq "No">
                <cfif Audit.AuditType2 eq "Full">
                    <cfset incTO = "#ReplyTo#">
                    <cfset incCC = "#Audit.EngManagerEmail#">
                <cfelseif Audit.AuditType2 eq "In-Process">
                    <cfset incTO = "#ReplyTo#">
                    <cfset incCC = "#Audit.EngManagerEmail#">
                </cfif>
            </cfif>
            
            <cfif Audit.AuditType2 eq "Full">
				<!--- email to Eng Manager and SQM about SRCARClosedDueDate --->
                <cfif Form.YesNoItem eq "YesSR" OR Form.YesNoItem eq "YesCAR">
                    <cfmail
                        to="#Audit.EngManagerEmail#"
                        cc="#getROM.SQM#, #Audit.ROM#"
                        replyto="#ReplyTo#"
                        from="#Request.TechnicalAuditMailbox#"
                        subject="Internal Technical Audit (#AuditType2#) - Due Date for Corrective Actions to be Completed"
                        query="Audit"
                        type="html">
                        Audit: #varAuditIdentifier#<br />
                        Step Completed: Appeal Decision Completed<br /><br />
                        
                        Required Actions by #Audit.EngManagerEmail# (Engineering Manager)<Br />
                        1. Communicate <cfif Form.YesNoItem eq "YesSR">SR<cfelseif Form.YesNoItem eq "YesCAR">CAR</cfif> Number(s) to the SQM and ROM (listed below)<br />
                        2. Due Date for the Corrective Action(s) to be completed: #dateformat(SRCARDueDate, "mm/dd/yyyy")#. This information must be communicated to the SQM and ROM.<br /><br />
                        
                        SQM: #getROM.SQM#<br />
                        ROM: #ROM#<br /><br />
                        
                        <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">Link to Audit</a>
                    </cfmail>    
                </cfif>
                <!--- /// --->
            </cfif>
            
            <!--- send email to TAM that report has been uploaded and NC Entering is scheduled and due on NCReviewDuedate --->
            <!--- To field: Technical Audit Manager goes here --->
            <cfmail
                to="#incTo#"
                from="#Request.TechnicalAuditMailbox#"
                cc="#incCC#"
                replyto="#ReplyTo#"
                subject="Internal Technical Audit (#AuditType2#) - Appeal Decision Completed, Non-Conformance Input Assigned"
                query="Audit"
                type="html">
				This is notification that the appeal decision is completed.<br /><br />

                You have been assigned the task of inputting the NCs into the Technical Audit Database.<br /><br />
                
				Task Assigned To: Assigned To: #getROM.SQM# (Site Quality Manager)<br />
				<cfif Audit.AuditType2 eq "Full">
                Note - #ROM# (Regional Operations Manager) can also accomplish this task<br /><br />
                </cfif>

                Click below to open the audit: #varAuditIdentifier#<br />                
                <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                Link to Audit
                </a><br /><br />

				This task has a due date of: #dateformat(NCEnteredDueDate, "mm/dd/yyyy")#
                <!---<cfelseif Form.YesNoItem eq "No">
					<cfset Email_CurrentStep = "Audit Ready to be Closed">
					Required Action: #Email_CurrentStep#<br />
					Assigned To: Technical Audit Manager<br />
					Note: No Non-Conformances Remain after Appeals<br />
					Status: Audit Ready to be Closed<br /><br />
					
					Technical Audit Manager: Please log in to the IQA Audit Database to view this audit.
				</cfif>--->
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
            
            <cfif Audit.AuditType2 eq "In-Process">
            AuditClosed = 'Yes',
            AuditCloseddate = #createODBCDate(curdate)#,
            AuditClosedConfirm = 'No',
            <cfelseif Audit.AuditType2 eq "Full">            
				<cfif Audit.NCExistPostAppeal eq "No">
                    <cfset Email_CurrentStep = "Audit Ready to be Closed">
                    AuditClosed = 'Yes',
                    AuditCloseddate = #createODBCDate(curdate)#,
                    AuditClosedConfirm = 'No',
                <cfelse>
                    CurrentDueDate = #createODBCDate(Audit.SRCARClosedDueDate)#,
                    CurrentDueDateFIeld = 'SRCARClosedDueDate',
				</cfif>
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
            
            <cfif Audit.AuditType2 eq "Full">
                <cfif Audit.NCExistPostAppeal eq "No">
					<!--- send email to SQM that report and NCs have been completed, and include SR/CAR Closure Due Date information --->
                    <cfmail
                        to="#ReplyTo#"
                        from="#Request.TechnicalAuditMailbox#"
                        replyTo="#ReplyTo#"
                        subject="Internal Technical Audit (#AuditType2#) - Non-Conformance Input Completed, Audit Ready to be Closed"
                        query="Audit"
                        type="html">
                        This is notification that the nonconformance information has been entered into the Technical Audit Database. There are No NCs after appeals and the Audit is ready to be closed.<br /><br />
                        Required Action: Audit Ready to be Closed<br /><br />          
                        
                        Click below to open the audit: #varAuditIdentifier#<br />                
                        <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                        Link to Audit
                        </a><br /><br />
                    </cfmail>
                    <!--- /// --->                	
                <cfelse>
					<!--- send email to SQM that report and NCs have been completed, and include SR/CAR Closure Due Date information --->
                    <cfmail
                        to="#getROM.SQM#"
                        from="#Request.TechnicalAuditMailbox#"
                        replyto="#ReplyTo#"
                        subject="Internal Technical Audit (#AuditType2#) - Non-Conformance Input Completed"
                        query="Audit"
                        type="html">
                        This is notification that the nonconformance information has been entered into the Technical Audit Database. Corrective Actions need to be closed by the due date listed below. Please work with #Audit.EngManagerEmail# to ensure these actions are completed.<br /><br />
                                                
                        Task assigned to: #getROM.SQM# (Site Quality Manager)<Br />
                        This task has a due date of #dateformat(SRCARClosedDueDate, "mm/dd/yyyy")#<br /><br />
                        
                        Click below to open the audit: #varAuditIdentifier#<br />                
                        <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                        Link to Audit
                        </a>
                    </cfmail>
                    <!--- /// --->
				</cfif>
            <cfelseif Audit.AuditType2 eq "In-Process">
                <!--- send email to TAM that report and NCs have been completed and the audit is ready to close --->
                <cfmail
                    to="#getROM.SQM#"
                    from="#Request.TechnicalAuditMailbox#"
                    replyto="#ReplyTo#"
                    subject="Internal Technical Audit (#AuditType2#) - Non-Conformance Input Completed - Audit Ready to be Closed"
                    query="Audit"
                    type="html">
                    This is notification that the nonconformance information has been entered into the Technical Audit Database. The Audit is ready to be closed.<br /><br />

                    Required Action: Audit Ready to be Closed<br /><br />          
                    
                    Click below to open the audit: #varAuditIdentifier#<br />                
                    <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit
                    </a><br /><br />
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
     
            <!--- update TechnicalAudits_AuditSchedule table --->
            <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
            UPDATE TechnicalAudits_AuditSchedule
            SET
              
            <cfif Form.YesNoItem eq "Yes">
                <Cfset VerifiedDueDate = DateAdd('d', 14, curdate)>
                
                <cfif isDefined("Form.EmpNo")>
                SRCARClosedName = '#NameLookup.employee_email#',
                </cfif>
                
                SRCARClosed = 'Yes', 
                SRCARClosedDate = #createODBCDate(curdate)#,
                SRCARVerifiedDueDate = #createODBCDate(VerifiedDueDate)#,
                
                CurrentDueDate = #createODBCDate(VerifiedDueDate)#,
                CurrentDueDateFIeld = 'SRCARVerifiedDueDate',
                
                <cfset Flag_CurrentStep = "Corrective Actions Completed">
                Flag_CurrentStep = 'Corrective Actions Completed'
            <cfelseif Form.YesNoItem eq "No">
	            <Cfset newDueDate = DateAdd('d', 14, SRCAR.SRCARClosedDueDate)>
            
                SRCARClosed = 'No',
                SRCARClosedDueDate = #createODBCDate(newDueDate)#,
                
                CurrentDueDate = #createODBCDate(newDueDate)#,
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
                SRCARVerifiedDueDate = #createODBCDate(DateAdd('d', 14, curdate))#
            <cfelseif Form.YesNoItem eq "No">
            	<Cfset newDueDate = DateAdd('d', 14, SRCAR.SRCARClosedDueDate)>
                
                SRCARClosed = 'No',
                SRCARClosedDueDate = #createODBCDate(newDueDate)#
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
                
                <!--- send email to SQM that report and Corrective Actions have been completed, and include SR/CAR Verify Due Date information --->
                <cfmail
                    to="#getROM.SQM#"
                    from="#Request.TechnicalAuditMailbox#"
                    replyto="#ReplyTo#"
                    subject="Internal Technical Audit (#AuditType2#) - Corrective Actions Completed"
                    query="Audit"
                    type="html">
                    This is notification that corrective actions have been completed for a #AuditType2# Technical Audit and this audit is ready to have the corrective actions verified.<br /><br />
                    
					Task Assigned To: #getROM.SQM# (Site Quality Manager)<br />
                    Note - #ROM# (Regional Operations Manager) can also accomplish this task<br /><br />
                    
                    This task has a due date of #dateformat(SRCARVerifiedDueDate, "mm/dd/yyyy")#<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />                
                    <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit
                    </a>
                </cfmail>
                <!--- /// --->
            <cfelseif Flag_CurrentStep eq "Non-Conformance Input Completed">
                <!--- send email to SQM that report and Corrective Actions have NOT been completed, and include NEW SR/CAR Complete Due Date information --->
                <cfmail
                    to="#getROM.SQM#"
                    from="#Request.TechnicalAuditMailbox#"
                    replyTo="#ReplyTo#"
                    subject="Internal Technical Audit (#AuditType2#) - Corrective Actions Not Completed - New Due Date Set"
                    query="Audit"
                    type="html">
                    This is notification that corrective actions have NOT been completed for this #AuditType2# Technical Audit.<br /><br />
                    
					Task Assigned To: #getROM.SQM# (Site Quality Manager)<br />
                    Note - #ROM# (Regional Operations Manager) can also accomplish this task<br /><br />
                    
                    This task has a new due date of #dateformat(newDueDate, "mm/dd/yyyy")#<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />                
                    <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit</a>
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
            	<Cfset newDueDate = DateAdd('d', 14, SRCAR.SRCARVerifiedDueDate)>
            	
                CurrentDueDate = #createODBCDate(newDueDate)#,
                CurrentDueDateFIeld = 'SRCARVerifiedDueDate',
                
                SRCARVerified = 'No',
                SRCARVerifiedDueDate = #createODBCDate(newDueDate)#,
            
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
            	<Cfset newDueDate = DateAdd('d', 14, SRCAR.SRCARVerifiedDueDate)>
                
                SRCARVerified = 'No',
                SRCARVerifiedDueDate = #createODBCDate(newDueDate)#
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
                <cfmail
                    to="#ReplyTo#"
                    from="#Request.TechnicalAuditMailbox#"
                    cc="#getROM.SQM#, #Audit.ROM#, #ReplyTo#"
                    replyTo="#ReplyTo#"
                    subject="Internal Technical Audit (#AuditType2#) - Corrective Actions Verified"
                    query="Audit"
                    type="html">
                    This is notification that corrective actions have been completed and verified for a #AuditType2# Technical Audit and this audit is ready to be closed.<br /><br />
                    
                    Click below to open the audit: #varAuditIdentifier#<br />                
                    <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit
                    </a>
                </cfmail>
                <!--- /// --->
            <cfelseif Flag_CurrentStep eq "Corrective Actions Completed">
                <!--- send email to SQM that report and Corrective Actions have NOT been completed, and include NEW SR/CAR Complete Due Date information --->
                <cfmail
                    to="#getROM.SQM#"
                    from="#Request.TechnicalAuditMailbox#"
                    cc="#ReplyTo#"
                    replyTo="#ReplyTo#"
                    subject="Internal Technical Audit (#AuditType2#) - Corrective Actions Not Verified - New Due Date Set"
                    query="Audit"
                    type="html">
                    This is notification that corrective actions have NOT been verified for this #AuditType2# Technical Audit.<br /><br />
                    
					Task Assigned To: #getROM.SQM# (Site Quality Manager)<br />
                    Note - #ROM# (Regional Operations Manager) can also accomplish this task<br /><br />
                    
                    This task has a new due date of #dateformat(newDueDate, "mm/dd/yyyy")#<br /><br />

                    Click below to open the audit: #varAuditIdentifier#<br />                
                    <a href="http://usnbkiqas100p/departments/snk5212/IQA/TechnicalAudits_getRole.cfm?page=TechnicalAudits_AuditDetails&ID=#URL.ID#&Year=#URL.Year#">
                    Link to Audit</a>
                </cfmail>
                <!--- /// --->
            </cfif>
		</cfif>
        
		<cfif URL.Action eq "Engineering Manager Review Completed" AND Form.YesNoItem eq "No">
            <cfset HistoryInclude = "No Appeals<br>">
        <cfelseif URL.Action eq "Non-Conformance Input Completed">
            <cfset HistoryInclude = "Non-Conformance Input Completed">
        <cfelseif URL.Action eq "Audit Executed - Audit Report Posted" AND Form.YesNoItem eq "No">
            <Cfset HistoryInclude = "No Non-Conformances or CNBDs were found<br>">
        <cfelseif URL.Action eq "Appeal Decision Completed" AND Form.YesNoItem eq "No">
            <cfset HistoryInclude = "No Non-Conformances remain after Appeal Decision<br>">
        <cfelseif URL.Action eq "Corrective Actions Complete" AND Form.YesNoItem eq "Yes">
            <cfset HistoryInclude = "Corrective Actions Completed<br>">
        <cfelseif URL.Action eq "Corrective Actions Complete" AND Form.YesNoItem eq "No">
            <cfset HistoryInclude = "Corrective Actions Not Completed - New Due Date Assigned<br>">
        <cfelseif URL.Action eq "Corrective Actions Verified" AND Form.YesNoItem eq "Yes">
            <cfset HistoryInclude = "Corrective Actions Verified<br>">
        <cfelseif URL.Action eq "Corrective Actions Verified" AND Form.YesNoItem eq "No">
            <cfset HistoryInclude = "Corrective Actions Not Verified - New Due Date Assigned<br>">
        <cfelse>
            <cfset HistoryInclude = "">
        </cfif>
        
        <cfset HistoryUpdate = "Current Step: #Flag_CurrentStep#<br>#HistoryInclude#Action by: [Role]<br>Date: #curdate# #curTime#">
        
        <!--- history update --->
        <CFQUERY BLOCKFACTOR="100" NAME="updateAuditSchedule" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
        UPDATE TechnicalAudits_AuditSchedule
        SET
        
        History = <CFQUERYPARAM VALUE="#Audit.History#<br /><br />#HistoryUpdate#" CFSQLTYPE="CF_SQL_CLOB">
        
        WHERE
        ID = #URL.ID#
        AND Year_ = #URL.Year#
        </CFQUERY>
        
        <cflocation url="TechnicalAudits_AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#" addtoken="no">
 	<cfelse>
	   	<!--- yesNoItem not selected --->
       	<cflocation url="TechnicalAudits_ReportUpload.cfm?ID=#URL.ID#&Year=#URL.Year#&Action=#URL.Action#&msg=Please Select Yes/No" addtoken="no">
	</cfif>

<!--- form no submitted --->
<cfelse>

<cfif isDefined("url.msg")>
	<cfoutput>
    	<font class="warning"><b>Validation Error</b>: #url.msg#</font><br /><br />
    </cfoutput>
</cfif>

<!---
<cfif isDefined("Form.Upload")>
	<b><font class="warning">Form Validation Issues</font></b><br />
   	<u>Audit Report Upload</u>: Please attach the file.<br />
    <cfif URL.Action eq "Audit Executed - Audit Report Posted" OR URL.Action eq "Appeal Decision Completed">
    	<cfset Item = "Non-Conformances">
	<cfelseif URL.Action eq "Engineering Manager Review Completed">
    	<cfset Item = "Appeals">
	</cfif>
	
    <cfif URL.Action neq "Non-Conformance Review Completed" AND URL.Action neq "Appeal Response Completed">
	   	<u>Are there <cfoutput>#Item#</cfoutput> from this Audit?</u>: Please select Yes or No<br />
	<cfelseif URL.Action eq "Non-Conformance Review Completed">
    	<u>Do you want to upload a revised report?</u>: Please select Yes or No<br />
	</cfif><br />
</cfif>
--->

<Cfoutput>

<!--- included for Form Validation and Formatted Form Textarea boxes --->
<!--- form name and id must be "myform" --->
<cfinclude template="#SiteDir#SiteShared/incValidator.cfm">

    <form action="#CGI.Script_Name#?#CGI.Query_String#" enctype="multipart/form-data" method="post" name="myform" id="myform">
    
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
		
		<cfif Audit.AuditType2 eq "Full">
            Are there Appeals from this Audit?<br />
            
            <b>Appeals Exist</b><br />
            Yes <input type="radio" name="YesNoItem" value="Yes" /><br /><br />
            
            <b>No Appeals</b><br />
            Is Testing or Construction Review required as a result of the Audit Non-Conformances?<Br /><br />
            
            Testing or Construction Review is required <input type="radio" name="YesNoItem" value="NoCAR" /><br />
            Testing or Construction Review is <b><font color="red">NOT</font></b> required <input type="radio" name="YesNoItem" value="NoSR" data-bvalidator="required" data-bvalidator-msg="Please Select a value to describe the Non-Conformances" />
            <br /><br />
		<cfelse>
        	Are there Appeals from this Audit?<br />
            Yes <input type="radio" name="YesNoItem" value="Yes" /><br />
            No <input type="radio" name="YesNoItem" value="No" /><br /><br />
        </cfif>
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

        <cfif Audit.AuditType2 eq "Full">
            After the Appeal Decision, do any Non-Conformances remain?<br />
            If Yes, is Testing or Construction Review required as a result of the Audit Non-Conformances?<Br /><br />
            
            <b>Non-Conformances Exist</b><br />
            YES - Testing or Construction Review is required <input type="radio" name="YesNoItem" value="YesCAR" /><br />
            NO - Testing or Construction Review is <b><font color="red">NOT</font></b> required  <input type="radio" name="YesNoItem" value="YesSR" /><br /><br />
            
            <b>Non-Conformances Do Not Exist</b><br />
            No Non-Conformances <input type="radio" name="YesNoItem" value="No" data-bvalidator="required" data-bvalidator-msg="Please Select a value to describe the Non-Conformances" />
            <br /><br />
		<cfelse>
        	After the Appeal Decision, do any Non-Conformances remain?<br />
            
            YES <input type="radio" name="YesNoItem" value="Yes" /><br />
            NO <input type="radio" name="YesNoItem" value="No" data-bvalidator="required" data-bvalidator-msg="Please Select a value to describe the Non-Conformances" /><br /><br />
        </cfif>
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
 
        Are the Corrective Actions listed below Completed? If Yes, please upload a revised report.<Br />
        Yes <input type="radio" name="YesNoItem" value="Yes"> 
        No <input type="radio" name="YesNoItem" value="No" data-bvalidator="required" data-bvalidator-msg="Please Select Yes or No">
        <br /><br />
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
 
        Are the Corrective Actions listed below Verified? If Yes, please upload a revised report.<Br />
        Yes <input type="radio" name="YesNoItem" value="Yes"> 
        No <input type="radio" name="YesNoItem" value="No" data-bvalidator="required" data-bvalidator-msg="Please Select Yes or No">
        <br /><br />
	<cfelse>
    	<input type="hidden" name="YesNoItem" value="NA" />
    </cfif>

        <input type="submit" name="upload" value="Submit Form and Continue">
        <input type="reset" name="upload" value="Reset Form"><br /><br />
    </form>
    
<!--- required for form validation --->
<cfinclude template="#SiteDir#SiteShared/incbValidatorReadyForm.cfm">

	<cfif URL.Action eq "Corrective Actions Completed" OR URL.Action eq "Corrective Actions Completed">
        <br /><Br />
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