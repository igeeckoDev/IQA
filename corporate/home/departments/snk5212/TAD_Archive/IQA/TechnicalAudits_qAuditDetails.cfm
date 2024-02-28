<cflock scope="session" timeout="5">

<cfif isDefined("SESSION.Auth")>
	<cfset SessionActive = "Yes">
<cfelse>
	<cfset SessionActive = "No">
</cfif>

<cfif isDefined("Form.EmpNo")>
	<cfset FormEmpNoCheck = "Yes">
<cfelse>
	<cfset FormEmpNoCheck = "No">
</cfif>

<CFQUERY BLOCKFACTOR="100" NAME="Audit" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_AuditSchedule
WHERE ID = #URL.ID# AND Year_ = #URL.Year#
</cfquery>

<CFQUERY BLOCKFACTOR="100" NAME="InstructionLink" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT * FROM TechnicalAudits_Links
WHERE Label = 'Instructions'
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

    <cfquery Datasource="UL06046" name="checkRole" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT
        UL06046.TechnicalAudits_AuditSchedule.AuditorEmail, UL06046.TechnicalAudits_AuditSchedule.AuditorManagerEmail, UL06046.TechnicalAudits_AuditSchedule.EngManagerEmail, UL06046.TechnicalAudits_AuditSchedule.EngManagerDirectorEmail, Corporate.IQAtblOffices.TechnicalAudits_SQM, UL06046.TechnicalAudits_Industry.Contact, UL06046.TechnicalAudits_AuditSchedule.AppealResponseEmail, UL06046.TechnicalAudits_AuditSchedule.AppealDecisionEmail, UL06046.TechnicalAudits_AuditSchedule.NCEnteredAssignEmail, UL06046.TechnicalAudits_AuditSchedule.ROM, UL06046.TechnicalAudits_AuditSchedule.TAM
    FROM
        UL06046.TechnicalAudits_AuditSchedule, Corporate.IQAtblOffices, Corporate.IQARegion, UL06046.TechnicalAudits_Industry
    WHERE
        UL06046.TechnicalAudits_AuditSchedule.ID = #URL.ID#
        AND UL06046.TechnicalAudits_AuditSchedule.Year_ = #URL.Year#
        AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = Corporate.IQAtblOffices.OfficeName
        AND UL06046.TechnicalAudits_AuditSchedule.Region = Corporate.IQARegion.Region
        AND UL06046.TechnicalAudits_AuditSchedule.Industry = UL06046.TechnicalAudits_Industry.Industry
    </CFQUERY>

    <cfif NOT isDefined('SESSION.Auth')>
		<Cfif checkRole.TAM eq qEmpLookup.Employee_email>
            <cflock scope="SESSION" timeout="60">
                <cfset SESSION.Auth = StructNew()>
                <cfset SESSION.Auth.IsLoggedIn = "Yes">
                <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                <cfset SESSION.Auth.IsSuperUser = "No">
                <cfset SESSION.Auth.Username = "Deputy Technical Audit Manager">
                <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                <cfset SessionExists = "Yes">
            </cflock>
        <cfelse>
        	<cfset SessionExists = "No">
        </Cfif>

		<Cfif SessionExists neq "Yes" AND checkRole.ROM eq qEmpLookup.Employee_email>
            <cflock scope="SESSION" timeout="60">
                <cfset SESSION.Auth = StructNew()>
                <cfset SESSION.Auth.IsLoggedIn = "Yes">
                <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                <cfset SESSION.Auth.IsSuperUser = "No">
                <cfset SESSION.Auth.Username = "ROM">
                <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                <cfset SessionExists = "Yes">
            </cflock>
		<cfelse>
        	<cfset SessionExists = "No">
        </Cfif>

		<Cfif SessionExists neq "Yes" AND checkRole.TechnicalAudits_SQM eq qEmpLookup.Employee_email>
            <cflock scope="SESSION" timeout="60">
                <cfset SESSION.Auth = StructNew()>
                <cfset SESSION.Auth.IsLoggedIn = "Yes">
                <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                <cfset SESSION.Auth.IsSuperUser = "No">
                <cfset SESSION.Auth.Username = "SQM">
                <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                <cfset SessionExists = "Yes">
            </cflock>
		<cfelse>
        	<cfset SessionExists = "No">
        </Cfif>

        <cfif Audit.Flag_CurrentStep eq "Audit Assignment Sent to Auditor">
			<Cfif SessionExists neq "Yes" AND checkRole.AuditorEmail eq qEmpLookup.Employee_email>
                <cflock scope="SESSION" timeout="60">
                    <cfset SESSION.Auth = StructNew()>
                    <cfset SESSION.Auth.IsLoggedIn = "Yes">
                    <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                    <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                    <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                    <cfset SESSION.Auth.IsSuperUser = "No">
                    <cfset SESSION.Auth.Username = "Auditor">
                    <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                    <cfset SessionExists = "Yes">
                </cflock>
            <cfelse>
                <cfset SessionExists = "No">
            </Cfif>
		</cfif>

        <cfif Audit.Flag_CurrentStep eq "Audit Assignment Sent to Auditor">
			<Cfif SessionExists neq "Yes" AND checkRole.AuditorManagerEmail eq qEmpLookup.Employee_email>
                <cflock scope="SESSION" timeout="60">
                    <cfset SESSION.Auth = StructNew()>
                    <cfset SESSION.Auth.IsLoggedIn = "Yes">
                    <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                    <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                    <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                    <cfset SESSION.Auth.IsSuperUser = "No">
                    <cfset SESSION.Auth.Username = "Manager of Auditor">
                    <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                    <cfset SessioExistsn = "Yes">
                </cflock>
            <cfelse>
                <cfset SessionExists = "No">
            </Cfif>
		</cfif>

        <cfif Audit.Flag_CurrentStep eq "Non-Conformance Review Completed">
			<Cfif SessionExists neq "Yes" AND checkRole.EngManagerEmail eq qEmpLookup.Employee_email>
                <cflock scope="SESSION" timeout="60">
                    <cfset SESSION.Auth = StructNew()>
                    <cfset SESSION.Auth.IsLoggedIn = "Yes">
                    <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                    <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                    <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                    <cfset SESSION.Auth.IsSuperUser = "No">
                    <cfset SESSION.Auth.Username = "Engineering Manager">
                    <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                    <cfset SessionExists = "Yes">
                </cflock>
            <cfelse>
                <cfset SessionExists = "No">
            </Cfif>
        </cfif>

        <cfif Audit.Flag_CurrentStep eq "Non-Conformance Review Completed">
			<Cfif SessionExists neq "Yes" AND checkRole.EngManagerDirectorEmail eq qEmpLookup.Employee_email>
                <cflock scope="SESSION" timeout="60">
                    <cfset SESSION.Auth = StructNew()>
                    <cfset SESSION.Auth.IsLoggedIn = "Yes">
                    <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                    <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                    <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                    <cfset SESSION.Auth.IsSuperUser = "No">
                    <cfset SESSION.Auth.Username = "Director of Engineering Manager">
                    <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                    <cfset SessionExists = "Yes">
                </cflock>
            <cfelse>
                <cfset SessionExists = "No">
            </Cfif>
		</cfif>

        <cfif Audit.Flag_CurrentStep eq "Engineering Manager Review Completed">
			<Cfif SessionExists neq "Yes" AND checkRole.AppealResponseEmail eq qEmpLookup.Employee_email>
                <cflock scope="SESSION" timeout="60">
                    <cfset SESSION.Auth = StructNew()>
                    <cfset SESSION.Auth.IsLoggedIn = "Yes">
                    <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                    <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                    <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                    <cfset SESSION.Auth.IsSuperUser = "No">
                    <cfset SESSION.Auth.Username = "Assigned the Appeal Response">
                    <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                    <cfset SessionExists = "Yes">
                </cflock>
            <cfelse>
                <cfset SessionExists = "No">
            </Cfif>
		</cfif>

        <cfif Audit.Flag_CurrentStep eq "Appeal Response Completed">
			<Cfif SessionExists neq "Yes" AND checkRole.AppealDecisionEmail eq qEmpLookup.Employee_email>
                <cflock scope="SESSION" timeout="60">
                    <cfset SESSION.Auth = StructNew()>
                    <cfset SESSION.Auth.IsLoggedIn = "Yes">
                    <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                    <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                    <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                    <cfset SESSION.Auth.IsSuperUser = "No">
                    <cfset SESSION.Auth.Username = "Assigned the Appeal Decision">
                    <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                    <cfset SessionExists = "Yes">
                </cflock>
            <cfelse>
                <cfset SessionExists = "No">
            </Cfif>
		</cfif>

        <cfif Audit.Flag_CurrentStep eq "Appeal Decision Completed" OR Audit.Flag_CurrentStep eq "Engineering Manager Review Completed" AND Audit.AppealExist eq "No">
			<Cfif SessionExists neq "Yes" AND checkRole.NCEnteredAssignEmail eq qEmpLookup.Employee_email>
                <cflock scope="SESSION" timeout="60">
                    <cfset SESSION.Auth = StructNew()>
                    <cfset SESSION.Auth.IsLoggedIn = "Yes">
                    <cfset SESSION.Auth.IsLoggedInApp = "IQA">
                    <cfset SESSION.Auth.Name = qEmpLookup.Employee_email>
                    <cfset SESSION.Auth.Email = SESSION.Auth.Name>
                    <cfset SESSION.Auth.IsSuperUser = "No">
                    <cfset SESSION.Auth.Username = "Assigned Non-Conformance Input">
                    <cfset SESSION.Auth.AccessLevel = "TAD Temporary">
                    <cfset SessionExists = "Yes">
                </cflock>
            <cfelse>
                <cfset SessionExists = "No">
            </Cfif>
		</cfif>
	</cfif>
