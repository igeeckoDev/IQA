<cfif cgi.SCRIPT_NAME is "#IQARootDir#qReport_Output_AllNew.cfm">
	<cfoutput>
	    <link href="#Request.CSS#" rel="stylesheet" media="screen">
        <div class="content-pad">
		<table>
		<tr>
		<td align="left" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
	</cfoutput>
</cfif>

<!--- April 29, 2009
Tested for CF8/Oracle
Adjusted Queries to have alias of "year" for fieldname "year_" that exists in AuditSchedule and Report1-5 tables
Added cfqueryparam for url.id and url.year
added conditional for an audit that does not exist, and for a report that is not published.
---->

<!--- 8/29/2007 updated findings/obs table to include new key processes for 9/2007 audits, if/then for old audits, also if/then for extra queries for new KP --->
<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Check">
SELECT AuditType2, ID, YEAR_ as "Year", AuditedBy, AuditType, Month, startDate
FROM AuditSchedule
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<!--- if this is a TPTDP Audit, go to TP Report Output Page --->
<cfif Check.AuditType is "TPTDP">
	<cflocation url="TPReport_Output_All.cfm?#CGI.Query_String#" addtoken="no">
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View">
SELECT AuditSchedule.ID,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditArea, AuditSchedule.Area, AuditSchedule.StartDate,
AuditSchedule.EndDate, AuditSchedule.LeadAuditor, AuditSchedule.Auditor, AuditSchedule.AuditorInTraining, AuditSchedule.RD, AuditSchedule.Status,
AuditSchedule.RescheduleNextYear, AuditSchedule.Scope, AuditSchedule.AuditType, AuditSchedule.AuditType2, AuditSchedule.Report, AuditSchedule.Desk, AuditSchedule.Month,
AuditSchedule.ICForm, Report.ReportDate, Report.KCInfo, Report.KCInfo2, Report.Summary, Report.BestPrac, Report.Offices, Report.Attach,
Report.Sectors, Report.Programs, AuditSchedule.SME, AuditSchedule.initialSiteAudit, Report.OFIs

FROM REPORT, AuditSchedule

WHERE Report.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Report.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND AuditSchedule.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Report.AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="Audit">
SELECT AuditSchedule.*, AuditSchedule.Year_ AS "Year" FROM AuditSchedule
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<!--- 8/22/2007 - 9/2007 audits and forward will use an expanded list of Key Processes.--->
<!--- Old list retained for past audits --->
<cfif Audit.Year is 2007>
	<cfif Audit.Month gte 9>
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
		SELECT * FROM KP_Report_2
		ORDER BY Alpha
		</CFQUERY>
	<cfelse>
		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
		SELECT * FROM KP_Report
		ORDER BY Alpha
		</CFQUERY>
	</cfif>
<cfelseif Audit.Year gt 2007>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
	SELECT * FROM KP_Report_2
	ORDER BY Alpha
	</CFQUERY>
<cfelseif Audit.Year lt 2007>
	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
	SELECT * FROM KP_Report
	ORDER BY Alpha
	</CFQUERY>
</cfif>

<cfif Check.Year eq 2009>
	<cfquery name="Clauses" Datasource="Corporate">
	SELECT * FROM Clauses_2009Jan1
	ORDER BY ID
	</cfquery>

	<cfset maxRow = 35>
<cfelseif Check.Year eq 2010>
	<cfif Check.Month lt 9>
		<cfquery name="Clauses" Datasource="Corporate">
		SELECT * FROM Clauses_2009Jan1
		ORDER BY ID
		</cfquery>

		<cfset maxRow = 35>
	<cfelseif Check.Month gte 9>
		<cfquery name="Clauses" Datasource="Corporate">
		SELECT * FROM Clauses_2010SEPT1
		ORDER BY ID
		</cfquery>

		<cfset maxRow = 37>
	</cfif>
<cfelseif Check.Year gte 2011>
	<cfif Audit.year lt 2019>

		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="clauses">
		SELECT * FROM Clauses_2010SEPT1
		ORDER BY ID
		</CFQUERY>
		<cfset maxRow = 37>
	<cfelse>

		<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="clauses">
		SELECT * FROM Clauses_2018May17
		ORDER BY ID
		<cfset maxRow = 45>
		</CFQUERY>
	</cfif>

<cfelse>
	<cfquery name="Clauses" Datasource="Corporate">
	SELECT * FROM Clauses
	ORDER BY ID
	</cfquery>

	<cfset maxRow = 34>
</cfif>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View1">
SELECT * FROM REPORT
WHERE Report.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Report.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND Report.AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="KP">
SELECT * FROM KP_Report
ORDER BY Alpha
</cfquery>

<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View2">
SELECT Report2.*, Report2.Year_ AS "Year"
FROM REPORT2
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
</cfquery>

<!--- stored procedure 'query' is the same as output2 query below
<cfquery name="Output2" Datasource="Corporate">
SELECT Query.*, Query.Year_ AS "Year" FROM Query
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>
--->

<cfquery name="Output" Datasource="Corporate">
SELECT
	Report4.*, AuditSchedule.Area, AuditSchedule.OfficeName
FROM
	AuditSchedule, Report4
WHERE
	Report4.ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Report4.Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
AND AuditSchedule.ID = Report4.ID
AND AuditSchedule.Year_ = Report4.Year_
</cfquery>

<cfoutput query="Check">
<cfif AuditType2 is "Field Services" or AuditType2 is "Local Function FS">
<cfquery name="OutputFS" Datasource="Corporate">
SELECT Report5.*, Report5.Year_ AS "Year"
FROM Report5
WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
</cfquery>
</cfif>
</cfoutput>
<br />

<!--- if the audit report exists --->
<cfif Check.RecordCount eq 1 AND View1.RecordCount eq 1>

<cfif cgi.SCRIPT_NAME NEQ "#IQARootDir#qReport_Output_All.cfm">
<cflock scope="Session" timeout="5">
<cfif isDefined("SESSION.Auth.IsLoggedIn")>
	<cfoutput query="View" group="ID">
		<CFIF SESSION.Auth.accesslevel is "SU"
            OR SESSION.Auth.accesslevel is "Admin"
            OR SESSION.Auth.SubRegion is "#AuditedBy#"
            OR LeadAuditor is "#SESSION.AUTH.NAME#"
            OR Auditor CONTAINS "#SESSION.AUTH.NAME#"
			OR AuditorInTraining CONTAINS "#SESSION.AUTH.NAME#">
			<b>Available Actions</b><br>

			:: <a href="#IQARootDir#qReport_Output_AllNew.cfm?#CGI.Query_String#" target="_blank">Print</a> Report<br>
			<cfif Report is "Completed">
				:: <u>Report Published</u><br>
	        <cfelse>
				<cfif Year GTE 2010>
					<cfif AuditedBy eq "IQA"
						AND AuditType2 eq "Local Function"
						AND Year GTE 2010
						AND Area EQ "Processes"
					OR AuditedBy eq "IQA"
						AND AuditType2 eq "Local Function"
						AND Year GTE 2010
						AND Area EQ "Processes and Labs"
					OR AuditedBy eq "IQA"
						AND AuditType2 eq "Program"
						AND Year GTE 2010
						AND OfficeName eq "UL International Demko A/S">

						<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="IC">
						SELECT IC, ID FROM IQAtblOffices
						WHERE OfficeName = '#View.OfficeName#'
						</cfquery>

						<Cfif IC.IC EQ "Yes" AND AuditArea DOES NOT CONTAIN "Desk Audit of Bangalore"
						 AND AuditArea NEQ "Scheme Documentation Audit">

							<u><b>International Certification (IC) Form Required</b></u> <A HREF="javascript:popUp('../webhelp/webhelp_ICForm.cfm')">[?]</A><br>
							<cfif NOT len(ICForm)>
                                :: <a href="#IQAAdminDir#ICForm_Upload.cfm?ID=#URL.ID#&Year=#URL.Year#&OfficeID=#IC.ID#">Upload</a> IC Form<br><Br>
                                :: <a href="#IQAAdminDir#Report_Edit1New.cfm?#CGI.Query_String#">Edit</a> Report
							<cfelse>
                                :: <a href="#IQARootDir#ICForm/#ICForm#">View</a> IC Form<br>
                                :: <a href="#IQAAdminDir#Report_Publish_Confirm.cfm?#CGI.Query_String#">Publish</a> Report<br><br>
                                :: <a href="#IQAAdminDir#Report_Edit1NEW.cfm?#CGI.Query_String#">Edit</a> Report
							</cfif><br>
						<cfelse>
                            :: <a href="#IQAAdminDir#Report_Publish_Confirm.cfm?#CGI.Query_String#">Publish</a> Report<br>
                            :: <a href="#IQAAdminDir#Report_Edit1NEW.cfm?#CGI.Query_String#">Edit</a> Report<br>
						</CFIF>
					<cfelse>
                        :: <a href="#IQAAdminDir#Report_Publish_Confirm.cfm?#CGI.Query_String#">Publish</a> Report<br>
                        :: <a href="#IQAAdminDir#Report_Edit1NEW.cfm?#CGI.Query_String#">Edit</a> Report<br>
					</cfif>
				<cfelseif Year LT 2010>
					:: <a href="#IQAAdminDir#Report_Publish_Confirm.cfm?#CGI.Query_String#">Publish</a> Report<br>
					:: <a href="#IQAAdminDir#Report_Edit1NEW.cfm?#CGI.Query_String#">Edit</a> Report<br>
				<cfelse>
					:: <a href="#IQAAdminDir#Report_Publish_Confirm.cfm?#CGI.Query_String#">Publish</a> Report<br>
					:: <a href="#IQAAdminDir#Report_Edit1NEW.cfm?#CGI.Query_String#">Edit</a> Report<br>
				</cfif>
	        </cfif>
        </cfif>

	:: <a href="#IQAAdminDir#Report_UploadFiles.cfm?ID=#URL.ID#&Year=#URL.Year#&Auditedby=#URL.AuditedBy#">Upload Report Attachment File(s)</a><br>
	:: <a href="#IQAAdminDir#AuditDetails.cfm?ID=#URL.ID#&Year=#URL.Year#">Audit Details</a><br><br>

	   <!--- Initial Audit --->
	   <cfif View.InitialSiteAudit eq 1>
	       	<cfif View.AuditType2 eq "Program">
	            <br>
	            <font class="warning">
	            	<u>Note</u>: Initial Audit of this Program
	            </font>
	        <cfelse>
	            <font class="warning">
		            <strong><u>Note</u>: Initial Audit of this Site<br></strong>
	 	        </font>
	 	           If a Laboratory that conducts UL LLC Certification Body activity is included in the scope of this audit, 00-CE-P0851 must be included.
			</cfif>
	    <br /><Br />
	   </cfif>
	   <!--- /// ---->
	</cfoutput>

