<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Internal Technical Audits - Audit Details">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cflock scope="session" timeout="5">

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID# AND Year_ = #URL.Year#
</cfquery>

<cfif isDefined("url.msg")>
	<cfoutput>
		<font class="warning"><b>Update:</b> #url.msg#</font><br /><br />
    </cfoutput>
</cfif>

<cfif isDefined("Form.EmpNo")>
    <!--- check if there is a form.empNo and if the person/email has a role in this audit --->
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
</cfif>

<cfoutput query="Audit">
<!---<cfif SESSION.Auth.AccessLevel eq "SU" OR SESSION.Auth.AccessLevel eq "Technical Audit" OR SESSION.Auth.username eq "Oates">--->
	<!--- Audit Type = Full / In-Process --->
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
                        
						Report Posted on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# 
                        
                        <cfif Flag_CurrentStep eq "Audit Completed - Audit Report Posted">
                            [<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]
						</cfif><br />
                        
						<!--- NCs were identified --->
                        <cfif NCExist eq "Yes">
                           	<!--- NCs have been reviewed --->
                            <B>Non-Conformance Review Status</B>:
							<cfif NCReview eq "Yes">
								<!--- query to get details --->
                                <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                SELECT ReportFileName, DatePosted
                                FROM TechnicalAudits_ReportFiles
                                WHERE AuditID = #URL.ID#
                                AND AuditYear = #URL.Year#
                                AND Flag_CurrentStep = 'Non-Conformance Review Completed'
                                </cfquery>
                        
                            	Non-Conformances Reviewed on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# <!--- Alternate: NCReviewDate --->
									
								<cfif Flag_CurrentStep eq "Non-Conformance Review Completed">	                                    
                                    <!--- view report file --->
                                    [<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]
								</cfif><br />
                                    
                                    <b>Engineering Manager Review Status</b>: 
									<!--- NCs have been Assigned to Engineering Manager --->
                                    	<cfif EngManagerAssign eq "Yes">
                                            <!--- Engineering Manager Review Completed --->
                                            <cfif EngManagerReview eq "Yes">
                                            	<!--- query to get details --->
                                                <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                SELECT ReportFileName, DatePosted
                                                FROM TechnicalAudits_ReportFiles
                                                WHERE AuditID = #URL.ID#
                                                AND AuditYear = #URL.Year#
                                                AND Flag_CurrentStep = 'Engineering Manager Review Completed'
                                                </cfquery>

                                                Completed on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# <!--- Alternate: EngManagerReviewDate --->
												
												<cfif Flag_CurrentStep eq "Engineering Manager Review Completed">
													<!--- view report file --->
													[<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]
                                             	</cfif><br />
                                                
                                                <!--- There are appeals --->
                                                <cfif AppealExist eq "Yes"> 
													<!--- Appeal Response has been completed --->
													<cfif AppealResponse eq "Yes">
                                                        <b>Appeal Response Status</b>

                                                        <!--- query to get details --->
                                                        <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                        SELECT ReportFileName, DatePosted
                                                        FROM TechnicalAudits_ReportFiles
                                                        WHERE AuditID = #URL.ID#
                                                        AND AuditYear = #URL.Year#
                                                        AND Flag_CurrentStep = 'Appeal Response Completed'
                                                        </cfquery>
                                                        
                                                        Completed on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# <!--- Alternate: AppealResponseDate --->
                                                        
                                                        <cfif Flag_CurrentStep eq "Appeal Response Completed">
															<!--- view report file --->
                                                            [<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]
                                                        </cfif><br />
                                                            
                                                        <!--- Appeals Decision has been completed --->
                                                        <cfif AppealDecision eq "Yes">
                                                            <b>Appeal Decision Status</b>:
                                                            
                                                            <!--- query to get details --->
                                                            <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                            SELECT ReportFileName, DatePosted
                                                            FROM TechnicalAudits_ReportFiles
                                                            WHERE AuditID = #URL.ID#
                                                            AND AuditYear = #URL.Year#
                                                            AND Flag_CurrentStep = 'Appeal Decision Completed'
                                                            </cfquery>
                                                            
                                                            Completed on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# <!--- Alternate: AppealDecisionDate --->
                                                            
															<cfif Flag_CurrentStep eq "Appeal Decision Completed">
                                                            	<!--- view report file --->
                                                                [<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View</a>]
                                                            </cfif><br />
                                                            
                                                            <!--- NCs Exist after Appeals --->
                                                            <cfif NCExistPostAppeal eq "Yes">
                                                                <b>Non-Conformance Input Assignment</b>: 
                                                                <!--- NC Input has been Assigned --->
                                                                <cfif NCEnteredAssign eq "Yes">
                                                                    Assigned on #Dateformat(NCEnteredAssignDate, "mm/dd/yyyy")# to #NCEnteredAssignEmail#<br />
																	<!--- NC Input has been Completed, which includes SRs and CARs --->
                                                                    <cfif NCEntered eq "Yes">
                                                                    <b>Non-Conformance Input Status</b>: 
                                                                    
                                                                    <!--- query to get details --->
                                                                    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                                    SELECT ReportFileName, DatePosted
                                                                    FROM TechnicalAudits_ReportFiles
                                                                    WHERE AuditID = #URL.ID#
                                                                    AND AuditYear = #URL.Year#
                                                                    AND Flag_CurrentStep = 'Non-Conformance Input Completed'
                                                                    </cfquery>
                                                                    
                                                                    Completed on #dateformat(NCEnteredDate, "mm/dd/yyyy")# by #NCEnteredEmail#<br />
                                                                    <a href="TechnicalAudits_Reporting_Output.cfm?#CGI.QUERY_STRING#">
                                                                        View Non-Conformances
                                                                    </a><br />
                                                                    
                                                                    <cfif Flag_CurrentStep eq "Non-Conformance Input Completed">
																		<!--- view report file --->
                                                                        [<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>]
                                                                    </cfif><br />
																		<!--- SR/CARs have been Closed --->
                                                                        <cfif SRCARClosedConfirm eq "Yes">
                                                                            [SRCARClosedConfirmDate] by [SRCARClosedName]
                                                                            <!--- SR/CARs have been Verified --->
                                                                            <cfif SRCARVerifiedConfirm eq "Yes">
                                                                                [SRCARVerifiedConfirmDate] by [SRCARVerifiedName]
                                                                            <!--- SR/CARs have NOT been Verified --->
                                                                            <cfelse>
                                                                                <!--- Awaiting or Late ? --->
                                                                                Assigned to [SRCARVerifiedName] due [SRCARVerifiedDueDate]
                                                                            </cfif>
                                                                        <!--- SR/CARs have NOT been Closed --->
                                                                        <cfelse>
                                                                            <!--- Awaiting or Late ? --->
                                                                            Assigned to [SRCARClosedName] due [SRCARClosedDueDate]
                                                                        </cfif>
                                                                    <!--- NC Input has NOT been Completed --->
                                                                    <cfelse>
                                                                    	<!--- Awaiting or Late ? --->
                                                                    	Awaiting Non-Conformance Input<br />
                                                                        <!--- Access to Enter NCs: NCEnteredAssignEmail, TAM, SQM, ROM --->
																		<cfif 
																			isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.NCEnteredAssignEmail
																			OR isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
																			OR isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
																			OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																			OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																			OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
																		
                                                                         :: <a href="TechnicalAudits_AddNC_SelectCategory.cfm?#CGI.QUERY_STRING#">
                                                                         	Input NCs
                                                                            </a><Br />
                                                                        </cfif>
																	</cfif>
																<!--- NC Input has NOT been Assigned --->
                                                                <cfelse>
                                                                	<!--- Awaiting or Late ? --->
                                                                    Awaiting Assignment<br />
                                                                	<!--- Access to Assign NCs: TAM, ROM --->
																	<cfif 
																		isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
																		OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																		OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																		OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">

                                                                    <Br /><b><font class="warning">Required Action</font></b><br />
                                                                     :: <a href="TechnicalAudits_AssignNonConformanceInput_Search.cfm?#CGI.QUERY_STRING#">
                                                                    		Assign Non-Conformance Input
                                                                        </a><br />
                                                                    </cfif>
                                                                </cfif>
                                                            <!--- NCs do NOT exist after Appeals --->
                                                            <cfelse>
                                                            	<!--- Awaiting or Late ? --->
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
                                								<!--- Access to Upload Appeal Decision: TAM, ROM, SQM --->
																<cfif 
																	isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
																	OR isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
																	OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																	OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																	OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                                                                
                                                                	 :: <a href="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&Action=Appeal Decision Completed">
                                                                		Upload Audit Report

                                                                  		</a><br />
                                                            	</cfif>
                                                            <!--- Appeal Decision has NOT been Assigned --->
                                                            <cfelse>
                                                            	<!--- Awaiting or Late ? --->
                                                                Awaiting Appeal Decision Assignment<br />
                                                                <!--- Access to Assign Appeal Decision: TAM, ROM --->
																<cfif 
																	isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
																	OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																	OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																	OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">

																<Br /><b><font class="warning">Required Action</font></b><br />
                                                                 :: <a href="TechnicalAudits_AssignAppealDecision_Search.cfm?#CGI.QUERY_STRING#">
                                                                 	Assign Appeal Decision
                                                                    </a><Br />
                                                            	</cfif>
															</cfif>
                                                        </cfif>													
                                                    <!--- Appeal Response has NOT been completed --->
                                                    <cfelse>
                                                        <!--- Appeal Response Assignment Complete --->
                                                        <cfif AppealResponseAssign eq "Yes">
                                                            <b>Appeal Response Assignment Status</b>:
                                                            Assigned to #AppealResponseEmail# on #dateformat(AppealResponseAssignDate, "mm/dd/yyyy")# 
                                                            (Due #dateformat(AppealResponseDueDate, "mm/dd/yyyy")#)<br />
                                                            <!--- Access to Upload Appeal Response: TAM, AppealResponseEmail --->
															<cfif 
                                                                isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.AppealResponseEmail
                                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                                                            
                                                             	 :: <a href="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&Action=Appeal Response Completed">
                                                                	Upload Audit Report
                                                               		</a><br />
                                                            </cfif>
                                                        <!--- Appeal Response Assignment NOT Complete --->
                                                        <cfelse>
                                                        	<!--- Awaiting or Late ? --->
                                                            Awaiting Appeal Response Assignment<br />
                                                            <!--- Access to Assign Appeal Response: TAM, ROM, SQM --->
															<cfif 
                                                                isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
																OR isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
                                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                                                            
                                                            <Br /><b><font class="warning">Required Action</font></b><br />
                                                             :: <a href="TechnicalAudits_AssignAppealResponse_Search.cfm?#CGI.QUERY_STRING#">Assign Appeal Response</a><Br />
                                                        	</cfif>
														</cfif>
                                                    </cfif>
												<!--- There are NO appeals --->
												<cfelse>
													No Appeals<br />
													<b>Non-Conformance Status</b>: 
													<!--- NC Input has been Assigned --->
                                                    <cfif NCEnteredAssign eq "Yes">
                                                    	Assigned on #Dateformat(NCEnteredAssignDate, "mm/dd/yyyy")# to #NCEnteredAssignEmail#<br />
														<!--- NCs have been entered --->
                                                        <cfif NCEntered eq "Yes">
                                                            Entered on #dateformat(NCEnteredDate, "mm/dd/yyyy")# by #NCEnteredAssignEmail# [view]<br />
                                                        <!--- NCs have NOT been entered --->
                                                        <cfelse>
                                                        	<!--- Awaiting or Late ? --->
                                                            
                                                            <!--- Access to Enter NCs: NCEnteredAssignEmail, TAM, SQM, ROM --->
															<cfif 
                                                                isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.NCEnteredAssignEmail
                                                                OR isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
                                                                OR isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
                                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                                                             
                                                             :: <a href="TechnicalAudits_AddNC_SelectCategory.cfm?#CGI.QUERY_STRING#">
                                                             	Input NCs
                                                                </a><Br />
                                                            </cfif>
                                                        </cfif>
                                                    <!--- NC Input has NOT been Assigned --->
                                                    <cfelse>
                                                    	<!--- Awaiting or Late ? --->
                                                        Awaiting Assignment<br />
                                                        
														<!--- Access to Assign NCs: TAM, ROM --->
														<cfif 
                                                            isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
                                                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">

                                                        <Br /><b><font class="warning">Required Action</font></b><br />
                                                         :: <a href="TechnicalAudits_AssignNonConformanceInput_Search.cfm?#CGI.QUERY_STRING#">
                                                            Assign Non-Conformance Input
                                                            </a><br />
                                                        </cfif>
                                                    </cfif>                                                   
												</cfif>
                                            <!--- Engineering Manager Review NOT Complete --->
                                            <cfelse>
                                            	<!--- Awaiting or Late ? --->
                                                Assigned to Engineering Manager on #dateformat(EngManagerDate, "mm/dd/yyyy")# (Due #dateformat(EngManagerDueDate, "mm/dd/yyyy")#)<br />
                                                
                                                <!--- Access to Assign NCs: TAM, EngManager --->
												<cfif 
                                                    isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.EngManagerEmail
                                                    OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                    OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                    OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
												
                                                	 :: <a href="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&Action=Engineering Manager Review Completed">
                                                		Upload Audit Report
                                                  		</a><br />
                                            	</cfif>
											</cfif>
										<!--- NCs have NOT been Assigned to Engineering Manager --->
                                        <cfelse>
                                        	<!--- Awaiting or Late ? --->
                                            <Br /><b><font class="warning">Required Action</font></b><br />
                                            
                                            <!--- Access to Assign NCs to Eng Manager: TAM --->
											<cfif 
                                                SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                                            
                                            	 :: <a href="TechnicalAudits_Email_AssignNCs.cfm?#CGI.QUERY_STRING#">
                                            		Assign Non-Conformances to Engineering Manager
                                               		</a><br />
                                        	</cfif>
                                        </cfif>
                            <!--- NCs have NOT been reviewed --->
							<cfelse>
                            	<!--- Awaiting or Late ? --->
								<cfif NCReviewDueDate LT CurDate>
                                    <!--- NC Review Due Date has passed --->
                                    Non-Conformance Review Overdue
                                <cfelseif NCReviewDueDate EQ CurDate>
                                    <!--- NC Review Due Today --->
                                    Awaiting Non-Conformance Review
                                <cfelseif NCReviewDueDate GT CurDate>
                                    <!--- NC Review Scheduled --->
                                    Non-Conformance Review Scheduled (Due #dateformat(NCReviewDueDate, "mm/dd/yyyy")#)
                                </cfif><br />
                                
                                <!--- Access to Upload NC Review: TAM, ROM --->
								<cfif 
									isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
                                    OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                    OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                    OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                                    
                                	 :: <a href="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&Action=Non-Conformance Review Completed">
                                		Upload Audit Report
                                   		</a><br />
								</cfif>
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
                    	<!--- Awaiting or Late ? --->
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
                        
                        <!--- Access to Upload Audit Report: TAM, ROM, Auditor --->
						<cfif 
                            isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
							OR isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.AuditorEmail
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                        
                         	 :: <a href="TechnicalAudits_ReportUpload.cfm?#CGI.QUERY_STRING#&Action=Audit Completed - Audit Report Posted">
                         		Upload Audit Report
                            	</a><br />
                         </cfif>
					</cfif>
				<!--- Auditor has NOT been informed of audit --->
				<cfelse>
                	<b>Auditor Assignment</b>: Auditor Selected<br />
					<!--- Audit Due Date is Set, send Audit Assignment --->
					<cfif len(AuditDueDate)>
                        <b>Audit Due Date</b>: Selected - #dateformat(AuditDueDate, "mm/dd/yyyy")#<Br />
                        <b>Audit Assignment Letter</b>: Not Sent<br />
                        
						<!--- Access to Send Audit Assignment Letter: TAM --->
						<cfif 
                            SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                        
                             :: <A href="TechnicalAudits_Email_AuditorAssignment.cfm?#CGI.QUERY_STRING#">
                               Submit Audit Assignment to Auditor
                               </A> (Sends Auditor Assignment Letter)<br />
                    	</cfif>
                    <!--- Audit Due Date is NOT Set, Set Audit Due Date --->
					<cfelse>
                        <b>Audit Due Date</b>: Not Set<br />
                        
						<!--- Access to Set Audit Due Date: TAM --->
						<cfif 
                            SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                        
                        	 :: <A href="TechnicalAudits_AuditDueDate.cfm?#CGI.QUERY_STRING#">
                                Add Audit Due Date
                        		</A><br />
						</cfif>
                    </cfif>                	
                </cfif>
            <!--- Auditor has NOT been Assigned --->
			<cfelse>
				<!--- Request for Assign Auditor Letter has been sent --->
                <cfif len(AuditorAssignmentDueDate)>
                    <b>Auditor Assignment</b>: Request sent #dateformat(AuditorAssignmentRequestDate, "mm/dd/yyyy")#. (Due #dateformat(AuditorAssignmentDueDate, "mm/dd/yyyy")#)<Br />
                        <cfif AuditorRequested eq "Yes">
	                        <b>Auditor Requested</b>: See <u>Auditor</u> Section Below<br />
						<cfelse>
                            <!--- Access to Assign Auditor: TAM, ROM --->
							<cfif 
								isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                           
                           		 :: <a href="TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">
                            		Assign Auditor
                            		</a><br />
                            </cfif>
                        </cfif>
                <cfelse>
                    <b>Action Required</b><br />
					<cfif AuditType2 eq "In-Process">
	                    <!--- Access to Assign Auditor: TAM --->
						<cfif 
                            SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                        
                         :: <a href="TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">
                            Assign Auditor
                        	</a><br />
						</cfif>
					<cfelseif AuditType2 eq "Full">
	                    <!--- Access to Request Auditor Assignment: TAM --->
						<cfif 
                            SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                            
                         :: <a href="TechnicalAudits_Email_AssignAuditorRequest.cfm?ID=#URL.ID#&Year=#URL.Year#">
                            Send Auditor Assignment Request to Regional Operations Manager
                        	</a><Br />
                        </cfif>                        
						<!--- Access to Assign Auditor: TAM, ROM --->
						<cfif 
                            isDefined("Form.EmpNo") AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_ROM
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">
                        
                         :: <a href="TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">
                       		Assign Auditor
                        	</a><br />
                    	</cfif>
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
                AND len(RequestType)
                AND len(Program)
                AND len(ProjectHandler)
                AND len(ProjectFR) 
                AND len(ProjectPR)
				AND len(EngManager)
				AND len(EngManagerDirector)
				
				<!--- In-Process Audit --->
				OR AuditType2 eq "In-Process"
				AND len(AuditType2) 
				AND len(Industry)
				AND len(OfficeName)
				AND len(Month)
				AND len(ProjectNumber)
				AND len(RequestType)
				AND len(Program)
				AND len(ProjectHandler)
				AND len(ProjectPrimeReviewer)
				AND len(EngManager)
				AND len(EngManagerDirector)>
                    
                    <!--- Required action is to set audit details to complete --->
                    <b>Required Fields</b>: Completed<br />
                    <b>Status</b>: Audit Details Incomplete<br />
                    <b>Action Required</b><Br />
                    
                    <!--- Access set Audit Details to Complete: TAM --->
					<cfif 
                        SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">

                     :: <a href="TechnicalAudits_ApproveAudit.cfm?#CGI.QUERY_STRING#">
                     	Set Audit Details to Complete
                        </a><br />
                    </cfif>
            <cfelse>
            	<!--- Not all required information has been entered --->
                <b>Required Fields</b>: Incomplete<br />
                <b>Status</b>: Audit Details Incomplete<br />

				<!--- Access edit/add Audit Details: TAM --->
                <cfif 
                    SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                    OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                    OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.Username eq "Oates">

					<cfif Flag_CurrentStep eq "Audit Details (1) Entered">
                        <b>Action Required</b><Br />
                        &nbsp; &nbsp; &nbsp; :: <A href="TechnicalAudits_AddAudit2.cfm?#CGI.QUERY_STRING#">Add Audit Details 2</A>
                    <cfelseif Flag_CurrentStep eq "Audit Details (2) Entered">
                        <b>Action Required</b><Br />
                        &nbsp; &nbsp; &nbsp; :: <A href="TechnicalAudits_AddAudit3.cfm?#CGI.QUERY_STRING#">Add Audit Details 3</A>
                    <cfelseif Flag_CurrentStep eq "Audit Details (3) Entered">
                        <b>Action Required</b><br />
                        &nbsp; &nbsp; &nbsp; :: <A href="TechnicalAudits_AddAudit4_Search.cfm?#CGI.QUERY_STRING#">Add Audit Details 4</A>
                    </cfif>
            	</cfif><br />
            </Cfif>    
        </cfif>
    
	<!--- removing else case, full and in-process combined above --->
    <cfelse>
</cfif>

<br />
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
    <b>Quarter Scheduled</b> 
	<cfif NOT len(Approved) OR Approved NEQ "Yes">
        <cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
         
            [<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=Month&label=Month">Edit</A>]
        </cfif>
    </cfif><br />
    Quarter #Month#
<cfelseif AuditType2 eq "In-Process">
    <b>Month Scheduled</b> 
    <cfif NOT len(Approved) OR Approved NEQ "Yes">
		<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">

         [<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=Month&label=Month">Edit</A>]
         </cfif>
	</cfif><br />
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
        #dateformat(AuditDueDate, "mmmm dd, yyyy")# 
		<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
				OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
				OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
        
        	<A href="TechnicalAudits_AuditDueDate.cfm?#CGI.QUERY_STRING#">[Change Due Date]</A><br />
        </cfif>
        Audit Assignment Not Sent (Due Date can be changed)
    <cfelse>
        None Specified 
        
		<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
				OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
				OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">

			<cfif Approved eq "Yes" AND AuditorAssigned eq "Yes">
                <A href="TechnicalAudits_AuditDueDate.cfm?#CGI.QUERY_STRING#">[Add Due Date]</A>
            </cfif>
		</cfif>
    </cfif>
</Cfif><br /><br />

<b>Project Number</b>
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
        
		<cfif Approved eq "Yes" AND AuditorAssigned NEQ "Yes">
            [<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=ProjectNumber&label=Project Number">Add/Edit</A>]
        </cfif>
    </cfif><br>
<cfif len(ProjectNumber)>
	#ProjectNumber#<Br />
    <cfif len(ProjectLink)>
        [<a href="#projectLink#" target="_blank">Link to Project</a>] 
        
		<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
				OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
				OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">

	        [<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=ProjectLink&label=Project Link">Edit</A>]
		</cfif>
    <cfelse>
        Link to Project Not Entered 
        
		<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
				OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
				OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">

	        - [<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=ProjectLink&label=Project Link">Add</A>]
		</cfif>
    </cfif>
<cfelse>
	<font class="warning">None Listed</font>
</cfif>
<br /><br />

<b>File Number</b>
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">

    	<cfif Approved NEQ "Yes">
			[<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=FileNumber&label=File Number">Add/Edit</A>]
		</cfif>
	</cfif><br />
<cfif len(FileNumber)>
	#FileNumber#
<cfelse>
	None Listed
</cfif>
<br><br>

<b>Project Request Type</b>
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">

    	<cfif Approved NEQ "Yes">
        	[<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=RequestType&label=Project Request Type">Add/Edit</A>]
		</cfif>
	</cfif><br />
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
		<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
            OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">

	    	[<a href="TechnicalAudits_SelectAuditorManager.cfm?#CGI.QUERY_STRING#&AuditorEmail=#AuditorEmail#">Add Auditor's Manager</a>]
		</cfif>
	</Cfif>
<cfelse>
	Auditor Not Selected 
    
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">

		<cfif Approved eq "Yes" AND AuditorAssigned NEQ "Yes">
            <a href="TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">[Assign Auditor]</a>
        </cfif>
	</cfif>
</cfif><br><br>

<b>Engineering Manager / Director</b>
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
        
    	<cfif Approved NEQ "Yes">
        	[<A href="TechnicalAudits_AddAudit4_Search.cfm?#CGI.QUERY_STRING#">Add/Edit</A>]
        </cfif>
	</cfif><br />
<u>Engineering Manager</u>: 
<Cfif len(EngManager)>
    #EngManager#
<cfelse>
    None Listed
</Cfif><Br />

<u>Engineering Manager's Director</u>: 
<Cfif len(EngManagerDirector)>
    #EngManagerDirector#
<cfelse>
    None Listed<br /><br />
    
    Note: Engineering Manager must be reselected if the Engineering Director has not yet been entered
</Cfif><br /><br />

<b>CCN</b>
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
        
    	<cfif Approved NEQ "Yes">
        	[<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=CCN&label=Primary CCN">Add/Edit</A>]
        </cfif>
	</cfif><br />
<cfif len(CCN)>
	#CCN# (Primary)
<cfelse>
	<font class="warning">None Listed</font>
</cfif><br /><br />

<cfif len(CCN2)>
	<u>Other CCNs</u>
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
        
    	<cfif Approved NEQ "Yes">
			 [<a href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=CCN2&label=Other CCNs">Add/Edit</a>]
        </cfif>
    </cfif><br />
	#replace(CCN2, ",", "<br />", "All")#<br /><br />
</cfif>

<b>Standard</b>
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
        
    	<cfif Approved NEQ "Yes">
        	[<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=Standard&label=Primary Standard">Add/Edit</A>]
        </cfif>
    </cfif><br />
<cfif len(Standard)>
	#Standard# (Primary)
<cfelse>
	None Listed
</cfif><br /><br />

<cfif len(Standard2)>
	<u>Other Standards</u>
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
        
    	<cfif Approved NEQ "Yes">
        	[<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=Standard2&label=Other Standards">Add/Edit</A>]
        </cfif><br />
    </cfif>
	#replace(Standard2, ",", "<br />", "All")#<br /><br />
</cfif>

<b>Program</b>
	<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
        OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
        
    	<cfif Approved NEQ "Yes">
        	[<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=Program&label=Program">Add/Edit</A>]
        </cfif>
	</cfif><br>
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

<b>Notes</b> 
<cfif SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "SU" 
	OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit" 
	OR SESSION.Auth.isLoggedIn eq "Yes" AND SESSION.Auth.username eq "Oates">
    
    [<A href="TechnicalAudits_AuditDetails_Edit.cfm?#CGI.QUERY_STRING#&var=Notes&label=Notes">Edit</A>]
</cfif><br>
#Notes#
</cfoutput>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->