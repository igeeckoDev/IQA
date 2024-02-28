<!--- Header, Menu, Title, CSS, Table, Start of Page HTML --->
<cfset subTitle = "Audit Management">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">
<!--- / --->

<cflock scope="SESSION" timeout="10">
	<CFQUERY BLOCKFACTOR="100" NAME="AuditorProfile" Datasource="Corporate">
	SELECT ID, Lead, Auditor, Status, Qualified
	FROM AuditorList
	WHERE Auditor = '#SESSION.Auth.Name#'
	</cfquery>

	<cfoutput>
	<cfif SESSION.Auth.AccessLevel eq "Admin"
	  OR SESSION.Auth.AccessLevel eq "IQAAuditor"
	  OR SESSION.Auth.AccessLevel eq "SU">

		<u>IQA Audits - List View</u><br>
		 :: <a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=Auditor&Type2=#SESSION.Auth.Name#">Your IQA Audits - #CurYear#</a><br>
		 :: <a href="#SiteDir#IQA/Admin/Audit_List2.cfm?Year=#CurYear#&Type=IQA">All IQA Audits - #CurYear#</a><br><Br>

		<u>IQA Audits - Matrix View</u><br>
		 :: <a href="#SiteDir#IQA/Admin/AuditMatrix.cfm?Year=#curYear#&Auditor=#SESSION.AUTH.NAME#">Your IQA Audits - #curYear#</a><br>
		 :: <a href="#SiteDir#IQA/Admin/AuditMatrix.cfm?Year=#curYear#">All IQA Audits - #curYear#</a><br><br>

		<u>IQA and DAP Auditor Allocation</u><br>
		 :: <a href="menu_AuditorAllocation.cfm?Year=#curYear#">IQA and DAP Auditor Allocation</a><br><br>

		<u>DAP Audit Information</u><br>
		 :: <a href="DAPClientList.cfm?Order=DA&Status=Active">DAP Client List</a><br>
		 :: <a href="AuditMatrix_DAP.cfm?Year=#curYear#">All DAP Audits - #CurYear#</a><br>
		 <cfif SESSION.Auth.AccessLevel eq "SU"
		 	OR SESSION.Auth.Username eq "Ziemnick"
		 	OR SESSION.Auth.Username eq "Aoyagi">
 		 :: <a href="DAP_Documents.cfm">DAP Documents List</a><br>
		</cfif><br>

		<u>IQA Audit Information</u><br>
		 :: <a href="#SiteDir#IQA/Admin/NotApproved.cfm">Audits Awaiting Approval</a><br>

		 <cfif SESSION.Auth.AccessLevel eq "Admin"
	  		OR SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Lead eq "Yes"
	  		OR SESSION.Auth.AccessLevel eq "SU">

		 :: <a href="#SiteDir#IQA/Admin/AuditReport_Confirmation.cfm?Year=#curYear#">Audit Scope and Report Confirmation</a><br>
		 :: <a href="#SiteDir#IQA/Admin/AuditTime_ViewAll.cfm?Year=#curYear#">Audit Time - Planning and Reporting</a><br>
		 :: <a href="#SiteDir#IQA/Admin/viewStatusPages.cfm">Audit Status Pages</a> (Scope, Report, Pathnotes Completion)<br>
		 :: <a href="#SiteDir#IQA/Admin/AuditCompletion.cfm?Year=All">Audit Scope/Report On-Time Completion Metrics</a><br>
		</cfif>
		 :: <A href="#siteDir#IQA/Admin/SRMenu.cfm">SRs Generated by IQA Audits</a><br>
		 <cfif SESSION.Auth.AccessLevel NEQ "IQAAuditor">
		 	:: <a href="#SiteDir#IQA/Admin/addaudit.cfm?AuditedBy=IQA">Add IQA Audit</a><Br>
		 </cfif>

		<cfif SESSION.Auth.AccessLevel eq "SU"
			OR SESSION.Auth.AccessLevel eq "Admin" AND SESSION.Auth.UserName eq "Huang">
			 :: <a href="#SiteDir#IQA/Admin/Auditor_Req_View.cfm">Auditor Requests</a><Br>
			 :: <a href="#SiteDir#IQA/Admin/viewCancelRequests.cfm?Year=#curYear#">IQA Audit Cancellations and Reschedules - View Requests</a><br>
		</cfif><br>

		<cfif SESSION.Auth.AccessLevel eq "SU"
			OR SESSION.Auth.AccessLevel eq "Admin" AND SESSION.Auth.UserName eq "Huang">

		<u>CAR, DAP, IQA Record Storage Categories</u><br>
		 :: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=5">CAR Administrator Performance</a><br>
		 :: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=1">CAR Training Attendance</a><br>
		 :: <a href="#SiteDir#IQA/Admin/DAPLeadAuditorOversightRecords.cfm">DAP Lead Auditor Oversight Records</a><br>
		 :: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=18">DAP Lead Auditor Training</a><br>
		 :: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=20">DAP Overview Training</a><br>
		 :: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=17">DAP Performance and Monitoring</a><br>
		 :: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=16">IQA - Calibration Training Test Results</a><br>
		 :: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=7">IQA - Internal Auditor Performance Monitoring</a><br>
		 :: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=10">IQA Audit Planning</a> (for 2013-2014, see <a href="AuditPlanning.cfm?Year=2016">Audit Planning Module</a> for 2015+ Audit Planning<br>
		 :: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=3">IQA Audit Plans</a><br>
		 :: <a href="#SiteDir#IQA/Admin/AuditorInTrainingRecords.cfm">IQA Auditor In-Training Form and Records</a><br><br>
		</cfif>

		<cfif AuditorProfile.Qualified CONTAINS "DAP Trainer">
		<u>DAP Lead Auditor Training</u><br>
		:: <a href="#SiteDir#IQA/Admin/ViewFiles.cfm?CategoryID=18">DAP Lead Auditor Training</a><br><br>
		</cfif>

		<u>IQA and DAP Auditor Information</u><br>
		 :: <a href="#SiteDir#IQA/Admin/Aprofiles.cfm?View=All">Auditor List and Profiles</a><br>
		 :: <a href="#SiteDir#IQA/Admin/AProfiles_Detail.cfm?ID=#AuditorProfile.ID#">Your Auditor Profile</a><br>

		 <cfif SESSION.Auth.AccessLevel eq "Admin"
	  		OR SESSION.Auth.AccessLevel eq "SU">
		 :: <a href="#SiteDir#IQA/Admin/_Quals.cfm">IQA Auditor Training Table</a><br>
		 </cfif>

		 <cfif SESSION.Auth.AccessLevel eq "Admin"
	  		OR SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Lead eq "Yes"
	  		OR SESSION.Auth.AccessLevel eq "SU">
		 :: <a href="#SiteDir#IQA/Admin/AuditorInTrainingRecords.cfm">Auditor In Training Records</a><Br>
		 </cfif>

		 <cfif SESSION.Auth.AccessLevel eq "Admin"
	  		OR SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Qualified CONTAINS "DAP Qualifier"
	  		OR SESSION.Auth.AccessLevel eq "SU">
		 :: <a href="#SiteDir#IQA/Admin/DAPLeadAuditorOversightRecords.cfm">DAP Lead Auditor Oversight Records</a><Br>
		</cfif>

		<cfif SESSION.Auth.AccessLevel eq "Admin"
	  		OR SESSION.Auth.AccessLevel eq "SU"
			OR SESSION.Auth.AccessLevel eq "Adams"
			OR SESSION.Auth.Username eq "Berger"
			OR SESSION.Auth.Username eq "Tran" 
                        OR SESSION.Auth.Username eq "Howell">
		 :: <a href="#SiteDir#IQA/Admin/DAPReviewForm_OutputTable.cfm">DAP Review Form Records</a><Br>
		</cfif><br>

		<u>Yearly Audit Planning Survey Results</u><br>
		 :: <a href="#SiteDir#IQA/Planning/Distribution_#curyear#.cfm?Type=Program">Yearly IQA Audit Planning Survey Results</a><br>
		 :: <a href="#SiteDir#IQA/Planning/DAP_Distribution_2016.cfm">Yearly DAP Audit Planning Survey Results</a><br><br>

		<cfif SESSION.Auth.AccessLevel eq "Admin"
	  		OR SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Lead eq "Yes"
	  		OR SESSION.Auth.AccessLevel eq "SU">
		<u>Site, Program and Database Management</u><br>
		 :: <a href="#SiteDir#IQA/Admin/select_office.cfm">Site Profiles</a><br>
		 :: <a href="#SiteDir#IQA/Admin/_prog.cfm?list=CPO">UL Programs Master List</a><br>
		 :: <a href="#SiteDir#IQA/Admin/viewControlPanel.cfm">Database Controls (Lists, Settings)</a><br>
		 &nbsp; &nbsp; - Global Functions<br>
		 &nbsp; &nbsp; - Subject Matter Expert (SME) List<br>
		 &nbsp; &nbsp; - Manage All Accreditors<br>
		 &nbsp; &nbsp; - Programs Audited by IQA<br>
		 &nbsp; &nbsp; - Office List/Site Profiles<br>
 		 &nbsp; &nbsp; - UL Sites - OSHA SNAP Site Control<br>
		 &nbsp; &nbsp; - International Certification Form (IC Form) Control<br>
		 &nbsp; &nbsp; - Manage IQA FAQ<br><br>
		 </cfif>
	</cfif>

	<cfif SESSION.Auth.AccessLevel eq "Admin"
	  OR SESSION.Auth.AccessLevel eq "SU">
		<u>Audit and CAR Survey Results</u><br>
		 :: <a href="#SiteDir#IQA/Admin/viewSurveys_menu.cfm">Audit/CAR Survey Results</a><br><br>
	<cfelseif SESSION.Auth.AccessLevel eq "IQAAuditor" AND AuditorProfile.Lead eq "Yes">
		<u>Audit Survey Results</u><br>
		Note - You can view survey results for audits where you were the Lead Auditor<br>
		:: <a href="AuditSurvey_Distribution.cfm?Year=#curYear#&Auditor=#AuditorProfile.Auditor#">Audit Survey Results</a><br><br>
	</cfif>

	<cfif SESSION.Auth.AccessLevel eq "Admin"
	  OR SESSION.Auth.AccessLevel eq "SU"
	  OR SESSION.Auth.AccessLevel eq "IQAAuditor" >
		<u>Audit Planning Matrix</u><br>
		 :: <a href="#SiteDir#IQA/Admin/AuditPlanning.cfm?Year=2019">Audit Planning</a><br><br>
	</cfif>

	<u>Audit Report Attachments</u><br>
	 :: <a href="ReportATtachments_View.cfm?year=#curYear#">Audit Report Attachments</a><br><br>

	<cfif SESSION.Auth.AccessLevel eq "SU">
	<u>Superuser Only</u><br>
		 :: <a href="#SiteDir#IQA/Admin/Baseline.cfm?year=#curyear#">Audit Schedule Baseline</a><br>
		 :: <a href="#SiteDir#IQA/Admin/AccredLocations/index.cfm">UL Accreditations (No longer used)</a><br>
		 :: <a href="#SiteDir#IQA/Admin/ASReports.cfm?Year=#CurYear#">Accreditor Reports (ANSI / OSHA / SCC) (No longer used)</a><br>
	</cfif><br>
	</cfoutput>
</cflock>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- / --->