</cfif>
</cflock>
</cfif>

	<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="AttachCheck">
    SELECT rID, ID, Year_, FileName, FileLabel
	FROM ReportAttach
	WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
	AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
	AND Status IS NULL
    </CFQUERY>

<!--- Report Attachment Files --->
<cfif AttachCheck.recordcount neq 0>
<b>Attachments</b><br>
   	<cfoutput query="AttachCheck">
       	::
		<cfif filelabel is "">
			#filename# - <a href="#IQARootDir#Reports/#filename#">View</a>
			<cflock scope="Session" timeout="5">
				<cfif isDefined("SESSION.Auth.IsLoggedIn")>
					<CFIF SESSION.Auth.accesslevel is "SU"
			            OR SESSION.Auth.accesslevel is "Admin"
			            OR SESSION.Auth.SubRegion is "#AuditedBy#"
			            OR View.LeadAuditor is "#SESSION.AUTH.NAME#"
			            OR View.Auditor CONTAINS "#SESSION.AUTH.NAME#"
						OR View.AuditorInTraining CONTAINS "#SESSION.AUTH.NAME#"><strong></strong>
						 :: <a href="#IQAAdminDir#Report_Attachments_Remove.cfm?rID=#rID#&#CGI.Query_String#">Remove</a>
					</cfif>
				</cfif>
			</cflock>
		<cfelse>
           	#fileLabel# - <a href="#IQARootDir#Reports/#filename#">View</a>
			<cflock scope="Session" timeout="5">
				<cfif isDefined("SESSION.Auth.IsLoggedIn")>
					<CFIF SESSION.Auth.accesslevel is "SU"
			            OR SESSION.Auth.accesslevel is "Admin"
			            OR SESSION.Auth.SubRegion is "#AuditedBy#"
			            OR View.LeadAuditor is "#SESSION.AUTH.NAME#"
			            OR View.Auditor CONTAINS "#SESSION.AUTH.NAME#"
						OR View.AuditorInTraining CONTAINS "#SESSION.AUTH.NAME#">
						 :: <a href="#IQAAdminDir#Report_Attachments_Remove.cfm?rID=#rID#&#CGI.Query_String#">Remove</a>
					</cfif>
				</cfif>
			</cflock>
		</cfif><br>
	</cfoutput><br>

	<cflock scope="Session" timeout="5">
		<cfif isDefined("SESSION.Auth.IsLoggedIn")>
			<CFIF SESSION.Auth.accesslevel is "SU"
		        OR SESSION.Auth.accesslevel is "Admin"
		        OR SESSION.Auth.SubRegion is "#AuditedBy#"
		        OR View.LeadAuditor is "#SESSION.AUTH.NAME#"
		        OR View.Auditor CONTAINS "#SESSION.AUTH.NAME#"
				OR View.AuditorInTraining CONTAINS "#SESSION.AUTH.NAME#">
					<u>Instructions</u>:<br>
					If you wish to remove an attachment:<br>
					1) Select the "remove" link for the attachment you wish to remove. This will remove the attachment.<br>
					2) Upload a new attachment using the "Upload Report Attachment File(s)" link in the "Available Actions" section above.<br><Br>
			</cfif>
		</cfif>
	</cflock>
</cfif>

<cfoutput query="View" group="ID">
<b><u>General Information and New CARs</u></b><br><br>

<B>Audit Report Number</b><br>
#Year#-#ID#-#auditedby#<br><br>

<b>Location</b><br>
<!--- count the number of offices in the string, we're counting the delimeter (!) and adding 1, since one office would have no delimeters --->
<cfset numOffices = 1 + (len(OfficeName) - len(replace(OfficeName, "!", "", "All")))>

<!--- if there is more than one office listed --->
<cfif numOffices GT 1>
	<!--- replace the delimeter with a break --->
	#replace(OfficeName, "!", "<br />", "All")#
<!--- if there is one office --->
<cfelseif numOffices EQ 1>
	#OfficeName#<br />
</cfif><br />

<cfif AuditType is "Field Services">
#Area#<br>
<b>Audit Area</b><br />
#AuditArea#<br>
<cfelse>
	<cfif Trim(AuditArea) is "">
	<cfelse>
	<b>Audit Area</b><br />
    #AuditArea#<br>
	#Area#<br>
	</cfif>
</cfif><br>

<!--- 1/14/2009 changed 'verification' to 'a sampling' for Locations, Sectors, and Progams below --->

<b>Other Locations Included in Audit</b><br>
This Audit included a sampling of the program/process activities associated with the following sites:<br>
--------<br>
<cfif Offices is "">
None Listed
<cfelse>
<cfset OfficeDump = #replace(Offices, "!!,", "<br>", "All")#>
<cfset OfficeDump2 = #replace(OfficeDump, "!!", "", "All")#>
<cfset OfficeDump3 = #replace(OfficeDump2, "NoChanges,", "", "All")#>
<cfset OfficeDump4 = #replace(OfficeDump3, "None,", "", "All")#>
#OfficeDump4#
</cfif><br><br>

<cfif Audit.Year gt 2008 OR Audit.Year is 2008 AND Audit.Month gte 10>
<b>Sectors</b><br>
This Audit included a sampling of the process activities associated with the following Sectors:<br>
--------<br>
<cfif Sectors is "">
None Listed
<cfelse>
<cfset SectorDump = #replace(Sectors, "!!,", "<br>", "All")#>
<cfset SectorDump2 = #replace(SectorDump, "!!", "", "All")#>
<cfset SectorDump3 = #replace(SectorDump2, "NoChanges,", "", "All")#>
<cfset SectorDump4 = #replace(SectorDump3, "None,", "", "All")#>
#SectorDump4#
</cfif><br><br>
</cfif>

<cfif AuditType2 is NOT "Program">
<b>Programs Sampled During Audit</b><br>
This Audit was conducted on the specified process/location. (See Location/Audit Area above)<br>
The following programs were active at the time of the audit and randomly sampled as a representation of process/location activities.<br>
--------<br>
<cfif Programs is "">
None Listed
<cfelse>
<cfset ProgDump = #replace(Programs, "!!,", "<br>", "All")#>
<cfset ProgDump2 = #replace(ProgDump, "!!", "", "All")#>
<cfset ProgDump3 = #replace(ProgDump2, "NoChanges,", "", "All")#>
<cfset ProgDump4 = #replace(ProgDump3, "None,", "", "All")#>
<cfset ProgDump5= #replace(ProgDump4, "<PS>", "&lt;PS&gt;", "All")#>
#ProgDump5#
</cfif><br><br>
</cfif>

<b>Audit Dates</b><br>
<!--- uses incDates.cfc --->
<cfinvoke
	component="IQA.Components.incDates"
    returnvariable="DateOutput"
    method="incDates">

	<cfif len(StartDate)>
        <cfinvokeargument name="StartDate" value="#StartDate#">
    <cfelse>
        <cfinvokeargument name="StartDate" value="">
    </cfif>

	<cfif len(EndDate)>
        <cfinvokeargument name="EndDate" value="#EndDate#">
    <cfelse>
        <cfinvokeargument name="EndDate" value="">
    </cfif>

    <cfinvokeargument name="Status" value="#Status#">
    <cfinvokeargument name="RescheduleNextYear" value="#RescheduleNextYear#">
</cfinvoke>

