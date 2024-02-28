<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Audit Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cflock scope="session" timeout="5">
<cfif isDefined("Form.EmpNo")>
    <!--- check if the following roles are accessing the page:
	ROM, Engineering Manager, Engineering Director, Auditor, Auditor's Manager, SQM, Industry Contact, Project Handler (?)
	 --->
    <CFQUERY NAME="qEmpLookup" datasource="OracleNet">
    SELECT employee_email
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    WHERE employee_number = '#Form.EmpNo#'
    </CFQUERY>
       
    <cfquery Datasource="UL06046" name="checkRole"> 
    SELECT 
        UL06046.TechnicalAudits_AuditSchedule.AuditorEmail, UL06046.TechnicalAudits_AuditSchedule.AuditorManagerEmail, UL06046.TechnicalAudits_AuditSchedule.EngManagerEmail, UL06046.TechnicalAudits_AuditSchedule.EngManagerDirectorEmail, Corporate.IQAtblOffices.TechnicalAudits_SQM, Corporate.IQARegion.TechnicalAudits_ROM, UL06046.TechnicalAudits_Industry.Contact, UL06046.TechnicalAudits_AuditSchedule.AppealResponseEmail, UL06046.TechnicalAudits_AuditSchedule.AppealDecisionEmail, UL06046.TechnicalAudits_AuditSchedule.NCEnteredAssignEmail
    FROM 
        UL06046.TechnicalAudits_AuditSchedule, Corporate.IQAtblOffices, Corporate.IQARegion, UL06046.TechnicalAudits_Industry
    WHERE 
        UL06046.TechnicalAudits_AuditSchedule.ID = #URL.ID#
    	AND UL06046.TechnicalAudits_AuditSchedule.Year_ = #URL.Year#
    	AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = Corporate.IQAtblOffices.OfficeName
        AND UL06046.TechnicalAudits_AuditSchedule.Region = Corporate.IQARegion.Region
        AND UL06046.TechnicalAudits_AuditSchedule.Industry = UL06046.TechnicalAudits_Industry.Industry
    </CFQUERY>

	<!--- check for access roles --->
	<cfif qEmpLookup.employee_email eq checkRole.AuditorEmail
    	OR qEmpLookup.employee_email eq checkRole.AuditorManagerEmail
        OR qEmpLookup.employee_email eq checkRole.EngManagerEmail
        OR qEmpLookup.employee_email eq checkRole.EngManagerDirectorEmail
        OR qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
        OR qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
        OR qEmpLookup.employee_email eq checkRole.Contact
        OR qEmpLookup.employee_email eq checkRole.AppealResponseEmail
		OR qEmpLookup.employee_email eq checkRole.AppealDecisionEmail
		OR qEmpLookup.employee_email eq checkRole.NCEnteredAssignEmail>
        
<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT 
	*
FROM 
	TechnicalAudits_AuditSchedule
WHERE
	ID = #URL.ID#
    AND Year_ = #URL.Year#
</cfquery>

<cfif isDefined("url.msg")>
	<cfoutput>
		<font class="warning"><b>Update:</b> #url.msg#</font><br /><br />
    </cfoutput>
</cfif>