</cfif>

<cfoutput query="Audit">
<cfif Status neq "Removed">

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
					AND Flag_CurrentStep = 'Audit Executed - Audit Report Posted'
					ORDER BY ID DESC
					</cfquery>

					Report Posted on #dateformat(getFile.DatePosted, "mm/dd/yyyy")#

					<cfif Flag_CurrentStep eq "Audit Executed - Audit Report Posted">
						[<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>]
							<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
								OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
								OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
								OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
								OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
								 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
							</cfif>
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
							ORDER BY ID DESC
							</cfquery>

							Non-Conformances Reviewed on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# <!--- Alternate: NCReviewDate --->

							<cfif Flag_CurrentStep eq "Non-Conformance Review Completed">
								<!--- view report file --->
								[<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>]
								<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
									OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
									OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
									OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
									OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
									 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
								</cfif>
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
											ORDER BY ID DESC
											</cfquery>

											Completed on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# <!--- Alternate: EngManagerReviewDate --->

											<cfif Flag_CurrentStep eq "Engineering Manager Review Completed">
												<!--- view report file --->
												[<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>]
												<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
													OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
													OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
													OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
													OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
													 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
												</cfif>
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
													ORDER BY ID DESC
													</cfquery>

													Completed on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# <!--- Alternate: AppealResponseDate --->

													<cfif Flag_CurrentStep eq "Appeal Response Completed">
														<!--- view report file --->
														[<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>]
														<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
															OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
															OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
															OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
															OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
															 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
														</cfif>
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
														ORDER BY ID DESC
														</cfquery>

														Completed on #dateformat(getFile.DatePosted, "mm/dd/yyyy")# <!--- Alternate: AppealDecisionDate --->

														<cfif Flag_CurrentStep eq "Appeal Decision Completed">
															<!--- view report file --->
															[<a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>]
															<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
																 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
															</cfif>
														</cfif><br />

														<!--- NCs - both cases - exist and do not exist - still have to enter NC's --->
														<cfif NCExistPostAppeal eq "Yes" OR NCExistPostAppeal eq "No">
															<!--- NC Input has been Assigned --->
															<cfif NCEnteredAssign eq "Yes">
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
																ORDER BY ID DESC
																</cfquery>

																Completed on #dateformat(NCEnteredDate, "mm/dd/yyyy")#<!--- by #NCEnteredEmail#---><br />

																<cfif Flag_CurrentStep eq "Non-Conformance Input Completed">
																<a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
																	 :: View Non-Conformances
																</a><br />

																	<!--- view report file --->
																	 :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
																	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																		OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																		OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
																		 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
																	</cfif>
																</cfif>
																	<!--- IN-PROCESS Audits - READY TO CLOSE --->
																	<!--- 1/9/2014
																	<cfif AuditType2 eq "In-Process">
																		<!--- Audit Ready to Close --->
																		<cfif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "No">
																			<cfif Flag_CurrentStep eq "Corrective Actions Verified">
                                                                            <!--- query to get details --->
                                                                                <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                                                SELECT ReportFileName, DatePosted
                                                                                FROM TechnicalAudits_ReportFiles
                                                                                WHERE AuditID = #URL.ID#
                                                                                AND AuditYear = #URL.Year#
                                                                                AND Flag_CurrentStep = 'Non-Conformance Input Completed'
                                                                                ORDER BY ID DESC
                                                                                </cfquery>

                                                                                <a href="TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
                                                                                    :: View Non-Conformances
                                                                                </a><br />

                                                                                <!--- view report file --->
                                                                                :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
                                                                                <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                                    OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																					OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                                                    OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																					OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
                                                                                     [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]<br />
                                                                                </cfif>
                                                                            </cfif>

                                                                        <br /><br />
																		<b>Audit Status</b>: <font class="warning"><b>Ready to Close</b></font><br />
																			<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																			OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																			OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																			OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																			OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

																			:: <a href="TechnicalAudits_CloseAudit.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Audit Completed and Closed">Close Audit</a><Br />

                                                                            <div align="Left" class="blog-time">
                                                                            <br />
                                                                            <b>Instructions</b><br />
                                                                            See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                            Section 9.15 Ready to Close<br /><br />
                                                                            </div>
																			</cfif>
																		<!--- Audit Closed --->
																		<cfelseif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "Yes">
																			<b>#Flag_CurrentStep#</b><br />

                                                                            <div align="Left" class="blog-time">
                                                                            <br />
                                                                            <b>Instructions</b><br />
                                                                            See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                            Section 9.16 Viewing Closed Audits<br /><br />
                                                                            </div>

																			 <!--- query to get details --->
																			<CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" maxrows="1" username="#OracleDB_Username#" password="#OracleDB_Password#">
																			SELECT ReportFileName, DatePosted
																			FROM TechnicalAudits_ReportFiles
																			WHERE AuditID = #URL.ID#
																			AND AuditYear = #URL.Year#
																			ORDER BY ID DESC
																			</cfquery>

																			<a href="TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
																				:: View Non-Conformances
																			</a><br />

																			<!--- view report file --->
																			:: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
																			<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																				OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																				OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																				OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																				OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
																				 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
																			</cfif>
																		</cfif>
                                                                        1/9/2014 --->
																	<!--- FULL Audits AND ALSO In-Process Audits (same workflow) --->
																	<cfif AuditType2 eq "Full" OR AuditType2 eq "In-Process">
																		<Cfif NCExistPostAppeal eq "No">
																			<!--- Audit Ready to be Closed --->
																			<cfif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "No">
																				<cfif Flag_CurrentStep eq "Corrective Actions Verified">
																				<!--- query to get details --->
                                                                                    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                                                    SELECT ReportFileName, DatePosted
                                                                                    FROM TechnicalAudits_ReportFiles
                                                                                    WHERE AuditID = #URL.ID#
                                                                                    AND AuditYear = #URL.Year#
                                                                                    AND Flag_CurrentStep = 'Non-Conformance Input Completed'
                                                                                    ORDER BY ID DESC
                                                                                    </cfquery>

                                                                                    <a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
                                                                                        :: View Non-Conformances
                                                                                    </a><br />

                                                                                    <!--- view report file --->
                                                                                    :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
                                                                                    <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                                                        OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																						OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
                                                                                         [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]<br />
                                                                                    </cfif>
                                                                                </cfif>

                                                                                <br /><br />
																				<b>Audit Status</b>: <font class="warning"><b>Ready to Close</b></font><br />

                                                                                <!--- access to Close Audit --->
																				<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																				OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																				OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																				OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																				OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

																					:: <a href="#IQADir#TechnicalAudits_CloseAudit.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Audit Completed and Closed - Corrective Actions Verified">Close Audit</a><Br />
																				<div align="Left" class="blog-time">
                                                                                <br />
                                                                                <b>Instructions</b><br />
                                                                                See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                                Section 9.15 Ready to Close<br /><br />
                                                                                </div>
																				</cfif>
																			<cfelseif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "Yes">
																				<b>#Flag_CurrentStep#</b><br />

                                                                                <div align="Left" class="blog-time">
                                                                                <br />
                                                                                <b>Instructions</b><br />
                                                                                See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                                Section 9.16 Viewing Closed Audits<br /><br />
                                                                                </div>

																				<!--- query to get details --->
																				<CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
																				SELECT ReportFileName, DatePosted
																				FROM TechnicalAudits_ReportFiles
																				WHERE AuditID = #URL.ID#
																				AND AuditYear = #URL.Year#
																				AND Flag_CurrentStep = 'Non-Conformance Input Completed'
																				ORDER BY ID DESC
																				</cfquery>

																				<a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
																					:: View Non-Conformances
																				</a><br />

																				<!--- view report file --->
																				:: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
																					<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																						OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																						OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
																						 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
																					</cfif>
																			</cfif>
																		<cfelseif NCExistPostAppeal eq "Yes" or NOT len(NCExistPostAppeal)>
																			<!--- Query SRCAR Table --->
																			<CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
																			SELECT * FROM TechnicalAudits_SRCAR
																			WHERE AuditID = #URL.ID#
																			AND AuditYear = #URL.Year#
																			</CFQUERY>

																			<!--- SR/CARs have been Closed --->
																			<cfif SRCAR.SRCARClosed eq "Yes">
																			<b>Corrective Action Status</b>:
																				Corrective Actions Completed on #dateformat(SRCAR.SRCARClosedDate, "mm/dd/yyyy")#<br />

																				<!--- query to get details --->
																				<CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
																				SELECT ReportFileName, DatePosted, ID
																				FROM TechnicalAudits_ReportFiles
																				WHERE AuditID = #URL.ID#
																				AND AuditYear = #URL.Year#
																				AND Flag_CurrentStep = 'Corrective Actions Completed'
																				ORDER BY ID DESC
																				</cfquery>

																				<cfif Flag_CurrentStep eq "Corrective Actions Completed">
																				<a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
																					:: View Non-Conformances
																				</a><br />

																				<!--- view report file --->
																				:: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
																					<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																						OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																						OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
																						 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
																					</cfif><br /><br />
																				</cfif>

																				<!--- SR/CARs have been Verified --->
																				<cfif SRCAR.SRCARVerified eq "Yes">
																				<b>Verification Status</b>:
																					Verification Completed on #dateformat(SRCAR.SRCARVerifiedDate, "mm/dd/yyyy")#<br />

																					<!--- Audit Ready to be Closed --->
																					<cfif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "No">
																						<cfif Flag_CurrentStep eq "Corrective Actions Verified">
																						<!--- query to get details --->
                                                                                            <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                                                            SELECT ReportFileName, DatePosted
                                                                                            FROM TechnicalAudits_ReportFiles
                                                                                            WHERE AuditID = #URL.ID#
                                                                                            AND AuditYear = #URL.Year#
                                                                                            AND Flag_CurrentStep = 'Corrective Actions Verified'
                                                                                            ORDER BY ID DESC
                                                                                            </cfquery>

                                                                                            <a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
                                                                                                :: View Non-Conformances
                                                                                            </a><br />

                                                                                            <!--- view report file --->
                                                                                            :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
                                                                                            <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                                                OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																								OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                                                                OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																								OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
                                                                                                 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]<br />
                                                                                            </cfif>
                                                                                        </cfif>

                                                                                    	<br /><br />
																						<b>Audit Status</b>: <font class="warning"><b>Ready to Close</b></font><br />

                                                                                        <!--- access to Close Audit --->
																						<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																						OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																						OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

																							:: <a href="#IQADir#TechnicalAudits_CloseAudit.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Audit Completed and Closed - Corrective Actions Verified">Close Audit</a><Br />

																						<div align="Left" class="blog-time">
                                                                                        <br />
                                                                                        <b>Instructions</b><br />
                                                                                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                                        Section 9.15 Ready to Close<br /><br />
                                                                                        </div>
																						</cfif>
																					<cfelseif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "Yes">
																						<b>#Flag_CurrentStep#</b><br />

                                                                                        <div align="Left" class="blog-time">
                                                                                        <br />
                                                                                        <b>Instructions</b><br />
                                                                                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                                        Section 9.16 Viewing Closed Audits<br /><br />
                                                                                        </div>

																						<!--- query to get details --->
																						<CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
																						SELECT ReportFileName, DatePosted
																						FROM TechnicalAudits_ReportFiles
																						WHERE AuditID = #URL.ID#
																						AND AuditYear = #URL.Year#
																						AND Flag_CurrentStep = 'Corrective Actions Verified'
																						ORDER BY ID DESC
																						</cfquery>

																						<a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
																							:: View Non-Conformances
																						</a><br />

																						<!--- view report file --->
																						:: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
																						<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																							OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																							OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																							OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates"
																							OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM>
																							 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
																						</cfif>
																					</cfif>
																					<!--- /// --->
																				<!--- SR/CARs have NOT been Verified --->
																				<cfelse>
																					<!--- Awaiting or Late ? --->
																					<b>Status</b>:
																					Awaiting Corrective Actions Verification Information<br />
																					Due Date: #dateformat(SRCARVerifiedDueDate, "mm/dd/yyyy")#<br />

																					<!--- Access to Add CA Verification Information: TAM, SQM, ROM --->
																					<cfif
																					FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
																					OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
																					OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																					OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																					OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																					OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																					OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">
																						:: <a href="#IQADir#TechnicalAudits_ReportUpload.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Corrective Actions Verified">
																							Add Corrective Actions Verification Information
																						</a><br />

                                                                                    <div align="Left" class="blog-time">
                                                                                    <br />
                                                                                    <b>Instructions</b><br />
                                                                                    See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                                    Section 9.14 Add Corrective Action Verification Information<br /><br />
                                                                                    </div>
																					</cfif>
																				</cfif>
																			<!--- SR/CARs have NOT been Closed --->
																			<cfelse>
																				<!--- Awaiting or Late ? --->
																				<br /><br />
                                                                                <b>Status</b>:
																				Awaiting Corrective Actions Closure Information<br />
																				Due Date: #dateformat(SRCARClosedDueDate, "mm/dd/yyyy")#<br />
																				<!--- Access to Add CA Closure Information: TAM, SQM, ROM --->
																				<cfif
																					FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
																					OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
																					OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																					OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																					OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																					OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																					OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">
																				:: <a href="#IQADir#TechnicalAudits_ReportUpload.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Corrective Actions Completed">
																					Add Corrective Actions Closure Information
																				</a><br />

                                                                                    <div align="Left" class="blog-time">
                                                                                    <br />
                                                                                    <b>Instructions</b><br />
                                                                                    See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                                    Section 9.13 Add Corrective Action Closure Information<br /><br />
                                                                                    </div>
																				</cfif>
																			</cfif>
																		</Cfif>
																	</cfif>
																<!--- NC Input has NOT been Completed --->
																<cfelse>
																	<b>Non-Conformance Input Assignment</b>:
																	Assigned on #Dateformat(NCEnteredAssignDate, "mm/dd/yyyy")# to #NCEnteredAssignEmail#<br />
																	<!--- Access to Enter NCs: NCEnteredAssignEmail, TAM, SQM, ROM --->
																	<cfif
																		FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.NCEnteredAssignEmail
																		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
																		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
																		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																		OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																		OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																		OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

																	 :: <a href="#IQADIR#TechnicalAudits_AddNC_SelectCategory.cfm?Year=#URL.Year#&ID=#URL.ID#">
																		Input Non-Conformances
																		</a><Br />

                                                                        <div align="Left" class="blog-time">
                                                                        <br />
                                                                        <b>Instructions</b><br />
                                                                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                        Section 9.12 Input Non-Conformances<br /><br />
                                                                        </div>
																	</cfif>
																</cfif>
															<!--- NC Input has NOT been Assigned --->
															<cfelse>
																<!--- Awaiting or Late ? --->
																Awaiting Assignment<br />
																<!--- Access to Assign NCs: TAM, ROM --->
																<cfif
																	FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
																	OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																	OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																	OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																	OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																	OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

																<Br /><b><font class="warning">Required Action</font></b><br />
																 :: <a href="#IQADIR#TechnicalAudits_AssignNonConformanceInput_Search.cfm?Year=#URL.Year#&ID=#URL.ID#">
																		Assign Non-Conformance Input
																	</a><br />
																</cfif>
															</cfif>
														</cfif>
													<!--- Appeal Decision has NOT been completed --->
													<cfelse>
														<!--- Appeal Decision has been Assigned --->
														<cfif AppealDecisionAssign eq "Yes">
															<b>Appeal Decision Assignment Status</b>:
															Assigned to #AppealDecisionEmail# on #dateformat(AppealDecisionAssignDate, "mm/dd/yyyy")#
															(Due #dateformat(AppealDecisionDueDate, "mm/dd/yyyy")#)<br />
															<!--- Access to Upload Appeal Decision: TAM, ROM, SQM --->
															<cfif
																FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
																OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
																OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

																 :: <a href="#IQADIR#TechnicalAudits_ReportUpload.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Appeal Decision Completed">
																		Upload Audit Report
																	</a><br />

                                                                <div align="Left" class="blog-time">
                                                                <br />
                                                                <b>Instructions</b><br />
                                                                See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                Section 9.11 Appeal Decision<br /><br />
                                                                </div>
															</cfif>
														<!--- Appeal Decision has NOT been Assigned --->
														<cfelse>
															<!--- Awaiting or Late ? --->
															Awaiting Appeal Decision Assignment<br />
															<!--- Access to Assign Appeal Decision: TAM, ROM --->
															<cfif
																FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
																OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

															<Br /><b><font class="warning">Required Action</font></b><br />
															 :: <a href="#IQADIR#TechnicalAudits_AssignAppealDecision_Search.cfm?Year=#URL.Year#&ID=#URL.ID#">
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
														<!--- Access to Upload Appeal Response: TAM, SQM, ROM, AppealResponseEmail --->
														<cfif
															FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
															OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
															OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
															OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.AppealResponseEmail
															OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
															OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
															OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
															OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

															 :: <a href="#IQADIR#TechnicalAudits_ReportUpload.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Appeal Response Completed">
																Upload Audit Report
																</a><br />

                                                            <div align="Left" class="blog-time">
                                                            <br />
                                                            <b>Instructions</b><br />
                                                            See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                            Section 9.10 Respond to Appeals<br /><br />
                                                            </div>
														</cfif>
													<!--- Appeal Response Assignment NOT Complete --->
													<cfelse>
														<!--- Awaiting or Late ? --->
														Awaiting Appeal Response Assignment<br />
														<!--- Access to Assign Appeal Response: TAM, ROM, SQM --->
														<cfif
															FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
															OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
															OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
															OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
															OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
															OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
															OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

														<Br /><b><font class="warning">Required Action</font></b><br />
														 :: <a href="#IQADir#TechnicalAudits_AssignAppealResponse_Search.cfm?Year=#URL.Year#&ID=#URL.ID#">Assign Appeal Response</a><Br />

                                                        <div align="Left" class="blog-time">
                                                        <br />
                                                        <b>Instructions</b><br />
                                                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                        Section 9.9 Assign Appeal Response<br /><br />
                                                        </div>

														</cfif>
													</cfif>
												</cfif>
											<!--- There are NO appeals --->
											<cfelse>
												No Appeals<br />
												<!--- NC Input has been Assigned --->
                                                <cfif NCEnteredAssign eq "Yes">
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
                                                    ORDER BY ID DESC
                                                    </cfquery>

                                                    Completed on #dateformat(NCEnteredDate, "mm/dd/yyyy")#<!--- by #NCEnteredEmail#---><br />

                                                    <cfif Flag_CurrentStep eq "Non-Conformance Input Completed">
                                                    <a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
                                                         :: View Non-Conformances
                                                    </a><br />

                                                        <!--- view report file --->
                                                         :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
                                                        <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
															OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
															OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
															OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
															OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
                                                             [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]<br /><br />
                                                        </cfif>
                                                    </cfif>
                                                        <!--- IN-PROCESS Audits - READY TO CLOSE --->
                                                        <!--- 1/9/2014
														<cfif AuditType2 eq "In-Process">
                                                            <!--- Audit Ready to Close --->
                                                            <cfif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "No">
                                                            <br /><br />
                                                            <b>Audit Status</b>: <font class="warning"><b>Ready to Close</b></font><br />
                                                                <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                                OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                                                                OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

                                                                :: <a href="TechnicalAudits_CloseAudit.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Audit Completed and Closed">Close Audit</a><Br />

                                                                <div align="Left" class="blog-time">
                                                                <br />
                                                                <b>Instructions</b><br />
                                                                See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                Section 9.15 Ready to Close<br /><br />
                                                                </div>
                                                                </cfif>
                                                            <!--- Audit Closed --->
                                                            <cfelseif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "Yes">
                                                                <b>#Flag_CurrentStep#</b><br />

                                                                <div align="Left" class="blog-time">
                                                                <br />
                                                                <b>Instructions</b><br />
                                                                See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                Section 9.16 Viewing Closed Audits<br /><br />
                                                                </div>

                                                                 <!--- query to get details --->
                                                                <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" maxrows="1" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                                SELECT ReportFileName, DatePosted
                                                                FROM TechnicalAudits_ReportFiles
                                                                WHERE AuditID = #URL.ID#
                                                                AND AuditYear = #URL.Year#
                                                                ORDER BY ID DESC
                                                                </cfquery>

                                                                <a href="TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
                                                                    :: View Non-Conformances
                                                                </a><br />

                                                                <!--- view report file --->
                                                                :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
                                                                <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																	OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																	OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																	OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																	OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
                                                                     [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
                                                                </cfif>
                                                            </cfif>
                                                        1/9/2014 --->
														<!--- FULL Audits AND ALSO In-Process Audits (same workflow) --->
                                                        <cfif AuditType2 eq "Full" OR AuditType2 eq "In-Process">
                                                            <Cfif NCExistPostAppeal eq "No" OR NCExistPostAppeal eq "Yes">
                                                                <!--- Query SRCAR Table --->
                                                                <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                                SELECT * FROM TechnicalAudits_SRCAR
                                                                WHERE AuditID = #URL.ID#
                                                                AND AuditYear = #URL.Year#
                                                                </CFQUERY>

                                                                <!--- SR/CARs have been Closed --->
                                                                <cfif SRCAR.SRCARClosed eq "Yes">
                                                                <b>Corrective Action Status</b>:
                                                                    Corrective Actions Completed on #dateformat(SRCAR.SRCARClosedDate, "mm/dd/yyyy")#<br />

                                                                    <!--- query to get details --->
                                                                    <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                                    SELECT ReportFileName, DatePosted
                                                                    FROM TechnicalAudits_ReportFiles
                                                                    WHERE AuditID = #URL.ID#
                                                                    AND AuditYear = #URL.Year#
                                                                    AND Flag_CurrentStep = 'Corrective Actions Completed'
                                                                    ORDER BY ID DESC
                                                                    </cfquery>

                                                                    <cfif Flag_CurrentStep eq "Corrective Actions Completed">
                                                                    <a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
                                                                        :: View Non-Conformances
                                                                    </a><br />

                                                                    <!--- view report file --->
                                                                    :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
                                                                        <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																			OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																			OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																			OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																			OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
                                                                             [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
                                                                        </cfif><br /><br />
                                                                    </cfif>

                                                                    <!--- SR/CARs have been Verified --->
                                                                    <cfif SRCAR.SRCARVerified eq "Yes">
                                                                    <b>Verification Status</b>:
                                                                        Verification Completed on #dateformat(SRCAR.SRCARVerifiedDate, "mm/dd/yyyy")#<br /><br />

                                                                        <!--- Audit Ready to be Closed --->
                                                                        <cfif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "No">
                                                                            <cfif Flag_CurrentStep eq "Corrective Actions Verified">
																			<!--- query to get details --->
                                                                                <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                                                SELECT ReportFileName, DatePosted
                                                                                FROM TechnicalAudits_ReportFiles
                                                                                WHERE AuditID = #URL.ID#
                                                                                AND AuditYear = #URL.Year#
                                                                                AND Flag_CurrentStep = 'Corrective Actions Verified'
                                                                                ORDER BY ID DESC
                                                                                </cfquery>

                                                                                <a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
                                                                                    :: View Non-Conformances
                                                                                </a><br />

                                                                                <!--- view report file --->
                                                                                :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
                                                                                <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                                    OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																					OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                                                    OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																					OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
                                                                                     [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
                                                                                </cfif>
                                                                            </cfif>

                                                                            <br /><br />
                                                                            <b>Audit Status</b>: <font class="warning"><b>Ready to Close</b></font><br />

                                                                            <!--- access to Close Audit --->
                                                                            <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                            OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                                                                            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																			OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                                            OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

                                                                                :: <a href="#IQADir#TechnicalAudits_CloseAudit.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Audit Completed and Closed - Corrective Actions Verified">Close Audit</a><Br />
                                                                            <div align="Left" class="blog-time">
                                                                            <br />
                                                                            <b>Instructions</b><br />
                                                                            See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                            Section 9.15 Ready to Close<br /><br />
                                                                            </div>
																			</cfif>
                                                                        <cfelseif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "Yes">
                                                                            <b>#Flag_CurrentStep#</b><br />

                                                                            <div align="Left" class="blog-time">
                                                                            <br />
                                                                            <b>Instructions</b><br />
                                                                            See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                            Section 9.16 Viewing Closed Audits<br /><br />
                                                                            </div>

                                                                            <!--- query to get details --->
                                                                            <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                                                                            SELECT ReportFileName, DatePosted
                                                                            FROM TechnicalAudits_ReportFiles
                                                                            WHERE AuditID = #URL.ID#
                                                                            AND AuditYear = #URL.Year#
                                                                            AND Flag_CurrentStep = 'Corrective Actions Verified'
                                                                            ORDER BY ID DESC
                                                                            </cfquery>

                                                                            <a href="#IQADIR#TechnicalAudits_Reporting_Output.cfm?Year=#URL.Year#&ID=#URL.ID#">
                                                                                :: View Non-Conformances
                                                                            </a><br />

                                                                            <!--- view report file --->
                                                                            :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
                                                                            <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
																				OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
																				OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
																				OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
																				OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
                                                                                 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
                                                                            </cfif>
                                                                        </cfif>
                                                                        <!--- /// --->
                                                                    <!--- SR/CARs have NOT been Verified --->
                                                                    <cfelse>
                                                                        <!--- Awaiting or Late ? --->
                                                                        <b>Audit Status</b>:
                                                                        Awaiting Corrective Actions Verification Information<br />
                                                                        Due Date: #dateformat(SRCARVerifiedDueDate, "mm/dd/yyyy")#<br />

                                                                        <!--- Access to Add CA Verification Information: TAM, SQM, ROM --->
                                                                        <cfif
                                                                        FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
                                                                        OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
																		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                                        OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                                                                        OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">
                                                                            :: <a href="#IQADir#TechnicalAudits_ReportUpload.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Corrective Actions Verified">
                                                                                Add Corrective Actions Verification Information
                                                                            </a><br />

                                                                        <div align="Left" class="blog-time">
                                                                        <br />
                                                                        <b>Instructions</b><br />
                                                                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                        Section 9.14 Add Corrective Action Verification Information<br /><br />
                                                                        </div>
                                                                        </cfif>
                                                                    </cfif>
                                                                <!--- SR/CARs have NOT been Closed --->
                                                                <cfelse>
                                                                    <!--- Awaiting or Late ? --->
                                                                    <br /><br />
                                                                    <b>Audit Status</b>:
                                                                    Awaiting Corrective Actions Closure Information<br />
                                                                    Due Date: #dateformat(SRCARClosedDueDate, "mm/dd/yyyy")#<br />
                                                                    <!--- Access to Add CA Closure Information: TAM, SQM, ROM --->
                                                                    <cfif
                                                                        FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
                                                                        OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
																		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                                        OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                                                                        OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">
                                                                    :: <a href="#IQADir#TechnicalAudits_ReportUpload.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Corrective Actions Completed">
                                                                        Add Corrective Actions Closure Information
                                                                    </a><br />

                                                                    <div align="Left" class="blog-time">
                                                                    <br />
                                                                    <b>Instructions</b><br />
                                                                    See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                                    Section 9.13 Add Corrective Action Closure Information<br /><br />
                                                                    </div>
                                                                    </cfif>
                                                                </cfif>
                                                            </Cfif>
                                                        </cfif>
                                                    <!--- NC Input has NOT been Completed --->
                                                    <cfelse>
                                                        <b>Non-Conformance Input Assignment</b>:
                                                        Assigned on #Dateformat(NCEnteredAssignDate, "mm/dd/yyyy")# to #NCEnteredAssignEmail#<br />
                                                        <!--- Access to Enter NCs: NCEnteredAssignEmail, TAM, SQM, ROM --->
                                                        <cfif
                                                            FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.NCEnteredAssignEmail
                                                            OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.TechnicalAudits_SQM
                                                            OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
															OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                            OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                                                            OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

                                                         :: <a href="#IQADIR#TechnicalAudits_AddNC_SelectCategory.cfm?Year=#URL.Year#&ID=#URL.ID#">
                                                            Input Non-Conformances
                                                            </a><Br />

                                                            <div align="Left" class="blog-time">
                                                            <br />
                                                            <b>Instructions</b><br />
                                                            See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                                            Section 9.12 Input Non-Conformances<br /><br />
                                                            </div>
                                                        </cfif>
                                                    </cfif>
                                                <!--- NC Input has NOT been Assigned --->
                                                <cfelse>
                                                    <!--- Awaiting or Late ? --->
                                                    Awaiting Assignment<br />
                                                    <!--- Access to Assign NCs: TAM, ROM --->
                                                    <cfif
                                                        FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
														OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                                        OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                                                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                                                        OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

                                                    <Br /><b><font class="warning">Required Action</font></b><br />
                                                     :: <a href="#IQADIR#TechnicalAudits_AssignNonConformanceInput_Search.cfm?Year=#URL.Year#&ID=#URL.ID#">
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
                                            FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.EngManagerEmail
                                            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                            OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                                            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
											OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                            OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

                                             :: <a href="#IQADIR#TechnicalAudits_ReportUpload.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Engineering Manager Review Completed">
                                                Upload Audit Report
                                                </a><br />

                                        <div align="Left" class="blog-time">
                                        <br />
                                        <b>Instructions</b><br />
                                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                        Section 9.8 Engineering Manager Response<br /><br />
                                        </div>
                                        </cfif>
                                    </cfif>
								<!--- NCs have NOT been Assigned to Engineering Manager --->
                                <cfelse>
                                    <!--- Awaiting or Late ? --->
                                    <Br /><b><font class="warning">Required Action</font></b><br />

                                    <!--- Access to Assign NCs to Eng Manager: TAM --->
                                    <cfif
                                        SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                                        OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
										OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                                        OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

                                         :: <a href="#IQADIR#TechnicalAudits_Email_AssignNCs.cfm?Year=#URL.Year#&ID=#URL.ID#">
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
								FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
								OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
								OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
								OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
								OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
								OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

								 :: <a href="#IQADIR#TechnicalAudits_ReportUpload.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Non-Conformance Review Completed">
									Complete The Non-Conformance Review
									</a><br />

                                    <div align="Left" class="blog-time">
                                    <br />
                                    <b>Instructions</b><br />
                                    See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                                    Section 9.7 Non-Conformance Review<br /><br />
                                    </div>
							</cfif>
						</cfif>
					<!--- No NCs identified --->
					<cfelseif NCExist eq "No">
						<u>Note</u>: No Non-Conformances were found<br />
						<!--- Is the audit closed? This should ALWAYS be Yes in this case --->
						<cfif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "No">
							<br /><br />
							<b>Audit Status</b>: <font class="warning"><b>Ready to Close</b></font><br />
							<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
								OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
								OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
								OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
								OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">
									:: <a href="#IQADir#TechnicalAudits_CloseAudit.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Audit Completed and Closed - No Non-Conformances Identified">Close Audit</a><Br />

                            <div align="Left" class="blog-time">
                            <br />
                            <b>Instructions</b><br />
                            See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                            Section 9.15 Ready to Close<br /><br />
                            </div>
							</cfif>
						<cfelseif AuditClosed eq "Yes" AND AuditClosedConfirm EQ "Yes">
							<b>#Flag_CurrentStep#</b><br />

                            <div align="Left" class="blog-time">
                            <br />
                            <b>Instructions</b><br />
                            See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                            Section 9.16 Viewing Closed Audits<br /><br />
                            </div>

							<!--- query to get details --->
                            <CFQUERY BLOCKFACTOR="100" NAME="getFile" Datasource="UL06046" maxrows="1" username="#OracleDB_Username#" password="#OracleDB_Password#">
                            SELECT ReportFileName, DatePosted
                            FROM TechnicalAudits_ReportFiles
                            WHERE AuditID = #URL.ID#
                            AND AuditYear = #URL.Year#
                            ORDER BY ID DESC
                            </cfquery>

							<!--- view report file --->
                            :: <a href="#IQADir#TechAuditReports/#URL.Year#-#URL.ID#/#getFile.ReportFileName#">View Report File</a>
                            <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
								OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
								OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
								OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
								OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
                                 [<a href="#IQADir#TechnicalAudits_Admin_ReviseAuditReport.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=#Flag_CurrentStep#">Upload Revised Audit Report</a>]
                            </cfif>
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
						FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq checkRole.AuditorEmail
						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
						OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
						OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

						 :: <a href="#IQADIR#TechnicalAudits_ReportUpload.cfm?Year=#URL.Year#&ID=#URL.ID#&Action=Audit Executed - Audit Report Posted">
							Upload Audit Report
							</a><br />

                         <cfif AuditType2 eq "Full">

                            <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                            SELECT * FROM TechnicalAudits_Links
                            WHERE Label = 'Full'
                            </cfquery>

                         :: <a href="#DocumentLinks.HTTPLINK#" target="_blank">
                         	Open #DocumentLinks.HTTPLINKNAME#
                            </a><br />
                         <cfelseif AuditType2 eq "In-Process">

                            <CFQUERY BLOCKFACTOR="100" NAME="DocumentLinks" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
                            SELECT * FROM TechnicalAudits_Links
                            WHERE Label = 'In-Process'
                            </cfquery>

                         :: <a href="#DocumentLinks.HTTPLINK#" target="_blank">
                         	Open #DocumentLinks.HTTPLINKNAME#
                            </a><br />
                         </cfif>

						<cfif
                            FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
                            OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                            OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                            OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

							<!--- reassign auditor link --->
                            <br />
                            :: <A href="#IQADIR#TechnicalAudits_Email_AuditorAssignment.cfm?Year=#URL.Year#&ID=#URL.ID#">
                               <font class="warning">Submit Audit Assignment to Different Auditor</font>
                               </A> (Sends Auditor Assignment Letter)<br /><br />

                               Note: Please ensure you have changed the following fields <u>on this page</u> before you resend the new Auditor Assignment Letter: Auditor, Project Number, File Number, and Audit Due Date.<br />
                        </cfif>

                        <div align="Left" class="blog-time">
                        <br />
                        <b>Instructions</b><br />
                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                        Section 9.6 Complete audit<br /><br />
                        </div>
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
						SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
						OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
						OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

						 :: <A href="#IQADIR#TechnicalAudits_Email_AuditorAssignment.cfm?Year=#URL.Year#&ID=#URL.ID#">
						   Submit Audit Assignment to Auditor
						   </A> (Sends Auditor Assignment Letter)<br /><br />

                        Note: Please ensure you have verified that the following fields are correct before you send the new Auditor Assignment Letter: Auditor, Project Number, File Number, and Audit Due Date.<br />

                        <div align="Left" class="blog-time">
                        <br />
                        <b>Instructions</b><br />
                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                        Section 9.5 Set audit due date and send assignment to the auditor<br /><br />
                        </div>
					</cfif>
				<!--- Audit Due Date is NOT Set, Set Audit Due Date --->
				<cfelse>
					<b>Audit Due Date</b>: Not Set<br />

					<!--- Access to Set Audit Due Date: TAM --->
					<cfif
						SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
						OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
						OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

						 :: <A href="#IQADIR#TechnicalAudits_AuditDueDate.cfm?Year=#URL.Year#&ID=#URL.ID#">
							Add Audit Due Date
							</A><br />

                            <div align="Left" class="blog-time">
                            <br />
                            <b>Instructions</b><br />
                            See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                            Section 9.5 Set audit due date and send assignment to the auditor<br /><br />
                            </div>
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
                        FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
                        OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
                        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
                        OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

                         :: <a href="#IQADir#TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">
                            Assign Auditor
                            </a><br />

                        <div align="Left" class="blog-time">
                        <br />
                        <b>Instructions</b><br />
                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                        Section 9.4 Assigning an auditor<br /><br />
                        </div>
                    </cfif>
                </cfif>
			<cfelse>
				<b>Action Required</b><br />
				<cfif AuditType2 eq "In-Process">
					<!--- Access to Assign Auditor: TAM --->
					<cfif
						SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
						OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
						OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

					 :: <a href="#IQADir#TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">
						Assign Auditor
						</a><br />

                        <div align="Left" class="blog-time">
                        <br />
                        <b>Instructions</b><br />
                        See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                        Section 9.4 Assigning an Auditor<br /><br />
                        </div>
					</cfif>
				<cfelseif AuditType2 eq "Full">
					<!---
					<!--- Access to Request Auditor Assignment: TAM --->
					<cfif
						SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
						OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
						OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

					 :: <a href="TechnicalAudits_Email_AssignAuditorRequest.cfm?ID=#URL.ID#&Year=#URL.Year#">
						Send Auditor Assignment Request to Regional Operations Manager
						</a><Br />
					</cfif>
					--->
					<!--- Access to Assign Auditor: TAM, ROM --->
					<cfif
						FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq ROM
						OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
						OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
						OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
						OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

					 :: <a href="#IQADir#TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">
						Assign Auditor
						</a><br />
					</cfif>

                    <div align="Left" class="blog-time">
                    <br />
                    <b>Instructions</b><br />
                    See <a href="#InstructionLink.HTTPLINK#">#InstructionLink.HTTPLINKNAME#</a><br />
                    Section 9.3 Send auditor assignment to the Regional Operations Manager<br /><br />
                    </div>
				</cfif>
			</cfif>
		</cfif>
	<!--- Audit Approved = No --->
	<cfelse>
		<!--- All appropriate information has been completed --->

		<!---
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
		--->

		<cfif len(AuditType2)
		AND len(Industry)
		AND len(OfficeName)
		AND len(Month)
		AND len(ProjectNumber)
		AND len(RequestType)
		AND len(Program)
		AND len(EngManager)
		AND len(EngManagerDirector)
		AND len(ProjectHandler)
		AND len(ProjectHandlerManager)>

			<!--- Required action is to set audit details to complete --->
			<b>Required Fields</b>: Completed<br />
			<b>Status</b>: Audit Details Incomplete<br />
			<b>Action Required</b><Br />

			<!--- Access set Audit Details to Complete: TAM --->
			<cfif
				SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
				OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
				OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
				OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
				OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

			 :: <a href="#IQAAdminDir#TechnicalAudits_ApproveAudit.cfm?Year=#URL.Year#&ID=#URL.ID#">
				Set Audit Details to Complete
				</a><br />
			</cfif>
		<cfelse>
			<!--- Not all required information has been entered --->
			<b>Required Fields</b>: Incomplete<br />
			<b>Status</b>: Audit Details Incomplete<br />

			<!--- Access edit/add Audit Details: TAM --->
			<cfif
				SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
				OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
				OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
				OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
				OR SessionActive eq "Yes" AND SESSION.Auth.Username eq "Oates">

				<cfif Flag_CurrentStep eq "Audit Details (1) Entered">
					<b>Action Required</b><Br />
					&nbsp; &nbsp; &nbsp; :: <A href="#IQAAdminDir#TechnicalAudits_AddAudit2.cfm?Year=#URL.Year#&ID=#URL.ID#">Add Audit Details 2</A>
				<cfelseif Flag_CurrentStep eq "Audit Details (2) Entered">
					<b>Action Required</b><Br />
					&nbsp; &nbsp; &nbsp; :: <A href="#IQAAdminDir#TechnicalAudits_AddAudit3.cfm?Year=#URL.Year#&ID=#URL.ID#">Add Audit Details 3</A>
				<cfelseif Flag_CurrentStep eq "Audit Details (3) Entered">
					<b>Action Required</b><br />
					&nbsp; &nbsp; &nbsp; :: <A href="#IQAAdminDir#TechnicalAudits_AddAudit4_Search.cfm?Year=#URL.Year#&ID=#URL.ID#">Add Audit Details 4</A>
				</cfif>
			</cfif><br />
		</Cfif>
	</cfif>
</cfif>

<cfelse>
	<font class="warning">This audit has been removed from the Audit Schedule</font>
</cfif>

<br /><br />
<u>Available Actions</u><br />
:: <a href="#IQADIR#TechnicalAudits_AuditDetails_viewHistory.cfm?Year=#URL.Year#&ID=#URL.ID#">View History</a><br />
<cfif NOT len(Status)>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
		OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

        :: <a href="#IQAAdminDir#TechnicalAudits_Remove.cfm?Year=#URL.Year#&ID=#URL.ID#">Remove Audit</a><br />
    </cfif>
</cfif>
<br />

<b>Technical Audit Identifier</b><br>
<cfif len(Auditor) AND len(AuditorManager)>
    <cfif AuditType2 eq "Full">
        <cfset AuditTypeID = "F">
    <cfelseif AuditType2 eq "In-Process">
        <cfset AuditTypeID = "P">
    </cfif>

    <cfif RequestType eq "Test">
    	<cfset RequestTypeID = "T">
    <cfelse>
    	<cfset RequestTypeID = "N">
    </cfif>

	<cfset AuditorLoc = #right(AuditorDept, 3)#>

    <cfset ReviewLoc = #right(ProjectHandlerDept, 3)#>

    #ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#
<cfelse>
	Not Available - Auditor must be assigned
</cfif><br><Br>

<b>Audit Number</b><br>
#URL.Year#-#URL.ID#-#AuditedBy#<br /><br>

<b>Industry</b><br>
#Industry#<br /><br />

<cfquery Datasource="UL06046" name="getROM" username="#OracleDB_Username#" password="#OracleDB_Password#">
SELECT
    Corporate.IQARegion.TechnicalAudits_ROM as ROM, Corporate.IQAtblOffices.TechnicalAudits_SQM as SQM
FROM
    Corporate.IQARegion, Corporate.IQASubRegion, Corporate.IQAtblOffices, UL06046.TechnicalAudits_AuditSchedule
WHERE
    Corporate.IQARegion.Region = Corporate.IQASubRegion.Region
    AND Corporate.IQASubRegion.SubRegion = Corporate.IQAtblOffices.SubRegion
    AND Corporate.IQAtblOffices.OfficeName = UL06046.TechnicalAudits_AuditSchedule.OfficeName
    AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = '#OfficeName#'
</CFQUERY>

<b>Office Name</b><br>
#Region# / #OfficeName#<br />
<cfif len(SNAP)>SNAP Site Status: [#SNAP#]</cfif><Br />
<U>Site Quality Manager</U> - #getROM.SQM#<br />
<U>Regional Operations Manager</U> - #getROM.ROM#<br /><br />

<b>Audit Type</b><br>
#AuditType2# Technical Audit<br />
<cfif AuditType2 eq "In-Process">
Phase: #AuditPhase#<Br />
</cfif><br />

<b>E2E Project</b>
	<cfif NOT len(Approved) OR Approved NEQ "Yes">
        <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
			OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
			OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
            OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

            [<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=E2E&label=E2E">Edit</A>]
        </cfif>
    </cfif><br />
<cfif NOT len(E2E)>Not Selected<cfelse>#E2E#</cfif><br /><br />

<cfif AuditType2 eq "Full">
    <b>Quarter Scheduled</b>
	<cfif NOT len(Approved) OR Approved NEQ "Yes">
        <cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
			OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
			OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
            OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

            [<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=Month&label=Quarter">Edit</A>]
        </cfif>
    </cfif><br />
    Quarter #Month#
<cfelseif AuditType2 eq "In-Process">
    <b>Month Scheduled</b>
    <cfif NOT len(Approved) OR Approved NEQ "Yes">
		<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
			OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
			OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
            OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

         [<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=Month&label=Month">Edit</A>]
         </cfif>
	</cfif><br />
    #MonthAsString(Month)#
</cfif><br /><br />

<b>Audit Due Date</b><br />
<cfif ReportPosted EQ "Yes">
	<cfif len(AuditDueDate)>
    	#dateformat(AuditDueDate, "mmmm dd, yyyy")#<br />
    	Audit Assignment Letter Sent on #dateformat(AuditorAssignmentLetterDate, "mm/dd/yyyy")#
    </cfif>
<cfelseif ReportPosted NEQ "Yes">
	<cfif len(AuditDueDate)>
        #dateformat(AuditDueDate, "mmmm dd, yyyy")#
		<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
				OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
				OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
				OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
				OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

        	<A href="#IQADIR#TechnicalAudits_AuditDueDate.cfm?Year=#URL.Year#&ID=#URL.ID#">[Change Due Date]</A><br />
        </cfif>
        Audit Assignment Not Sent (Due Date can be changed)
    <cfelse>
        None Specified

		<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
				OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
				OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
				OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
				OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

			<cfif ReportPosted NEQ "Yes">
                <A href="#IQADIR#TechnicalAudits_AuditDueDate.cfm?Year=#URL.Year#&ID=#URL.ID#">[Add Due Date]</A>
            </cfif>
		</cfif>
    </cfif>
</Cfif><br /><br />

<b>Project Number</b>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

		<cfif ReportPosted NEQ "Yes">
            [<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=ProjectNumber&label=Project Number">Add/Edit</A>]
        </cfif>
    </cfif><br>
<cfif len(ProjectNumber)>
	#ProjectNumber#<Br />
    <cfif len(ProjectLink)>
        <cfif left(ProjectLink, 4) eq "http" OR left(ProjectLink, 5) eq "notes">
	        [<a href="#projectLink#" target="_blank">Link to Project</a>]
		<cfelse>
        	[<a href="http://#projectLink#" target="_blank">Link to Project</a>]
        </cfif>

		<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
				OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
				OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
				OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
				OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

	        [<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=ProjectLink&label=Project Link">Edit</A>]
		</cfif>
    <cfelse>
        Link to Project Not Entered

		<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
				OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
				OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
				OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
				OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

	        - [<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=ProjectLink&label=Project Link">Add</A>]
		</cfif>
    </cfif>
<cfelse>
	<font class="warning">None Listed</font>
</cfif>
<br /><br />

<b>File Number</b>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
			OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
			OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
            OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

    	<cfif ReportPosted NEQ "Yes">
			[<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=FileNumber&label=File Number">Add/Edit</A>]
		</cfif>
	</cfif><br />
<cfif len(FileNumber)>
	#FileNumber#
<cfelse>
	None Listed
</cfif>
<br><br>

<b>Project Request Type</b>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
			OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
			OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
            OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

    	<cfif Approved NEQ "Yes">
        	[<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=RequestType&label=Project Request Type">Add/Edit</A>]
		</cfif>
	</cfif><br />
<cfif len(RequestType)>
	#RequestType#
<cfelse>
	<font class="warning">None Listed</font>
</cfif>
<br><br>

<b>Auditor</b><br />
<cfif len(Auditor)>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
        OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
        OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">
        #Auditor# <cfif ReportPosted NEQ "Yes">[<a href="#IQADir#TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">Reassign Auditor</a>]</cfif><Br>
    <cfelse>
    	#Auditor#<br />
    </cfif>

    <u>Auditor's Manager</u>:
	<Cfif len(AuditorManager)>
    	#AuditorManager#
    <cfelse>
		<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
			OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
            OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
			OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
            OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

	    	[<a href="#IQADIR#TechnicalAudits_SelectAuditorManager.cfm?Year=#URL.Year#&ID=#URL.ID#&AuditorEmail=#AuditorEmail#">Add Auditor's Manager</a>]
		</cfif>
	</Cfif>
<cfelse>
	Auditor Not Selected

	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

		<cfif Approved eq "Yes" AND AuditorAssigned NEQ "Yes">
            [<a href="#IQADir#TechnicalAudits_AssignAuditor.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#AuditedBy#">Assign Auditor</a>]
        </cfif>
	</cfif>
</cfif><br><br>

<b>Engineering Manager / Director</b>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

		<cfif EngManagerAssign NEQ "Yes">
	      	[<A href="#IQADir#admin/TechnicalAudits_AddAudit4_Search.cfm?Year=#URL.Year#&ID=#URL.ID#">Add/Edit</A>]
		</cfif>
	</cfif><br />

<u>In-Process</u>: Project Handler's Manager<br />
<u>Full</u>: Prime Revewier's Manager OR Test Data Validator's Manager<br /><br />

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
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

    	<cfif Approved NEQ "Yes">
        	[<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=CCN&label=Primary CCN">Add/Edit</A>]
        </cfif>
	</cfif><br />
<cfif len(CCN)>
	#CCN# (Primary)
<cfelse>
	<font class="warning">None Listed</font>
</cfif><br /><br />

<cfif len(CCN2)>
	<u>Other CCNs</u>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

    	<cfif Approved NEQ "Yes">
			 [<a href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=CCN2&label=Other CCNs">Add/Edit</a>]
        </cfif>
    </cfif><br />
	#replace(CCN2, ",", "<br />", "All")#<br /><br />
</cfif>

<b>Standard</b>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

    	<cfif Approved NEQ "Yes">
        	[<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=Standard&label=Primary Standard">Add/Edit</A>]
        </cfif>
    </cfif><br />
<cfif len(Standard)>
	#Standard# (Primary)
<cfelse>
	None Listed
</cfif><br /><br />

<cfif len(Standard2)>
	<u>Other Standards</u>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

    	<cfif Approved NEQ "Yes">
        	[<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=Standard2&label=Other Standards">Add/Edit</A>]
        </cfif><br />
    </cfif>
	#replace(Standard2, ",", "<br />", "All")#<br /><br />
</cfif>

<b>Program</b>
	<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
		OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
        OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
		OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
        OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

    	<cfif Approved NEQ "Yes">
        	[<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=Program&label=Program">Add/Edit</A>]
        </cfif>
	</cfif><br>
<cfif len(Program)>
	#Program#
<cfelse>
	<font class="warning">None Listed</font>
</cfif><br><br>

<b>Roles</b><br>
<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
	OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
	OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
	OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
	OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

    <cfif AuditType2 eq "In-Process">
		<u>Project Handler</u>
        <cfif ReportPosted NEQ "Yes">
        [<A href="#IQADir#admin/TechnicalAudits_AddAudit2.cfm?#CGI.QUERY_STRING#">Edit</A>]
        </cfif>
        <br>
        #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept# / #ProjectHandlerEmail#<br /><br />

        <u>Project Handler's Manager</u>
        <cfif ReportPosted NEQ "Yes">
        [<A href="#IQADir#admin/TechnicalAudits_AddAudit2.cfm?#CGI.QUERY_STRING#">Edit</A>]
        </cfif>
        <br>
        #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept# / #ProjectHandlerManagerEmail#<br /><br>
	<cfelseif AuditType2 eq "Full">
        <u>Project Evaluator</u>
        <cfif ReportPosted NEQ "Yes">
        [<A href="#IQADir#admin/TechnicalAudits_AddAudit2.cfm?#CGI.QUERY_STRING#">Edit</A>]
        </cfif>
        <br>
        #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept# / #ProjectHandlerEmail#<br /><br />

        <u>Project Evaluator's Manager</u>
        <cfif ReportPosted NEQ "Yes">
        [<A href="#IQADir#admin/TechnicalAudits_AddAudit2.cfm?#CGI.QUERY_STRING#">Edit</A>]
        </cfif>
        <br>
        #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept# / #ProjectHandlerManagerEmail#<br /><br>

        <u>Test Data Validator</u>
        <cfif ReportPosted NEQ "Yes">
        [<A href="#IQADir#admin/TechnicalAudits_AddAudit2.cfm?#CGI.QUERY_STRING#">Edit</A>]
        </cfif>
        <br>
        #TDV# / #TDVOffice# / #TDVDept#<br /><br />

        <u>Test Data Validator's Manager</u>
        <cfif ReportPosted NEQ "Yes">
        [<A href="#IQADir#admin/TechnicalAudits_AddAudit2.cfm?#CGI.QUERY_STRING#">Edit</A>]
        </cfif>
        <br>
        #TDVManager# / #TDVManagerOffice# / #TDVManagerDept#<br /><br />
    </cfif>
<cfelse>
	<cfif AuditType2 eq "In-Process">
        <u>Project Handler</u><br>
        #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept# / #ProjectHandlerEmail#<br /><br>

        <u>Project Handler's Manager</u><br />
        #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept# / #ProjectHandlerManagerEmail#<br /><br>
    <cfelseif AuditType2 eq "Full">
        <u>Project Evaluator</u><br>
        #ProjectHandler# / #ProjectHandlerOffice# / #ProjectHandlerDept# / #ProjectHandlerEmail#<br /><br>

        <u>Project Evaluator's Manager</u><br />
        #ProjectHandlerManager# / #ProjectHandlerManagerOffice# / #ProjectHandlerManagerDept# / #ProjectHandlerManagerEmail#<br /><br>

        <u>Test Data Validator</u><br />
        #TDV# / #TDVOffice# / #TDVDept# / #TDVEmail#<br /><br />

        <u>Test Data Validator's Manager</u><br />
        #TDVManager# / #TDVManagerOffice# / #TDVManagerDept# / #TDVManagerEmail#<br /><br />
    </cfif>
</cfif>

<cfif len(TAM)>
<b>Deputy Technical Audit Manager</b><br />
#TAM#<br /><br />
</cfif>

<b>Notes</b>
<cfif SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "SU"
	OR FormEmpNoCheck eq "Yes" AND Request.TechnicalAuditManager CONTAINS qEmpLookup.employee_email
	OR SessionActive eq "Yes" AND SESSION.Auth.AccessLevel eq "Technical Audit"
	OR FormEmpNoCheck eq "Yes" AND qEmpLookup.employee_email eq TAM
	OR SessionActive eq "Yes" AND SESSION.Auth.username eq "Oates">

    [<A href="#IQADIR#TechnicalAudits_AuditDetails_Edit.cfm?Year=#URL.Year#&ID=#URL.ID#&var=Notes&label=Notes">Edit</A>]
</cfif><br>
#replace(Notes, "!", "'", "All")#
</cfoutput>

</cflock>