<!--- output of incDates.cfc --->
#DateOutput#<Br /><Br />

<b>Report Date</b><br>
#Dateformat(ReportDate, 'mmmm dd, yyyy')#<br><br>

<b>Auditor(s)</b><br>
<cfif NOT len(Trim(LeadAuditor)) OR Trim(LeadAuditor) is "- None -">
	<cfif NOT len(Trim(Auditor)) OR Trim(Auditor) is "- None -">
		No Auditors Listed<br /><br />
	<cfelse>
		#replace(Auditor, ",", ", ", "All")#<br /><br />
	</cfif>
<cfelseif NOT len(Trim(Auditor)) OR Trim(Auditor) is "- None -">
    #LeadAuditor#, Lead<br /><br />
<CFELSE>
    #LeadAuditor#, Lead<br />
    <cfset AuditorDump = replace(Auditor, ",", ", ", "All")>
    #replace(AuditorDump, ", ", "<br />", "All")#<br /><br />
</cfif>

<cfif isDefined("AuditorInTraining")>
	<cfif Trim(AuditorInTraining) NEQ "- None -" AND len(AuditorInTraining)>
		<b>Auditor(s) In Training</b><br />
		<cfset AuditorInTrainingDump = replace(AuditorInTraining, ",", ", ", "All")>
		#replace(AuditorInTrainingDump, ", ", "<br />", "All")#<br /><Br />
	</cfif>
</cfif>

<cfif len(SME)>
<B>Suject Matter Expert</B><br>
#SME#<br><br>
</cfif>

<b>Audit Type</b><br>
#AuditType#, #AuditType2#<br><br>

<cfif year gt 2009 OR year eq 2009 AND month gte 4>
	<b>Primary Contact</b><br>
	<cfset Dump = #replace(KCInfo, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	#Dump1#
	<br><br>

	<b>Other Contacts</b><br>
	<cfset Dump = #replace(KCInfo2, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	<cfif len(Dump1)>
		#Dump1#
	<cfelse>
		None Listed
	</cfif>
	<br><br>
<cfelse>
	<b>Contact(s) Email</b><br>
	<cfset Dump = #replace(KCInfo, ",", "<br>", "All")#>
	<cfset Dump1 = #replace(Dump, ", ", "<br>", "All")#>
	#Dump1#
	<br><br>
</cfif>

<b>Scope</b><br>
<cfif Year GTE 2016>
	<cfif AuditType2 eq "MMS - Medical Management Systems">
	#Request.MMSScope#
	<cfelse>
	#Request.IQAScope2016#
	</cfif>
<cfelseif Year EQ 2015>
	#Request.IQAScope2015#
<cfelse>
	<cfset dump = #replace(Scope, "<p>", "", "All")#>
	<cfset dump1 = #replace(dump, "</p>", "", "All")#>
	#dump1#
</cfif><br><br>

<!--- Reference Documents --->
<cfinclude template="incRD.cfm">

<b>Audit Summary</b><br>
<cfset Dump = #replace(Summary, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
#Dump2#<br><br>

<cfif check.Year GTE 2016
	OR check.Year EQ 2015 AND check.Month GT 10
	OR check.Year EQ 2015 AND check.StartDate GTE "10/12/2015">
	<b>Opportunities for Improvement (OFI)</b><br>
	<cfset Dump = #replace(OFIs, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
	#Dump2#<br><br>
</cfif>

</cfoutput>

<cfset var=ArrayNew(3)>
<cfset varnew=ArrayNew(3)>

<CFSET varnew[1][1][1] = 'General/Organization'>
<CFSET varnew[2][1][1] = 'Quality System'>
<CFSET varnew[3][1][1] = 'Document Control'>
<CFSET varnew[4][1][1] = 'Review of Requests, Tenders, and Contracts'>
<CFSET varnew[5][1][1] = 'Subcontracting'>
<CFSET varnew[6][1][1] = 'Purchasing'>
<CFSET varnew[7][1][1] = 'Confidentiality'>
<CFSET varnew[8][1][1] = 'Complaints'>
<CFSET varnew[9][1][1] = 'Control of Non-Conforming Tests and Calibrations'>
<CFSET varnew[10][1][1] = 'Improvement'>
<CFSET varnew[11][1][1] = 'Corrective Action'>
<CFSET varnew[12][1][1] = 'Preventive Action'>
<CFSET varnew[13][1][1] = 'Records'>
<CFSET varnew[14][1][1] = 'Internal Audits'>
<CFSET varnew[15][1][1] = 'Management Review'>
<CFSET varnew[16][1][1] = 'Global Technical Requirements'>
<CFSET varnew[17][1][1] = 'Personnel'>
<CFSET varnew[18][1][1] = 'Accomodation, Facilities, Eqiupment and Environmental Conditions'>
<CFSET varnew[19][1][1] = 'Test and Calibration Methods and Method Validation'>
<CFSET varnew[20][1][1] = 'Equipment'>
<CFSET varnew[21][1][1] = 'Measuring Traceability'>
<CFSET varnew[22][1][1] = 'Sampling'>
<CFSET varnew[23][1][1] = 'Handling of Test and Calibration Items'>
<CFSET varnew[24][1][1] = 'Assuring the Quality of Test and Calibration Results'>
<CFSET varnew[25][1][1] = 'Reports'>
<CFSET varnew[26][1][1] = 'Conditions and Procedures for Granting, Maintaining, Extending, Suspending And Withdrawing Certification'>
<CFSET varnew[27][1][1] = 'Application for Certification'>
<CFSET varnew[28][1][1] = 'Preparation for Evaluation'>
<CFSET varnew[29][1][1] = 'Evaluation'>
<CFSET varnew[30][1][1] = 'Decision on Certification'>
<CFSET varnew[31][1][1] = 'Surveillance'>
<CFSET varnew[32][1][1] = 'Use of Licenses, Certificates, Marks and Logos'>
<CFSET varnew[33][1][1] = 'Complaints to Suppliers'>
<CFSET varnew[34][1][1] = 'Cooperation'>
<CFSET varnew[35][1][1] = 'Change in Certification Requirements'>
<CFSET varnew[36][1][1] = 'Participation in Standards Development'>
<CFSET varnew[37][1][1] = 'Regulatory Bodies'>

<CFSET var[1][1][1] = 'Contracts'>
<CFSET var[2][1][1] = 'Control of Customer Property and Samples'>
<CFSET var[3][1][1] = 'Corrective and Preventive Action'>
<CFSET var[4][1][1] = 'Document Control'>
<CFSET var[5][1][1] = 'HR and Personnel'>
<CFSET var[6][1][1] = 'Inspection Program'>
<CFSET var[7][1][1] = 'Internal Quality Audits'>
<CFSET var[8][1][1] = 'Laboratory'>
<CFSET var[9][1][1] = 'Management Review'>
<CFSET var[10][1][1] = 'Nonconforming Test or Product'>
<CFSET var[11][1][1] = 'Program Specific'>
<CFSET var[12][1][1] = 'Purchasing'>
<CFSET var[13][1][1] = 'Quality System'>
<CFSET var[14][1][1] = 'Records'>
<CFSET var[15][1][1] = 'Subcontracting'>
<CFSET var[16][1][1] = 'Training and Competency'>
<CFSET var[17][1][1] = 'Certification Decision'>
<CFSET var[18][1][1] = 'Complaints and Appeals'>
<CFSET var[19][1][1] = 'Customer Service'>
<CFSET var[20][1][1] = 'Evaluation Process'>
<CFSET var[21][1][1] = 'Industry File Review'>
<CFSET var[22][1][1] = 'Surveillance'>
<CFSET var[23][1][1] = 'Other'>

<cfoutput query="View1">
<CFSET var[1][2][2] = '#CAR1#'>
<CFSET var[2][2][2] = '#CAR2#'>
<CFSET var[3][2][2] = '#CAR3#'>
<CFSET var[4][2][2] = '#CAR4#'>
<CFSET var[5][2][2] = '#CAR5#'>
<CFSET var[6][2][2] = '#CAR6#'>
<CFSET var[7][2][2] = '#CAR7#'>
<CFSET var[8][2][2] = '#CAR8#'>
<CFSET var[9][2][2] = '#CAR9#'>
<CFSET var[10][2][2] = '#CAR10#'>
<CFSET var[11][2][2] = '#CAR11#'>
<CFSET var[12][2][2] = '#CAR12#'>
<CFSET var[13][2][2] = '#CAR13#'>
<CFSET var[14][2][2] = '#CAR14#'>
<CFSET var[15][2][2] = '#CAR15#'>
<CFSET var[16][2][2] = '#CAR16#'>
<CFSET var[17][2][2] = '#CAR17#'>
<CFSET var[18][2][2] = '#CAR18#'>
<CFSET var[19][2][2] = '#CAR19#'>
<CFSET var[20][2][2] = '#CAR20#'>
<CFSET var[21][2][2] = '#CAR21#'>
<CFSET var[22][2][2] = '#CAR22#'>
<CFSET var[23][2][2] = '#CAR23#'>
<CFSET var[24][2][2] = '#CAR24#'>
<CFSET var[25][2][2] = '#CAR25#'>
<CFSET var[26][2][2] = '#CAR26#'>
<CFSET var[27][2][2] = '#CAR27#'>
<CFSET var[28][2][2] = '#CAR28#'>
<CFSET var[29][2][2] = '#CAR29#'>
<CFSET var[30][2][2] = '#CAR30#'>
<CFSET var[31][2][2] = '#CAR31#'>
<CFSET var[32][2][2] = '#CAR32#'>
<CFSET var[33][2][2] = '#CAR33#'>
<CFSET var[34][2][2] = '#CAR34#'>
<CFSET var[35][2][2] = '#CAR35#'>
<cfif Check.Year eq 2010 AND Check.Month gte 9 OR Check.Year gte 2011>
<CFSET var[36][2][2] = '#CAR36#'>
<CFSET var[37][2][2] = '#CAR37#'>
</cfif>