<cfoutput query="Audit">
	<!--- Audit Type = Full or In-Process--->
	<cfif AuditType2 eq "Full" OR AuditType2 eq "In-Process">
    	<!--- Audit Approved = Yes --->
        <cfif Approved eq "Yes">
            <b>Required Audit Details</b>: Completed<br />
            <b>Audit Details Status</b>: Audit Details Completed on #dateformat(ApprovedDate, "mm/dd/yyyy")#<br />
			<!--- Auditor has been assigned by ROM/TAM --->
			<cfif AuditorAssigned EQ "Yes">
            	<!--- Auditor has been informed of audit --->
                <cfif len(AuditorAssignmentLetterDate)>
					<b>Auditor Assignment Letter</b>: Sent on #dateformat(AuditorAssignmentLetterDate, "mm/dd/yyyy")#<br />
                    <b>Audit Execution Status</b>: 
					<!--- Audit Report File has been Uploaded--->
					<cfif ReportPosted eq "Yes">
						<!--- query to get details --->
                        <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                        SELECT ReportFileName, DatePosted
                        FROM TechnicalAudits_ReportFiles
                        WHERE AuditID = #URL.ID#
                        AND AuditYear = #URL.Year#
                        AND Flag_CurrentStep = 'Audit Completed - Audit Report Posted'
                        </cfquery>
                        
                    	Report Posted on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# [<a href="TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]<br />
						<!--- NCs were identified --->
                        <cfif NCExist eq "Yes">
                           	<!--- NCs have been reviewed --->
                            <B>Non-Conformance Review Status</B>:
							<cfif NCReview eq "Yes">
                            	Non-Conformances Reviewed on #dateformat(NCReviewDate, "mm/dd/yyyy")# 
									<!--- query to get details --->
                                    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                    SELECT ReportFileName, DatePosted
                                    FROM TechnicalAudits_ReportFiles
                                    WHERE AuditID = #URL.ID#
                                    AND AuditYear = #URL.Year#
                                    AND Flag_CurrentStep = 'Non-Conformance Review Completed'
                                    </cfquery>
                                    
                                    <!--- view report file --->
                                    [<a href="TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]<br />
                                    
                                    <b>Engineering Manager Review Status</b>: 
									<!--- NCs have been Assigned to Engineering Manager --->
                                    	<cfif EngManagerAssign eq "Yes">
                                            <!--- Engineering Manager Review Completed --->
                                            <cfif EngManagerReview eq "Yes">
                                            	Engineering Manager Review Completed on #dateformat(EngManagerReviewDate, "mm/dd/yyyy")#<br />
												<!--- query to get details --->
                                                <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                SELECT ReportFileName, DatePosted
                                                FROM TechnicalAudits_ReportFiles
                                                WHERE AuditID = #URL.ID#
                                                AND AuditYear = #URL.Year#
                                                AND Flag_CurrentStep = 'Engineering Manager Review Completed'
                                                </cfquery>
                                                
                                                <!--- view report file --->
                                    			[<a href="TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]<br />
                                    
                                                <!--- There are appeals --->
                                                <cfif AppealExist eq "Yes"> 
													<!--- Appeal Response has been completed --->
													<cfif AppealResponse eq "Yes">
                                                        <b>Appeal Response Status</b>
                                                        Appeal Response Completed on #dateformat(AppealResponseDate, "mm/dd/yyyy")#<br />
                                                        
                                                        <!--- query to get details --->
                                                        <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                        SELECT ReportFileName, DatePosted
                                                        FROM TechnicalAudits_ReportFiles
                                                        WHERE AuditID = #URL.ID#
                                                        AND AuditYear = #URL.Year#
                                                        AND Flag_CurrentStep = 'Appeal Response Completed'
                                                        </cfquery>
                                                            
                                                        <!--- view report file --->
                                                        [<a href="TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]<br />
                                                            
                                                        <!--- Appeals Decision has been completed --->
                                                        <cfif AppealDecision eq "Yes">
                                                            <b>Appeal Decision Status</b>:
                                                            Appeal Decision Completed on #dateformat(AppealDecisionDate, "mm/dd/yyyy")#<br />
                                                            
                                                            <!--- query to get details --->
                                                            <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                            SELECT ReportFileName, DatePosted
                                                            FROM TechnicalAudits_ReportFiles
                                                            WHERE AuditID = #URL.ID#
                                                            AND AuditYear = #URL.Year#
                                                            AND Flag_CurrentStep = 'Appeal Decision Completed'
                                                            </cfquery>
                                                            
                                                            <!--- view report file --->
                                                            [<a href="TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]<br />
                                                            
                                                            <!--- NCs Exist after Appeals --->
                                                            <cfif NCExistPostAppeal eq "Yes">
                                                                <b>Non-Conformance Input Assignment</b>: 
                                                                <!--- NC Input has been Assigned --->
                                                                <cfif NCEnteredAssign eq "Yes">
                                                                    Assigned on #Dateformat(NCEnteredAssignDate, "mm/dd/yyyy")# to #NCEnteredAssignEmail#<br />
																		<!--- NCs have been entered --->
                                                                        <cfif NCEntered eq "Yes">
                                                                        	NCs Entered<br />
                                                                        <!--- NCs have NOT been entered --->
                                                                        <cfelse>
                                                                        	Awaiting NC Input<br />
																			<!--- Person Assigned to Enter NCs can do this step --->
                                                                            <cfif qEmpLookup.employee_email eq checkRole.NCEnteredAssignEmail>
                                                                             :: <a href="TechnicalAudits_AddNC_SelectCategory.cfm?#CGI.QUERY_STRING#">
                                                                                    Input Non-Conformances
                                                                                </a><br />
                                                                            </cfif>
																		</cfif>
                                                                <!--- NC Input has NOT been Assigned --->
                                                                <cfelse>
                                                                    Awaiting Assignment<br /> 
                                                                </cfif>
                                                            <!--- NCs do NOT exist after Appeals --->
                                                            <cfelse>
                                                                No Non-Conformances remain after Appeals<br />
                                                                <b>Audit Status</b>: <font class="warning"><b>Audit Completed and Closed</b></font><br />
                                                            </cfif>
                                                        <!--- Appeal Decision has NOT been completed --->
                                                        <cfelse>
                                                            <!--- Appeal Decision has been Assigned --->
                                                            <cfif AppealDecisionAssign eq "Yes">
                                                                <b>Appeal Descision Assignment Status</b>: 
                                                                Assigned to #AppealDecisionEmail# on #dateformat(AppealDecisionAssignDate, "mm/dd/yyyy")# 
                                                                (Due #dateformat(AppealDecisionDueDate, "mm/dd/yyyy")#)<br />
                                                               
                                                                <!--- Person Assigned Appeal Decision can do this step --->
																<cfif qEmpLookup.employee_email eq checkRole.AppealDecisionEmail
																	OR qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
        															OR qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM>
                                                                 :: <a href="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&Action=Appeal Decision Completed">
                                                                        Upload Audit Report
                                                                    </a><br />
                                                                </cfif>
                                                            <!--- Appeal Decision has NOT been Assigned --->
                                                            <cfelse>
                                                                Awaiting Appeal Decision Assignment by Technical Audit Manager<br />
                                                            </cfif>
                                                        </cfif>													
                                                    <!--- Appeal Response has NOT been completed --->
                                                    <cfelse>
                                                        <!--- Appeal Response Assignment Complete --->
                                                        <cfif AppealResponseAssign eq "Yes">
                                                            <b>Appeal Response Assignment Status</b>:
                                                            Assigned to #AppealResponseEmail# on #dateformat(AppealResponseAssignDate, "mm/dd/yyyy")# 
                                                            (Due #dateformat(AppealResponseDueDate, "mm/dd/yyyy")#)<br />
                                							
															<!--- Person Assigned Appeal Response can do this step --->
															<cfif qEmpLookup.employee_email eq checkRole.AppealResponseEmail>
                                                             :: <a href="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&Action=Appeal Response Completed">
                                                                    Upload Audit Report
                                                                </a><br />
                                                            </cfif>
                                                        <!--- Appeal Response Assignment NOT Complete --->
                                                        <cfelse>
                                                            Awaiting Appeal Response Assignment by Technical Audit Manager<br />
                                                        </cfif>
                                                    </cfif>
												<!--- There are NO appeals --->
												<cfelse>
													No Appeals<br />
                                                    <!--- Input of NCs has been assigned --->
													<B>Non-Conformance Input Status</B>: 
													<cfif NCEnteredAssign eq "Yes">
                                                        Assigned to #NCEnteredAssignEmail# on #dateformat(NCEnteredAssignDate, "mm/dd/yyyy")# 
                                                        (Due #Dateformat(NCEnteredAssignDueDate, "mm/dd/yyyy")#)<Br />
                                                        <!--- NCs have been entered --->
                                                        <cfif NCEntered eq "Yes">
                                                            Entered on #dateformat(NCEnteredDate, "mm/dd/yyyy")# by #NCEnteredAssignEmail# [view]<br />
                                                        <!--- NCs have NOT been entered --->
                                                        <cfelse>
                                                            Awaiting Non-Conformance Input<br />
                                                            <!--- Enter Item/Sub Item and SR/CARs --->
                                                            <cfif qEmpLookup.employee_email eq checkRole.NCEnteredAssignEmail>
                                                                :: <a href="TechnicalAudits_AddNC_SelectCategory.cfm?#CGI.QUERY_STRING#">Input Non-Conformances</a><br />
                                                            </cfif>
                                                        </cfif>
                                                    <!--- Input of NCs has NOT been assigned --->
													<cfelse>
                                                    	Awaiting Assignment of Non-Conformance Input by Technical Audit Manager<br />
                                                	</cfif>                                                	
												</cfif>
                                            <!--- Engineering Manager Review NOT Complete --->
                                            <cfelse>
												Assigned to Engineering Manager on #dateformat(EngManagerDate, "mm/dd/yyyy")# (Due #dateformat(EngManagerDueDate, "mm/dd/yyyy")#)<br />
                                                <!--- Eng Manager or Eng Director can do this step --->
												<cfif qEmpLookup.employee_email eq checkRole.EngManagerEmail
													OR qEmpLookup.employee_email eq checkRole.EngManagerDirectorEmail>
                                                 	 :: <a href="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&Action=Engineering Manager Review Completed">
                                                 		Upload Audit Report
                                                    </a><br />
                                                 </cfif>
											</cfif>
										<!--- NCs have NOT been Assigned to Engineering Manager --->
                                        <cfelse>
                                            Awaiting Assignment of Non-Conformances to Engineering Manager by Technical Audit Manager<br />
                                        </cfif>
                            <!--- NCs have NOT been reviewed --->
							<cfelse>
								<cfif NCReviewDueDate LT CurDate>
                                    <!--- NC Review Due Date has passed --->
                                    Non-Conformance Review Overdue 
                                <cfelseif NCReviewDueDate EQ CurDate>
                                    <!--- NC Review Due Today --->
                                    Awaiting Non-Conformance Review 
                                <cfelseif NCReviewDueDate GT CurDate>
                                    <!--- NC Review Scheduled --->
                                    Non-Conformance Review Scheduled 
                                </cfif>
                                (Due #dateformat(NCReviewDueDate, "mm/dd/yyyy")#)<br />
                            </cfif>
                    	<!--- No NCs identified --->
                        <cfelseif NCExist eq "No">
                        	<u>Note</u>: No Non-Conformances were found<br />
                            <!--- Is the audit closed? This should ALWAYS be Yes in this case --->
                            <cfif AuditClosed eq "Yes">
                            	<b>Audit Status</b>: <font class="warning"><b>Audit Completed and Closed</b></font><br />
                            </cfif>
                        </cfif>
                    <!--- Audit Report File has NOT been Uploaded --->
					<cfelse>
                    	<cfif AuditDueDate LT CurDate>
                            <!--- Audit Due Date has passed --->
                            Audit Overdue
                        <cfelseif AuditDueDate EQ CurDate>
                            <!--- Audit Due Today --->
                            Awaiting Audit Report
                        <cfelseif AuditDueDate GT CurDate>
                            <!--- Audit Scheduled --->
                            Audit Scheduled
                        </cfif><br />
                        
                        <!--- ROM and Auditor can upload report --->
                        <cfif qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
							OR qEmpLookup.employee_email eq checkRole.AuditorEmail>
                         :: <a href="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&Action=Audit Completed - Audit Report Posted">Upload Audit Report</a><br />
                         </cfif>
					</cfif>
				<!--- Auditor has NOT been informed of audit --->
				<cfelse>
                	<b>Auditor Assignment</b>: Auditor Selected<br />
					<!--- Audit Due Date is Set, send Audit Assignment --->
					<cfif len(AuditDueDate)>
                        <b>Audit Due Date</b>: Selected - #dateformat(AuditDueDate, "mm/dd/yyyy")#<Br />
                        Awaiting Audit Assignment Letter to Regional Operations Manager by Technical Audit Manager<br>
                    <!--- Audit Due Date is NOT Set, Set Audit Due Date --->
					<cfelse>
                        <b>Audit Due Date</b>: Not Set<br />
                    </cfif>                	
                </cfif>
            <!--- Auditor has NOT been Assigned --->
			<cfelse>
				<!--- Request for Assign Auditor Letter has been sent --->
                <cfif len(AuditorAssignmentDueDate)>
                    <b>Auditor Assignment</b>: Request sent #dateformat(AuditorAssignmentRequestDate, "mm/dd/yyyy")#. Auditor Assignment due #dateformat(AuditorAssignmentDueDate, "mm/dd/yyyy")#<Br />
                        <cfif AuditorRequested eq "Yes">
	                        Auditor Requested by Regional Operations Manager: Awaiting Audit Assignment Letter<br>
                        <cfelse>
							Awaiting Auditor Assignment<Br>
                            <!--- ROM can assign Auditor here --->
                            <cfif qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM>
                                &nbsp; &nbsp; &nbsp; :: 
                                <a href="TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">
                                Assign Auditor
                                </a><br />
                            </cfif>
                        </cfif>
                <cfelse>
					<cfif AuditType2 eq "Full">
	                    Awaiting Request for Auditor to Regional Operations Manager by Technical Audit Manager
					<cfelseif AuditType2 eq "In-Process">
                    	Awaiting Auditor Assignment by Technical Audit Manager
                    </cfif>
                </cfif>
            </cfif>
        <!--- Audit Approved = No --->
		<cfelse>
        	<!--- All appropriate information has been completed --->
            <!--- Full Audit --->
			<Cfif AuditType2 eq "Full" 
				AND len(AuditType2)
				AND len(Industry)
                AND len(OfficeName)
                AND len(Month)
                AND len(ProjectNumber)
                <!---AND len(FileNumber)--->
                AND len(RequestType)
                <!---AND len(Standard)--->
                AND len(Program)
                AND len(ProjectHandler)
                AND len(ProjectHandlerDept)
                AND len(ProjectHandlerOfficeName)
                AND len(ProjectFR) 
                AND len(ProjectFRDept) 
                AND len(ProjectFROfficeName) 
                <!---AND len(ProjectFROfficeType)--->
                AND len(ProjectPR)
                <!---AND len(ProjectPRDept)--->
                <!---AND len(ProjectPROfficeName)--->
				
				<!--- In-Process Audit --->
				OR AuditType2 eq "In-Process"
				AND len(AuditType2) 
				AND len(Industry)
				AND len(OfficeName)
				AND len(Month)
				AND len(ProjectNumber)
				<!---AND len(FileNumber)--->
				AND len(RequestType)
				<!---AND len(Standard)--->
				AND len(Program)
				AND len(ProjectHandler)
				AND len(ProjectHandlerDept)
				AND len(ProjectHandlerOfficeName)
				AND len(ProjectPrimeReviewer) 
				AND len(ProjectPrimeReviewerDept) 
				AND len(ProjectPrimeReviewerOfficeName)>
                    
                    <!--- Required action is to set audit details to complete --->
                    <b>Required Fields</b>: Completed<br />
                    <b>Status</b>: Audit Details Incomplete<br />
                    Awaiting Completion of Audit Details by Technical Audit Manager
            <cfelse>
            	<!--- Not all required information has been entered --->
                <b>Required Fields</b>: Incomplete<br />
                <b>Status</b>: Audit Details Incomplete<br />
				Awaiting Completion of Required Fields<br />
            </Cfif>
        </cfif>
</cfif><br />

<u>Available Actions</u><br />
:: Cancel Audit<br />
:: Reschedule Audit<br />
:: <a href="TechnicalAudits_AuditDetails_viewHistory.cfm?#CGI.QUERY_STRING#">View History</a><br /><br />

<b>Technical Audit Identifier</b><br>
<cfif len(Auditor) AND len(AuditorManager)>
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

    #ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#
<cfelse>
	Not Available - Auditor must be assigned
</cfif><br><Br>

<b>Audit Number</b><br>
#URL.Year#-#URL.ID#-#AuditedBy#<br /><br>

<!---
<b>Audit Status</b><br>
#Flag_CurrentStep#
<Br /><Br />
--->

<b>Industry</b><br>
#Industry#<br /><br />

<b>Office Name</b><br>
#Region# / #OfficeName#<Br /><br />

<b>Audit Type</b><br>
#AuditType2# Technical Audit<br /><Br>

<cfif AuditType2 eq "Full">
    <b>Quarter Scheduled</b><br />
    Quarter #Month#
<cfelseif AuditType2 eq "In-Process">
    <b>Month Scheduled</b><br />
    #MonthAsString(Month)#
</cfif><br /><br />

<b>Audit Due Date</b><br />
<Cfif len(AuditorAssignmentLetterDate)>
	<cfif len(AuditDueDate)>
    	#dateformat(AuditDueDate, "mmmm dd, yyyy")#<br />
    	Audit Assignment Letter Sent on #dateformat(AuditorAssignmentLetterDate, "mm/dd/yyyy")# 
    </cfif>
<cfelseif NOT len(AuditorAssignmentLetterDate)>
	<cfif len(AuditDueDate)>
        #dateformat(AuditDueDate, "mmmm dd, yyyy")#<br />
        Audit Assignment Not Sent
    <cfelse>
        None Specified 
    </cfif>
</Cfif><br /><br />

<b>Project Number</b><br>
<cfif len(ProjectNumber)>
	#ProjectNumber#<Br />
    <cfif len(ProjectLink)>
        [<a href="#projectLink#" target="_blank">Link to Project</a>]
    <cfelse>
        None Listed
    </cfif>
<cfelse>
	<font class="warning">None Listed</font>
</cfif>
<br /><br />

<b>File Number</b><br>
<cfif len(FileNumber)>
	#FileNumber#
<cfelse>
	None Listed
</cfif>
<br><br>

<b>Project Request Type</b><br>
<cfif len(RequestType)>
	#RequestType#
<cfelse>
	<font class="warning">None Listed</font>
</cfif>
<br><br>

<b>Auditor</b><Br>
<cfif len(Auditor)>
#Auditor#<Br />

	<u>Auditor's Manager</u>: 
	<Cfif len(AuditorManager)>
    	#AuditorManager#
    <cfelse>
		<font class="warning">None Listed</font>
	</Cfif><Br />
    
    <u>Engineering Manager</u>: 
	<Cfif len(EngManager)>
	    #EngManager#
    <cfelse>
		<font class="warning">None Listed</font>
	</Cfif><Br />
    
    <u>Engineering Manager's Director</u>: 
	<Cfif len(EngManagerDirector)>
	    #EngManagerDirector#
    <cfelse>
		<font class="warning">None Listed</font>
	</Cfif><br>
<cfelse>
Auditor Not Selected<br /> 
	<!--- ROM can select auditor --->
	<cfif qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM>
        <cfif Approved eq "Yes">
            <a href="TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">[Assign Auditor]</a><br>
        </cfif>
    </cfif>
</cfif><br>

<b>CCN</b><br>
<cfif len(CCN)>
	#CCN# (Primary)
<cfelse>
	<font class="warning">None Listed</font>
</cfif><br /><br />

<cfif len(CCN2)>
	<u>Other CCNs</u><br>
	#replace(CCN2, ",", "<br />", "All")#<br /><br />
</cfif>

<b>Standard</b><br>
<cfif len(Standard)>
	#Standard# (Primary)<br>
<cfelse>
	None Listed
</cfif><br /><br />

<cfif len(Standard2)>
	<u>Other Standards</u><br>
	#replace(Standard2, ",", "<br />", "All")#<br /><br />
</cfif>

<b>Program</b><br>
<cfif len(Program)>
	#Program#
<cfelse>
	<font class="warning">None Listed</font>
</cfif><br><br>

<b>Roles</b><br>
<cfif AuditType2 eq "Full">
	<u>Project Handler</u><br>#ProjectHandler# / #ProjectHandlerOfficeName# / #ProjectHandlerDept#<Br /><br>
    
    <u>Project Preliminary Reviewer</u>
    <cfif ProjectPR eq "Waived">
    	<br />Waived
    <cfelse>
	    <br>#ProjectPR# / #ProjectPROfficeName# / #ProjectPRDept#
    </cfif><br /><br>
    
    <u>Project Final Reviewer</u><br>#ProjectFR# / #ProjectFROfficeName# / #ProjectFRDept#
<cfelse>
	<u>Project Evaluator</u><br>#ProjectHandler# / #ProjectHandlerOfficeName# / #ProjectHandlerDept#<br /><br>
	
    <u>Project Prime Reviewer</u><br>#ProjectPrimeReviewer# / #ProjectPrimeReviewerOfficename# / #ProjectPrimeReviewerDept#
</cfif><Br /><Br>

<b>Notes</b><br>
#Notes#
</cfoutput>
	<!--- no access --->
	<cfelse>
    	Access Denied
    </cfif>
<!--- form.empNo not defined --->
<cfelse>
	Invalid Page
</cfif>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->