<cfif Check.Year gte 2019>

<CFSET var[39][2][2] = '#CAR39#'>
<CFSET var[40][2][2] = '#CAR40#'>
<CFSET var[41][2][2] = '#CAR41#'>
<CFSET var[42][2][2] = '#CAR42#'>

<CFSET var[38][2][2] = '#CAR38#'>
<CFSET var[43][2][2] = '#CAR43#'>
<CFSET var[44][2][2] = '#CAR44#'>
<CFSET var[45][2][2] = '#CAR45#'>
<CFELSE>

<CFSET var[38][2][2] = '#CAROther#'>
</CFIF>
<CFSET var[1][3][3] = '#Count1#'>
<CFSET var[2][3][3] = '#Count2#'>
<CFSET var[3][3][3] = '#Count3#'>
<CFSET var[4][3][3] = '#Count4#'>
<CFSET var[5][3][3] = '#Count5#'>
<CFSET var[6][3][3] = '#Count6#'>
<CFSET var[7][3][3] = '#Count7#'>
<CFSET var[8][3][3] = '#Count8#'>
<CFSET var[9][3][3] = '#Count9#'>
<CFSET var[10][3][3] = '#Count10#'>
<CFSET var[11][3][3] = '#Count11#'>
<CFSET var[12][3][3] = '#Count12#'>
<CFSET var[13][3][3] = '#Count13#'>
<CFSET var[14][3][3] = '#Count14#'>
<CFSET var[15][3][3] = '#Count15#'>
<CFSET var[16][3][3] = '#Count16#'>
<CFSET var[17][3][3] = '#Count17#'>
<CFSET var[18][3][3] = '#Count18#'>
<CFSET var[19][3][3] = '#Count19#'>
<CFSET var[20][3][3] = '#Count20#'>
<CFSET var[21][3][3] = '#Count21#'>
<CFSET var[22][3][3] = '#Count22#'>
<CFSET var[23][3][3] = '#Count23#'>
<CFSET var[24][3][3] = '#Count24#'>
<CFSET var[25][3][3] = '#Count25#'>
<CFSET var[26][3][3] = '#Count26#'>
<CFSET var[27][3][3] = '#Count27#'>
<CFSET var[28][3][3] = '#Count28#'>
<CFSET var[29][3][3] = '#Count29#'>
<CFSET var[30][3][3] = '#Count30#'>
<CFSET var[31][3][3] = '#Count31#'>
<CFSET var[32][3][3] = '#Count32#'>
<CFSET var[33][3][3] = '#Count33#'>
<CFSET var[34][3][3] = '#Count34#'>
<CFSET var[35][3][3] = '#Count35#'>
<cfif Check.Year eq 2010 AND Check.Month gte 9 OR Check.Year gte 2011>
<CFSET var[36][3][3] = '#Count36#'>
<CFSET var[37][3][3] = '#Count37#'>
</cfif>
<CFSET var[38][3][3] = '#CountOther#'>
<cfif Check.Year gte 2019>

<CFSET var[39][3][3] = '#Count39#'>
<CFSET var[40][3][3] = '#Count40#'>
<CFSET var[41][3][3] = '#Count41#'>
<CFSET var[42][3][3] = '#Count42#'>

<CFSET var[38][3][3] = '#Count38#'>
<CFSET var[43][3][3] = '#Count43#'>
<CFSET var[44][3][3] = '#Count44#'>
<CFSET var[45][3][3] = '#Count45#'>
<cfELSE>
<CFSET var[38][3][3] = '#CountOther#'>
</CFIF>

</cfoutput>

<cfset var2=ArrayNew(1)>
<cfoutput query="View1">
<CFSET var2[1] = '#OCount1#'>
<CFSET var2[2] = '#OCount2#'>
<CFSET var2[3] = '#OCount3#'>
<CFSET var2[4] = '#OCount4#'>
<CFSET var2[5] = '#OCount5#'>
<CFSET var2[6] = '#OCount6#'>
<CFSET var2[7] = '#OCount7#'>
<CFSET var2[8] = '#OCount8#'>
<CFSET var2[9] = '#OCount9#'>
<CFSET var2[10] = '#OCount10#'>
<CFSET var2[11] = '#OCount11#'>
<CFSET var2[12] = '#OCount12#'>
<CFSET var2[13] = '#OCount13#'>
<CFSET var2[14] = '#OCount14#'>
<CFSET var2[15] = '#OCount15#'>
<CFSET var2[16] = '#OCount16#'>
<CFSET var2[17] = '#OCount17#'>
<CFSET var2[18] = '#OCount18#'>
<CFSET var2[19] = '#OCount19#'>
<CFSET var2[20] = '#OCount20#'>
<CFSET var2[21] = '#OCount21#'>
<CFSET var2[22] = '#OCount22#'>
<CFSET var2[23] = '#OCount23#'>
<CFSET var2[24] = '#OCount24#'>
<CFSET var2[25] = '#OCount25#'>
<CFSET var2[26] = '#OCount26#'>
<CFSET var2[27] = '#OCount27#'>
<CFSET var2[28] = '#OCount28#'>
<CFSET var2[29] = '#OCount29#'>
<CFSET var2[30] = '#OCount30#'>
<CFSET var2[31] = '#OCount31#'>
<CFSET var2[32] = '#OCount32#'>
<CFSET var2[33] = '#OCount33#'>
<CFSET var2[34] = '#OCount34#'>
<CFSET var2[35] = '#OCount35#'>
<cfif Check.Year eq 2010 AND Check.Month gte 9 OR Check.Year gte 2011>
<CFSET var2[36] = '#OCount36#'>
<CFSET var2[37] = '#OCount37#'>
</cfif>

<cfif Check.Year gte 2019>

<CFSET var2[39]= '#OCount39#'>
<CFSET var2[40] = '#OCount40#'>
<CFSET var2[41] = '#OCount41#'>
<CFSET var2[42] = '#OCount42#'>

<CFSET var2[38] = '#OCount38#'>
<CFSET var2[43] = '#OCount43#'>
<CFSET var2[44] = '#OCount44#'>
<CFSET var2[45] = '#OCount45#'>
<CFElSE>
<CFSET var2[38] = '#OCountOther#'>
</CFIF>
</cfoutput>

<cfset varSR=ArrayNew(1)>
<cfoutput query="View1">
<CFSET varSR[1] = '#SR1#'>
<CFSET varSR[2] = '#SR2#'>
<CFSET varSR[3] = '#SR3#'>
<CFSET varSR[4] = '#SR4#'>
<CFSET varSR[5] = '#SR5#'>
<CFSET varSR[6] = '#SR6#'>
<CFSET varSR[7] = '#SR7#'>
<CFSET varSR[8] = '#SR8#'>
<CFSET varSR[9] = '#SR9#'>
<CFSET varSR[10] = '#SR10#'>
<CFSET varSR[11] = '#SR11#'>
<CFSET varSR[12] = '#SR12#'>
<CFSET varSR[13] = '#SR13#'>
<CFSET varSR[14] = '#SR14#'>
<CFSET varSR[15] = '#SR15#'>
<CFSET varSR[16] = '#SR16#'>
<CFSET varSR[17] = '#SR17#'>
<CFSET varSR[18] = '#SR18#'>
<CFSET varSR[19] = '#SR19#'>
<CFSET varSR[20] = '#SR20#'>
<CFSET varSR[21] = '#SR21#'>
<CFSET varSR[22] = '#SR22#'>
<CFSET varSR[23] = '#SR23#'>
<CFSET varSR[24] = '#SR24#'>
<CFSET varSR[25] = '#SR25#'>
<CFSET varSR[26] = '#SR26#'>
<CFSET varSR[27] = '#SR27#'>
<CFSET varSR[28] = '#SR28#'>
<CFSET varSR[29] = '#SR29#'>
<CFSET varSR[30] = '#SR30#'>
<CFSET varSR[31] = '#SR31#'>
<CFSET varSR[32] = '#SR32#'>
<CFSET varSR[33] = '#SR33#'>
<CFSET varSR[34] = '#SR34#'>
<CFSET varSR[35] = '#SR35#'>
<cfif Check.Year eq 2010 AND Check.Month gte 9 OR Check.Year gte 2011>
<CFSET varSR[36] = '#SR36#'>
<CFSET varSR[37] = '#SR37#'>
</cfif>

<cfif Check.Year gte 2019>

<CFSET varSR[39]= '#SR39#'>
<CFSET varSR[40] = '#SR40#'>
<CFSET varSR[41] = '#SR41#'>
<CFSET varSR[42] = '#SR42#'>

<CFSET varSR[38] = '#SR38#'>
<CFSET varSR[43] = '#SR43#'>
<CFSET varSR[44] = '#SR44#'>
<CFSET varSR[45] = '#SR45#'>

</CFIF>

</cfoutput>

<style type="text/css">
	tr.shade:nth-child(even) {background: #FFF}
	tr.shade:nth-child(odd) {background: #EEE}
</style>

<b>Nonconformances</b><br>

	<cfif check.Year GT 2023>
		<cfset NCTitle = "Number of Nonconformances (NCRs)">
		<cfset PATitle = "Number of Preventive Actions">
		<cfset RefTitle = "Auditor's Reference Number(s)*">
	<cfelseif check.Year is 2023 AND check.Month GTE 5>
		<cfset NCTitle = "Number of Nonconformances (NCRs)">
		<cfset PATitle = "Number of Preventive Actions">
		<cfset RefTitle = "Auditor's Reference Number(s)*">
	<cfelseif check.Year is 2023 AND check.Month LT 5>
		<cfset NCTitle = "Number of Nonconformances">
		<cfset PATitle = "Number of Observations">
		<cfset RefTitle = "CAR/Audit Nonconformance Number(s)*">
	<cfelse>
		<cfset NCTitle = "Number of Nonconformances">
		<cfset PATitle = "Number of Observations">
		<cfset RefTitle = "CAR/Audit Nonconformance Number(s)*">
	</cfif>

<cfoutput>
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/KB.cfm?ID=57" target="_blank">View</a> Matrix of Standard Categories for Non-Conformances and Audit Coverage since Janaury 1, 2019 <Br><br>
<a href="#IQARootDir#matrix.cfm" target="_blank">View</a> Matrix of Standard Categories for Non-Conformances and Audit Coverage (<u>before 2019</u>)<Br><br>

<u>Note</u>: The Matrix of Standard Categories is a compilation of relevant International Standards used in internal audits. Each Standard Clause is grouped with the headings seen in the table below to provide a simplified and comprehensive overview of the audit. Please view the above linked Matrix to view the Categories, and associated Standards and Clauses.<br>
</cfoutput>
<table border="1" width="700" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<tr>
<th>Key Processes / Standard Categories</th>
<th align="center"><cfoutput>#NCTitle#</cfoutput></th>
<th align="center"><cfoutput>#PATitle#</cfoutput></th>
<th align="Center"><cfoutput>#RefTitle#</cfoutput></th>
<cfif Audit.Year gte 2010>
	<th align="Center">SR Number(s)*</th>
</cfif>
</tr>

<Cfif Audit.year gte 2019> 
<CFoutput query="Clauses">
<CFSET i=#ID#>
	<tr>
	<td>#Title#</td>
	<td>#var[i][3][3]# </td>
<td>#VAR2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
<Td>#VARSR[i]#</td>
</tr>
</CFoutput>
<Cfelse>
<!--- year of audit is 2007 --->
<cfif Audit.Year is 2007>
<!--- 9/2007 till 12/2007 --->
	<cfif Audit.Month gte 9>
		<CFloop index="i" from="1" to="22">
			<cfoutput query="view1" group="ID">
<tr class="shade">
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
		</CFloop>
<!--- 1/2007 to 9/2007 --->
	<cfelse>
		<CFloop index="i" from="1" to="16">
			<cfoutput query="view1" group="ID">
<tr class="shade">
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
		</CFloop>
		<!--- this covers the other field --->
			<cfoutput query="view1" group="ID">
<tr class="shade">
<td class="blog-content" valign="top">#var[23][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[38][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[38]#</td>
<Td class="blog-content" align="center">#replace(var[38][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
	</cfif>
<!--- before 2007 --->
<cfelseif Audit.Year lt 2007>
	<CFloop index="i" from="1" to="16">
		<cfoutput query="view1" group="ID">
<tr class="shade">
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
		</cfoutput>
	</cfloop>
		<!--- this covers the other field --->
			<cfoutput query="view1" group="ID">
<tr class="shade">
<td class="blog-content" valign="top">#var[23][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[38][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[38]#</td>
<Td class="blog-content" align="center">#replace(var[38][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
<!--- 1/2008 through 9/2008 --->
<cfelseif Audit.Year eq 2008>
	<cfif Audit.Month lte 9>
		<CFloop index="i" from="1" to="22">
			<cfoutput query="view1" group="ID">
<tr class="shade">
<td class="blog-content" valign="top">#var[i][1][1]#</td>
<td class="blog-content" valign="top" align="center">#var[i][3][3]#</td>
<td class="blog-content" valign="top" align="center">#var2[i]#</td>
<Td class="blog-content" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
		</CFloop>
<!--- 10/2008 through 12/2008 --->
	<cfelseif Audit.Month gte 10>
		<CFloop index="i" from="1" to="34">
			<cfoutput query="view1" group="ID">
<!--- other is excluded --->
<tr class="shade">
<td valign="top">#varnew[i][1][1]#</td>
<td valign="top" align="center">#var[i][3][3]#</td>
<td valign="top" align="center">#var2[i]#</td>
<Td align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
</tr>
			</cfoutput>
		</CFloop>
	</cfif>
<cfelseif Audit.Year gte 2009>

<cfif Audit.Year eq 2009>
	<cfset maxRow = 34>
<cfelseif Audit.Year eq 2010>
	<cfif Audit.Month lt 9>
		<cfset maxRow = 35>
	<cfelseif Audit.Month gte 9>
		<cfset maxRow = 37>
	</cfif>
<cfelseif Audit.Year gte 2010>
	<cfset maxRow = 37>
</cfif>

	<CFloop index="i" from="1" to="#maxRow#">
		<cfoutput query="view1" group="ID">
<!--- other is excluded --->
<tr class="shade">
<td valign="top">#varnew[i][1][1]#</td>
<td valign="top" align="center">#var[i][3][3]#</td>
<td valign="top" align="center">#var2[i]#</td>
<td valign="top" align="center">#replace(var[i][2][2], ",", "<br>", "All")#</td>
<cfif Audit.Year gte 2010>
	<td valign="top" align="center">#replace(varSR[i], ",", "<br>", "All")#</td>
</cfif>
</tr>
		</cfoutput>
	</CFloop>
<!--- end --->
</cfif>
</Cfif>
</table><br>

<cfoutput query="View" group="ID">
<b>Positive Observations</b><br>
<cfset Dump = #replace(BestPrac, "<p>", "", "All")#>
<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>

<cfif BestPrac is NOT "">
	#Dump2#
<cfelse>
	None Listed
	<br /><br />
</cfif>
</cfoutput>

<!--- PDE --->

<b><u>Verified CARs</u></b><br><br>

<cfset var2=ArrayNew(2)>

<cfoutput query="View2">
<CFSET var2[1][1] = #VCAR1#>
<CFSET var2[2][1] = #VCAR2#>
<CFSET var2[3][1] = #VCAR3#>
<CFSET var2[4][1] = #VCAR4#>
<CFSET var2[5][1] = #VCAR5#>
<CFSET var2[6][1] = #VCAR6#>
<CFSET var2[7][1] = #VCAR7#>
<CFSET var2[8][1] = #VCAR8#>
<CFSET var2[9][1] = #VCAR9#>
<CFSET var2[10][1] = #VCAR10#>
<CFSET var2[11][1] = #VCAR11#>
<CFSET var2[12][1] = #VCAR12#>
<CFSET var2[13][1] = #VCAR13#>
<CFSET var2[14][1] = #VCAR14#>
<CFSET var2[15][1] = #VCAR15#>
<CFSET var2[16][1] = #VCAR16#>
<CFSET var2[17][1] = #VCAR17#>
<CFSET var2[18][1] = #VCAR18#>
<CFSET var2[19][1] = #VCAR19#>
<CFSET var2[20][1] = #VCAR20#>

<CFSET var2[1][2] = #Comments1#>
<CFSET var2[2][2] = #Comments2#>
<CFSET var2[3][2] = #Comments3#>
<CFSET var2[4][2] = #Comments4#>
<CFSET var2[5][2] = #Comments5#>
<CFSET var2[6][2] = #Comments6#>
<CFSET var2[7][2] = #Comments7#>
<CFSET var2[8][2] = #Comments8#>
<CFSET var2[9][2] = #Comments9#>
<CFSET var2[10][2] = #Comments10#>
<CFSET var2[11][2] = #Comments11#>
<CFSET var2[12][2] = #Comments12#>
<CFSET var2[13][2] = #Comments13#>
<CFSET var2[14][2] = #Comments14#>
<CFSET var2[15][2] = #Comments15#>
<CFSET var2[16][2] = #Comments16#>
<CFSET var2[17][2] = #Comments17#>
<CFSET var2[18][2] = #Comments18#>
<CFSET var2[19][2] = #Comments19#>
<CFSET var2[20][2] = #Comments20#>
</cfoutput>

<table border="1" width="700" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
	<tr class="shade">
		<th width="30%">CAR/Audit Nonconformance Number</td>
		<th width="70%">Verification Comments</td>
	</tr>

	<cfset count = 0>

	<cfloop index="i" to="20" from="1">
		<cfoutput query="View2">
			<cfif var2[i][1] is 0>
				<cfset count = count + 1>
				<cfif i is 20 and count is 20>
					<tr class="shade">
						<td valign="top">There are no records</td>
						<td valign="top">&nbsp;</td>
					</tr>
				</cfif>
			<cfelse>
				<tr class="shade">
					<td valign="top">#var2[i][1]#</td>
					<td valign="top">#var2[i][2]#</td>
				</tr>
			</cfif>
		</cfoutput>
	</cfloop>
</table>

<!--- added for November 2017 audits and forward - implemented on 11/20/2017 --->
	<cfif check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 73 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 71 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 74 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 166
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 159 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 383 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 200 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 81 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 82 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 80 
		OR check.Year eq 2017 AND check.Month GTE 11 AND check.ID eq 135
		OR check.Year eq 2017 AND check.Month EQ 12
		OR check.Year GTE 2019>
		
		<br>
		<b>CARs that could not be verified during the audit</b> (added: November 20, 2017)<br>				
		CARs listed below in the 'Closed Awaiting Verification' state meet the following criteria:<br>
			 :: CARs closed too recently to verify during the audit<br>
			 :: CARs where there was not enough evidence to determine the effectiveness (small sample size, no samples, etc)<br><br>

		<cfoutput query="View2">
			<cfif len(CARsNotVerified)>
				CARs: #CARsNotVerified#
			<cfelse>
				CARs: None
			</cfif><br><br>
		</cfoutput>

		Additionally, if applicable, details are added to these CARs in the "Verification Evidence" field to explain the reason the verification could not be conducted.<br>
	</cfif>
<!--- /// --->
	
<cfif View.Desk eq "Yes" AND View.AuditType2 eq "Global Function/Process"
	OR View.AuditType2 eq "Program" AND View.AuditArea eq "Scheme Documentation Audit"
	OR View.AuditType2 eq "Scheme" AND View.AuditArea eq "Scheme Documentation Audit">
	<!--- this section is not done for these types of audits --->
<cfelse>
	<cfif View.Year LTE 2014>
		<!--- 'old' style effectiveness for Global (non-desk) and Local Function audits --->
		<br><b><u>Effectiveness</u></b><br>

		<SCRIPT LANGUAGE="JavaScript">
		<!-- Begin
		function popUp(URL) {
		day = new Date();
		id = day.getTime();
		eval("page" + id + " = window.open(URL, '" + id + "', 'toolbar=0,scrollbars=0,location=0,statusbar=0,menubar=0,resizable=0,width=300,height=450,left = 490,top = 412');");
		}
		// End -->
		</script>

		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View3">
		SELECT Report3.*, Report3.Year_ AS "Year"
		FROM REPORT3
		WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
		AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
		AND AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
		</cfquery>

		<cfoutput query="View3" group="ID">
		<br>
		<u>Document Control implementation effective?</u><br>
		<A HREF="javascript:popUp('help.cfm?ID=1')">[View Effectiveness Criteria]</A>
		<br>
		<b>#DC#</b><br>
		Comments: #DCComments#
		<br><br>

		<u>Management Review implementation effective?</u><br>
		<A HREF="javascript:popUp('help.cfm?ID=2')">[View Effectiveness Criteria]</A>
		<br>
		<b>#MR#</b><br>
		Comments: #MRComments#
		<br><br>

		<u>Corrective Action implementation effective?</u><br>
		<A HREF="javascript:popUp('help.cfm?ID=3')">[View Effectiveness Criteria]</A>
		<br>
		<b>#CA#</b><br>
		Comments: #CAComments#
		<br><br>

		<u>Records implementation effective?</u><br>
		<A HREF="javascript:popUp('help.cfm?ID=4')">[View Effectiveness Criteria]</A>
		<br>
		<b>#RE#</b><br>
		Comments: #REComments#
		<br><br>

		<u>Internal Audits implementation effective?</u><br>
		<A HREF="javascript:popUp('help.cfm?ID=5')">[View Effectiveness Criteria]</A>
		<br>
		<b>#IA#</b><br>
		Comments: #IAComments#
		<br><br>

		<!--- added 2/4/2009 --->
		<u>Does the Site have access to files and records via the UL Network?</u><br>
		<A HREF="javascript:popUp('help.cfm?ID=7')">[View Effectiveness Criteria]</A>
		<br>
		<b>#Net#</b><br>
		Comments: #NetComments#
		<br><br>

		<!--- removed 3/1/2009
		<u>External Calibration included in Audit?</u><br>
		<A HREF="javascript:popUp('help.cfm?ID=8')">[View Effectiveness Criteria]</A>
		<br>
		<b>#Cal#</b><br>
		Comments: #CalComments#
		<br><br>
		--->
		<!--- // --->
		</cfoutput>
	<cfelseif View.Year GT 2014>
		<cfif View.AuditType2 eq "Program" AND View.AuditArea neq "Scheme Documentation Audit"
			OR View.AuditType2 eq "Local Function" AND View.AuditArea eq "Certification Body (CB) Audit">
			<!--- new program report --->

			<cfoutput>
			<br><b><u>Certification Body / Program Report Card - Effectiveness</u></b><br>
			:: <a href="#IQADir#Report3_ReportCard_viewCriteria.cfm" target="_blank">View Effectiveness Criteria</a><br>
			:: <a href="#IQADir#ReportCardGraph.cfm?ID=#URL.ID#&Year=#URL.Year#" target="_blank">View Report Card Graph</a><br><br>
			</cfoutput>

			<CFQUERY BLOCKFACTOR="100" name="outputOfReportData" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			SELECT
				ProgramReportCard_Report3.Rating, ProgramReportCard_Report3.Comments, ProgramReportCard_Areas.AreaName, ProgramReportCard_Report3.CriteriaType, ProgramReportCard_Areas.ID as AreaID
			FROM
				ProgramReportCard_Report3, ProgramReportCard_Areas
			WHERE
				ProgramReportCard_Areas.ID = ProgramReportCard_Report3.AreaID
				AND ProgramReportCard_Report3.ID = #URL.ID#
				AND ProgramReportCard_Report3.Year_ = #URL.Year#
			ORDER BY
				ProgramReportCard_Areas.ID, ProgramReportCard_Report3.CriteriaType
			</cfquery>

			<cfset AreaHolder = "">

			<cfoutput query="outputOfReportData">
				<cfif AreaHolder IS NOT AreaName>
				<cfIf AreaHolder is NOT ""></cfif>
				<b><u>#AreaName#</u></b><br>
				</cfif>

			<b>#CriteriaType#</b><br>
			<u>Rating</u>: #Rating#<br>
			<u>Coments</u>: #Comments#<br>

			<CFQUERY BLOCKFACTOR="100" name="getCriteria" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
			select CriteriaText
			from ProgramReportCard_Criteria
			where AreaID = #AreaID#
			and criteriaType = '#criteriaType#'
			and Rating = #Rating#
			</cfquery>

			<u>Criteria:</u> #getCriteria.CriteriaText#<br><br>

			<cfset AreaHolder = AreaName>
			</cfoutput>

		<cfelseif View.AuditType2 eq "Local Function" AND View.AuditArea neq "Certification Body (CB) Audit"
			OR View.AuditType2 eq "Global Function/Process" AND View.Desk eq "No">
			<!--- old, redesigned effectiveness criteria --->

			<!--- 'old' style effectiveness for Global (non-desk) and Local Function audits --->
			<br><b><u>Effectiveness</u></b><br>

			<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="View3">
			SELECT Report3.*, Report3.Year_ AS "Year"
			FROM REPORT3
			WHERE ID = <cfqueryparam value="#URL.ID#" cfsqltype="cf_sql_integer">
			AND Year_ = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
			AND AuditedBy = <cfqueryparam value="#URL.AuditedBy#" cfsqltype="CF_SQL_VARCHAR">
			</cfquery>

			<cfoutput query="View3" group="ID">
			<table border="1" width="800 style="font-family: verdana, arial, sans-serif; font-size: 11px;"">
			<tr>
				<th align="center" valign="top" width="100">Effectiveness Area</th>
				<th align="center" valign="top" width="200">Determination</th>
				<th align="center" valign="top" width="350">Criteria</th>
			</tr>
			<tr valign="top" class="shade">
				<td>Document Control Implementation</td>
				<td>
					<b>#DC#</b><br>
					Comments: #DCComments#
				</td>
				<td>
<!--- DC --->
<u>Evaluation</u>: If a Document Control Process is not providing the availability of current, approved, and accessible documents it is deemed
ineffective.<br><br>

<u>Effectiveness</u>: To verify effectiveness, sample documents to see if they are accessible by those who need them to accomplish work, that
the documents are current based on a controlled master list, no obsolete documents are being used, and the documents have been approved for use.<br>
<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate complete
implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the
necessary evidence to demonstrate effective implementation.  This is also used in situations where evidence is not available or provided for mature
processes. Typically, a nonconformance is written in these situations.
				</td>
			</tr>
			<tr valign="top" class="shade">
				<td>Management Review Implementation</td>
				<td>
					<b>#MR#</b><br>
					Comments: #MRComments#
				</td>
				<td>
<!--- MR --->
<u>Evaluation</u>: If the Management Review Process does not adequately address the minimum requirements of the standard (ISO 17025, 17065, etc.)
and internal requirements it is deemed ineffective.<br><br>

<u>Effectiveness</u>: Based on the organizational level that the review is conducted, verify that decisions/actions from the review are deployed,
tracked and completed in the expected timeframe. Verify that any unresolvable issues are elevated to higher levels within the organization.
Conclusion of Management Review indicates effectiveness status of management system and all inputs/outputs were adequately addressed.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate complete
implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the necessary
evidence to demonstrate effective implementation.  This is also used in situations where evidence is not available or provided for mature processes.
Typically, a nonconformance is written in these situations.
				</td>
			</tr>
			<tr valign="top" class="shade">
				<td>Corrective Action Implementation</td>
				<td>
					<b>#CA#</b><br>
					Comments: #CAComments#
				</td>
				<td>
<u>Evaluation</u>: If the previously identified issues continue to occur, Corrective Action implementation is not effective.<Br><br>

<u>Effectiveness</u>: To verify effectiveness, sample recent CARs to see if action was effectively implemented in the expected timeframe.
After evaluating a sample of Corrective Actions records, if the same problem and/or root cause has not occurred the process is deemed effective.
Additionally, if problems are identified internally or externally, and action is being taken to resolve them the process is deemed effective.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate
complete implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate
the necessary evidence to demonstrate effective implementation. This is also used in situations where evidence is not available or provided for mature
processes. Typically, a nonconformance is written in these situations.
				</td>
			</tr>
			<tr valign="top" class="shade">
				<td>Records Implementation</td>
				<td>
					<b>#RE#</b><br>
					Comments: #REComments#
				</td>
				<td>
<u>Evaluation</u>: If the Records Control Process is not supporting the traceability, accuracy, maintenance, and accessibility of records it is
deemed ineffective.<br><br>

<u>Effectiveness</u>: Verify that a sample of records exist as a result of processes audited. Records must be complete and accurate, legible,
maintained as required (retention time and storage), traceable to the activity/process that generated them; protected from loss or damage.
Electronically stored records shall require a backup/security process.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate
complete implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to
accumulate the necessary evidence to demonstrate effective implementation.  This is also used in situations where evidence is not available or
provided for mature processes. Typically, a nonconformance is written in these situations.
				</td>
			</tr>
			<tr valign="top" class="shade">
				<td>Internal Audit Implementation</td>
				<td>
					<b>#IA#</b><br>
					Comments: #IAComments#
				</td>
				<td>
<!--- IA --->
<u>Evaluation</u>: If the Internal Audit Process is not identifying the local and/or systemic weaknesses in the quality management system it is
deemed ineffective.<br><br>

<u>Effectiveness</u>: To verify effectiveness, sample recent internal audits/plans to assure all elements/areas of the QMS were audited.
Compare internal nonconformances with the nonconformances identified in external audits.  The process is deemed effective if external audits are not uncovering
recurring quality management system compliance issues.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate complete
implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the
necessary evidence to demonstrate effective implementation. This is also used in situations where evidence is not available or provided for mature
processes. Typically, a nonconformance is written in these situations.
				</td>
			</tr>
			<tr valign="top" class="shade">
				<td>Access to Files and Records via the UL Network</td>
				<td>
					<b>#Net#</b><br>
					Comments: #NetComments#
				</td>
				<td>
<u>Evaluation</u>: This function is effective if staff physically located at a site demonstrate that they have access to original files or records.<br><br>

<u>Effectiveness</u>: Verify that staff at the site being audited have access to the UL Network via transmission of email correspondence or actual
witnessing staff accessing files or records. Files/records can be documents via the Document Control System, access into ePro, DMS. eComm, Lotus Notes
email, CAR Database, etc.<br><br>

<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published, however, evidence is not available to demonstrate complete
implementation. Typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the necessary
evidence to demonstrate implementation. Also used in situations where evidence is not available or provided for mature processes. Typically, a
nonconformance is written in these situations.
				</td>
			</tr>
			</table>
			</cfoutput>
		</cfif>
	</cfif>
</cfif>

<br><b><u>Audit Coverage</u></b><br>
<cfoutput query="View">Audit Area - #Area#</cfoutput>
<br><br>

<cfoutput>
<a href="#IQARootDir#matrix.cfm" target="_blank">View</a> Matrix of Standard Categories for Non-Conformances and Audit Coverage (<u>Update - July 2013</u>)<Br><br>
<a href="#request.serverProtocol##request.serverDomain#/departments/snk5212/IQA/KB.cfm?ID=57" target="_blank">View</a> Matrix of Standard Categories for Non-Conformances and Audit Coverage since Janaury 1, 2019 <Br><br>
</cfoutput>

<u>Note</u>: The Matrix of Standard Categories is a compilation of relevant International Standards used in internal audits. Each Standard Clause is grouped with the headings seen in the table below to provide a simplified and comprehensive overview of the audit. Please view the above linked Matrix to view the Categories, and associated Standards and Clauses.<br><br>

<cfif Check.Year eq 2009>
	<cfquery name="Clauses" Datasource="Corporate">
	SELECT * FROM Clauses_2009Jan1
	ORDER BY ID
	</cfquery>

	<cfset maxRow = 35>
<cfelseif Check.Year eq 2010>
	<cfif Check.Month lt 9>
		<cfquery name="Clauses" Datasource="Corporate">
		SELECT * FROM Clauses_2009Jan1
		ORDER BY ID
		</cfquery>

		<cfset maxRow = 35>
	<cfelseif Check.Month gte 9>
		<cfquery name="Clauses" Datasource="Corporate">
		SELECT * FROM Clauses_2010SEPT1
		ORDER BY ID
		</cfquery>

		<cfset maxRow = 37>
	</cfif>
<cfelseif Check.Year gte 2011>
	<cfif Audit.year lt 2019>

		<CFQUERY BLOCKFACTOR="100" Datasource="Corporate" NAME="clauses">
		SELECT * FROM Clauses_2010SEPT1
		ORDER BY ID
		</CFQUERY>
		<cfset maxRow = 37>
	<cfelse>

		<CFQUERY BLOCKFACTOR="100" Datasource="UL06046" NAME="clauses">
		SELECT * FROM Clauses_2018May17
		ORDER BY ID
		<cfset maxRow = 45>
		</CFQUERY>
	</cfif>

<cfelse>
	<cfquery name="Clauses" Datasource="Corporate">
	SELECT * FROM Clauses
	ORDER BY ID
	</cfquery>

	<cfset maxRow = 34>
</cfif>

<Table width="700" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<tr>
<td>

<Table border="1" width="620" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<cfoutput>
<tr>
	<th>&nbsp;</th>
</tr>
</cfoutput>
<cfoutput query="Clauses" startrow="1" maxrows="#maxRow#">
<tr class="shade">
<td>
#title#
</td>
</tr>
</cfoutput>

</table>

</td>
<td>
	<cfif Audit.Year lt 2009>
<Table border="1" width="80" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<tr><th><b><cfoutput>#url.year#-#url.id#</cfoutput></b></th></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "A035" OR col is "A036" OR col is "A037" OR col is "Area" or col is "comments" or col is "Year_" or col is "ID" or col is "OfficeName" or col is "auditedby" or col is "Placeholder">
<cfelse>
 <cfoutput query="Output">
<tr class="shade">
	<td align=center>
  <cfif output[col][1] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--<br>
  </cfif>
</td>
</tr>
 </cfoutput>
</cfif>
</cFLOOP>
</TABLE>
	<cfelseif Audit.Year eq 2009 OR Audit.Year eq 2010 AND Audit.Month lt 9>
<Table border="1" width="80" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<tr><td><b><cfoutput>#url.year#-#url.id#</cfoutput></b></td></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "A036" or col is "A037" or col is "Area" or col is "comments" or col is "Year_" or col is "ID" or col is "OfficeName" or col is "auditedby" or col is "Placeholder">
<cfelse>
 <cfoutput query="Output">
<tr class="shade">
	<td align=center>
  <cfif output[col][1] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--<br>
  </cfif>
</td></tr>
 </cfoutput>
</cfif>
</cFLOOP>
</TABLE>
	<cfelseif Audit.Year eq 2010 AND Audit.Month gte 9 OR Audit.Year gte 2011>
<CFIF Audit.Year LT 2019>
<Table border="1" width="80" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<tr><th><b><cfoutput>#url.year#-#url.id#</cfoutput></b></th></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year_" or col is "ID" or col is "OfficeName" or col is "auditedby" or col is "Placeholder" or col is "A038" or Col is "A039" or col is "A040" or Col is "A041" or Col is "A042" or Col is "A043" or Col is "A044" or col is "A045">
<cfelse>
 <cfoutput query="Output">
<tr class="shade">
	<td align=center>
  <cfif output[col][1] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--<br>
  </cfif>
</td></tr>
 </cfoutput>
</cfif>
</cFLOOP>
</TABLE>
<CFELSE> 

<Table border="1" width="80" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<tr><th><b><cfoutput>#url.year#-#url.id#</cfoutput></b></th></tr>
<cfloop list="#output.ColumnList#" index="col">
<cfif col is "Area" or col is "comments" or col is "Year_" or col is "ID" or col is "OfficeName" or col is "auditedby" or col is "Placeholder">
<cfelse>
 <cfoutput query="Output">
<tr class="shade">
	<td align=center>
  <cfif output[col][1] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--<br>
  </cfif>
</td></tr>
 </cfoutput>
</cfif>
</cFLOOP>
</TABLE>
</CFIF>
	</cfif>

</td>
</tr>
</TABLE><br />

<cfoutput query="Output">
<b>Audit Coverage Comments</b><br />
<cfif Comments IS NOT "">
	<cfset Dump = #replace(Comments, "<p>", "", "All")#>
	<cfset Dump2 = #replace(Dump, "</p>", "<br><br>", "All")#>
	#Dump2#
<cfelse>
	None Listed
	<br /><br />
</cfif>
</cfoutput>



<cfif Check.AuditType2 is "Field Services" or Check.AuditType2 is "Local Function FS">
<cfif view.year lt 2008 OR view.year eq 2008 AND view.month lt 10>
<br><b><u>Audit Coverage - Field Services</u></b><br>

<cfquery name="Clauses" Datasource="Corporate">
SELECT * FROM  A17020  "17020" ORDER BY ID
</cfquery>

<Table width="700" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<tr>
<td>

<Table border="1" width="600" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<tr><td>&nbsp;</td></tr>
<cfoutput query="Clauses">
<tr><td>
	#Clause#
</td></tr>
</cfoutput>

</table>

</td>
<td>
<Table border="1" width="100" style="border-collapse: collapse;" style="font-family: verdana, arial, sans-serif; font-size: 11px;">
<tr><th><b><cfoutput>#url.year#-#url.id#</cfoutput></b></th></tr>
<cfloop list="#outputfs.ColumnList#" index="col">
<cfif col is "comments" or col is "Year_" or col is "ID" or col is "Placeholder" or col is "AuditedBy">
<cfelse>
 <cfoutput query="outputfs">
<tr><td align=center>
  <cfif outputfs[col][1] IS "1">
  	<a href="auditdetails.cfm?year=#year#&id=#id#">#year#-#id#</a>
	<cfelse>
	--
  </cfif>
</td></tr>
 </cfoutput>
</cfif>
</cFLOOP>
</TABLE>

</td>
</tr>
</TABLE>
</cfif>
</cfif>

<cfelseif Check.RecordCount eq 1 AND View1.RecordCount eq 0>
	<cfoutput>
	<!--- If the audit report does not exist --->
	<br>
	Audit Report #URL.Year#-#URL.ID#-#URL.AuditedBy# has not been published.<br><br>
	:: <a href="AuditDetails.cfm?#CGI.Query_String#">Audit Details</a>
	</cfoutput>
<cfelseif Check.RecordCount eq 0>
	<cfoutput>
	<!--- If the audit report does not exist --->
	<br>
	Audit #URL.Year#-#URL.ID#-#URL.AuditedBy# does not exist.
	</cfoutput>
</cfif>

<!---
<cfif View.Year GTE 2015>
	<cfif View.Desk eq "No" AND View.AuditType2 eq "Global Function/Process"
		OR View.AuditType2 eq "Program" AND View.AuditArea neq "Scheme Documentation Audit"
		OR View.AuditType2 eq "Local Function" AND View.AuditArea neq "Certification Body (CB) Audit">

<hr>
<br><Br>
<b>Effectiveness Criteriafor 2015+ Certification Body Audits and non-17065 Program Audits</b><br><br>

		<!--- DC --->
		<u>Criteria for Document Control Implementation</u><br>
		<u>Evaluation</u>: If a Document Control Process is not providing the availability of current, approved, and accessible documents it is deemed
		ineffective.<br><br>

		<u>Effectiveness</u>: To verify effectiveness, sample documents to see if they are accessible by those who need them to accomplish work, that
		the documents are current based on a controlled master list, no obsolete documents are being used, and the documents have been approved for use.<br>
		<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate complete
		implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the
		necessary evidence to demonstrate effective implementation.  This is also used in situations where evidence is not available or provided for mature
		processes. Typically, a nonconformance is written in these situations.<br><br>

		<hr><br><br>

		<!--- MR --->
		<u>Criteria for Management Review Implementation</u><br>
		<u>Evaluation</u>: If the Management Review Process does not adequately address the minimum requirements of the standard (ISO 17025, 17065, etc.)
		and internal requirements it is deemed ineffective.<br><br>

		<u>Effectiveness</u>: Based on the organizational level that the review is conducted, verify that decisions/actions from the review are deployed,
		tracked and completed in the expected timeframe. Verify that any unresolvable issues are elevated to higher levels within the organization.
		Conclusion of Management Review indicates effectiveness status of management system and all inputs/outputs were adequately addressed.<br><br>

		<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate complete
		implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the necessary
		evidence to demonstrate effective implementation.  This is also used in situations where evidence is not available or provided for mature processes.
		Typically, a nonconformance is written in these situations.<br><br>

		<hr><br><br>

		<!--- CA --->
		<u>Criteria for Corrective Action Implementation</u><br>
		<u>Evaluation</u>: If the previously identified issues continue to occur, Corrective Action implementation is not effective.<Br><br>

		<u>Effectiveness</u>: To verify effectiveness, sample recent CARs to see if action was effectively implemented in the expected timeframe.
		After evaluating a sample of Corrective Actions records, if the same problem and/or root cause has not occurred the process is deemed effective.
		Additionally, if problems are identified internally or externally, and action is being taken to resolve them the process is deemed effective.<br><br>

		<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate
		complete implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate
		the necessary evidence to demonstrate effective implementation. This is also used in situations where evidence is not available or provided for mature
		processes. Typically, a nonconformance is written in these situations.<br><br>

		<hr><br><br>

		<!--- Records --->
		<u>Criteria for Records Implementation</u><br>
		<u>Evaluation</u>: If the Records Control Process is not supporting the traceability, accuracy, maintenance, and accessibility of records it is
		deemed ineffective.<br><br>

		<u>Effectiveness</u>: Verify that a sample of records exist as a result of processes audited. Records must be complete and accurate, legible,
		maintained as required (retention time and storage), traceable to the activity/process that generated them; protected from loss or damage.
		Electronically stored records shall require a backup/security process.<br><br>

		<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate
		complete implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to
		accumulate the necessary evidence to demonstrate effective implementation.  This is also used in situations where evidence is not available or
		provided for mature processes. Typically, a nonconformance is written in these situations.<br><br>

		<hr><br><br>

		<!--- IA --->
		<u>Criteria for Internal Audit Implementation</u><br>
		<u>Evaluation</u>: If the Internal Audit Process is not identifying the local and/or systemic weaknesses in the quality management system it is
		deemed ineffective.<br><br>

		<u>Effectiveness</u>: To verify effectiveness, sample recent internal audits/plans to assure all elements/areas of the QMS were audited.
		Compare internal nonconformances with the nonconformances identified in external audits.  The process is deemed effective if external audits are not uncovering
		recurring quality management system compliance issues.<br><br>

		<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published; however, evidence is not available to demonstrate complete
		implementation. This is typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the
		necessary evidence to demonstrate effective implementation. This is also used in situations where evidence is not available or provided for mature
		processes. Typically, a nonconformance is written in these situations.<br><br>

		<hr><br><br>

		<u>Criteria for Access to Files and Records via the UL Network</u><br>
		<u>Evaluation</u>: This function is effective if staff physically located at a site demonstrate that they have access to original files or records.<br><br>

		<u>Effectiveness</u>: Verify that staff at the site being audited have access to the UL Network via transmission of email correspondence or actual
		witnessing staff accessing files or records. Files/records can be documents via the Document Control System, access into ePro, DMS. eComm, Lotus Notes
		email, CAR Database, etc.<br><br>

		<u>Cannot Determine Effectiveness Definition</u>: Requirements are approved and published, however, evidence is not available to demonstrate complete
		implementation. Typically used in situations where newly introduced or changed processes have not operated long enough to accumulate the necessary
		evidence to demonstrate implementation. Also used in situations where evidence is not available or provided for mature processes. Typically, a
		nonconformance is written in these situations.<br><br>
	</cfif>
</cfif>
--->

<cfif cgi.SCRIPT_NAME is "#IQARootDir#qReport_Output_All.cfm">
</td>
</tr>
</table>
</div>
</cfif>