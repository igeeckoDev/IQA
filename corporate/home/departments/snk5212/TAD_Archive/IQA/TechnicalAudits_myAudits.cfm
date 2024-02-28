<!--- Start of Page File --->
<cfset subTitle = "Internal Technical Audits - View My Audits">
<cfinclude template="#SiteDir#SiteShared/StartOfPage.cfm">

<cfif isDefined("Form.EmpNo")>
    <!--- check if there is a form.empNo and if the person/email has a role in this audit --->
    <CFQUERY NAME="qEmpLookup" datasource="OracleNet">
    SELECT employee_email
    FROM ULCUS.UL_HR_EMPLOYEE_GTD_VIEW 
    WHERE employee_number = '#Form.EmpNo#'
    </CFQUERY>

    <cfquery Datasource="UL06046" name="Audits" username="#OracleDB_Username#" password="#OracleDB_Password#"> 
    SELECT 
        UL06046.TechnicalAudits_AuditSchedule.*, UL06046.TechnicalAudits_AuditSchedule.AuditorEmail as AuditorEmail, UL06046.TechnicalAudits_AuditSchedule.AuditorManagerEmail as AuditorManagerEmail, UL06046.TechnicalAudits_AuditSchedule.EngManagerEmail as EngManagerEmail, UL06046.TechnicalAudits_AuditSchedule.EngManagerDirectorEmail as EngManagerDirectorEmail, Corporate.IQAtblOffices.TechnicalAudits_SQM as SQM, UL06046.TechnicalAudits_AuditSchedule.AppealResponseEmail as AppealResponseEmail, UL06046.TechnicalAudits_AuditSchedule.AppealDecisionEmail as AppealDecisionEmail, UL06046.TechnicalAudits_AuditSchedule.NCEnteredAssignEmail as NCEnteredAssignEmail, UL06046.TechnicalAudits_AuditSchedule.ROM as ROM, UL06046.TechnicalAudits_AuditSchedule.TAM as TAM
    FROM 
        UL06046.TechnicalAudits_AuditSchedule, Corporate.IQAtblOffices
    WHERE 
    	(ROM = '#qEmpLookup.employee_email#' 
        OR TAM = '#qEmpLookup.employee_email#' 
        OR NCEnteredAssignEmail = '#qEmpLookup.employee_email#' 
        OR AppealDecisionEmail = '#qEmpLookup.employee_email#' 
        OR EngManagerDirectorEmail = '#qEmpLookup.employee_email#'
        OR EngManagerEmail = '#qEmpLookup.employee_email#'
        OR AuditorManagerEmail = '#qEmpLookup.employee_email#'
        OR AuditorEmail = '#qEmpLookup.employee_email#')
        
        AND UL06046.TechnicalAudits_AuditSchedule.AuditType2 = '#URL.Type#'
        AND UL06046.TechnicalAudits_AuditSchedule.Year_ = #URL.Year#
        AND UL06046.TechnicalAudits_AuditSchedule.STATUS IS NULL
        AND UL06046.TechnicalAudits_AuditSchedule.OfficeName = Corporate.IQAtblOffices.OfficeName
        AND <cfif URL.Type eq "In-Process">
                <cfif URL.Unit eq 1>
                    UL06046.TechnicalAudits_AuditSchedule.MONTH BETWEEN 1 AND 3
                    <cfset Quarter = 1>
                <cfelseif URL.Unit eq 2>
                    UL06046.TechnicalAudits_AuditSchedule.MONTH BETWEEN 4 AND 6
                    <cfset Quarter = 2>
                <cfelseif URL.Unit eq 3>
                    UL06046.TechnicalAudits_AuditSchedule.MONTH BETWEEN 7 AND 9
                    <cfset Quarter = 3>
                <cfelseif URL.Unit eq 4>
                    UL06046.TechnicalAudits_AuditSchedule.MONTH BETWEEN 10 AND 12
                    <cfset Quarter = 4>
                </cfif>
            <Cfelse>
                UL06046.TechnicalAudits_AuditSchedule.Month = #URL.Unit#
            </cfif>
    ORDER 
        BY UL06046.TechnicalAudits_AuditSchedule.Year_, UL06046.TechnicalAudits_AuditSchedule.Month, UL06046.TechnicalAudits_AuditSchedule.ID
    </CFQUERY>

<cfif URL.Type eq "Full">
	<cfset Unit = "Quarter">
    <cfset UnitMax = "4">
    <cfset showQuarter = URL.Unit>
<cfelseif URL.Type eq "In-Process">
	<cfset Unit = "Quarter">
	<cfset UnitMax = "12">
    <cfset showQuarter = Quarter>
</cfif>

<cfoutput>
Employee Email: <b>#qEmpLookup.employee_email#</b><br>
Currently Viewing: <b>#url.Year# / #Unit# #showQuarter#</b><br />
Audit Type: <b>#URL.Type#</b> Technical Audits<br />
Switch Audit Type: 
	<cfif url.Type eq "Full">
        [Full] [<A href="TechnicalAudits_getRole_viewAudits.cfm?Year=#URL.Year#&Type=In-Process&Unit=#URL.Unit#&page=TechnicalAudits_myAudits">In-Process</A>]
    <cfelseif url.Type eq "In-Process">
        [<A href="TechnicalAudits_getRole_viewAudits.cfm?Year=#URL.Year#&Type=Full&Unit=#URL.Unit#&page=TechnicalAudits_myAudits">Full</A>] [In-Process]
    <cfelse>
        [<A href="TechnicalAudits_getRole_viewAudits.cfm?Year=#URL.Year#&Type=Full&Unit=#URL.Unit#&page=TechnicalAudits_myAudits">Full</A>] [<A href="TechnicalAudits_getRole_viewAudits.cfm?Year=#URL.Year#&Type=In-Process&page=TechnicalAudits_myAudits">In-Process</A>]
    </cfif><br /><br />
    
Select Year:<br>
<SELECT NAME="YearJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
		<option value="javascript:document.location.reload();">Select Year Below
		<option value="javascript:document.location.reload();">
<cfloop index="i" to="2015" from="2011">
		<OPTION VALUE="TechnicalAudits_getRole_viewAudits.cfm?type=#URL.TYPE#&year=#i#&unit=#url.unit#&page=TechnicalAudits_myAudits">#i#
</cfloop>
</SELECT><br /><br />

Select Quarter:<br />
<SELECT NAME="UnitJump" ONCHANGE="location = this.options[this.selectedIndex].value;">
	<option value="javascript:document.location.reload();">Select Quarter Below
	<option value="javascript:document.location.reload();">
	<cfloop index="i" to="4" from="1">
		<OPTION VALUE="TechnicalAudits_getRole_viewAudits.cfm?type=#URL.TYPE#&year=#i#&unit=#i#&page=TechnicalAudits_myAudits">#i#
	</cfloop>
</SELECT><br /><br />
</cfoutput>

<cfset YearHolder = "">
<cfset MonthHolder = "">
<cfset AuditID = "">

<table border="1" width="850">
<tr>
	<th width="180">Audit Number</th>
    <th>Current State</th>
	<th>Audit Planning</th>
    <th>Assign Auditors</th>
    <th>Audit Completion</th>
    <th>Audit Review</th>
    <th>NCs?</th>
    <th>Eng Manager Review</th>
    <th>Appeals Exist?</th>
    <th>Appeal Response</th>
    <th>Appeal Decision</th>
    <th>Appeals Remain?</th>
    <th>NC and SR/CAR Input</th>
    <th>Corrective Action Status</th>
    <th>Verification</th>
    <th width="75">Role</th>
</tr>
<cfoutput query="Audits">
	<cfif Audits.currentRow MOD 10 eq 0>
	<tr>
        <th width="180">Audit Number</th>
        <th>Current State</th>
        <th>Audit Planning</th>
        <th>Assign Auditors</th>
        <th>Audit Completion</th>
        <th>Audit Review</th>
        <th>NCs?</th>
        <th>Eng Manager Review</th>
        <th>Appeals Exist?</th>
        <th>Appeal Response</th>
        <th>Appeal Decision</th>
        <th>Appeals Remain?</th>
        <th>NC and SR/CAR Input</th>
        <th>Corrective Action Status</th>
        <th>Verification</th>
        <th width="75">Role</th>
	</tr>
	</cfif>

<cfif URL.Type eq "Full">
	<cfset showMonth = "Quarter #Month#">
	<cfset columnLabel = "Quarter">
<cfelseif URL.Type eq "In-Process">
	<cfset showMonth = "#MonthAsString(Month)#">
    <cfset columnLabel = "Month">
</cfif>

<cfif NOT len(YearHolder) OR YearHolder eq Year_>
    <cfif NOT len(MonthHolder) OR MonthHolder NEQ Month>
    <tr valign="top">
        <td colspan="16">
            <b>#showMonth#</b>
        </td>
    </tr>
    </cfif>
</cfif>

<tr valign="top">

<cfif URL.Type eq "Full">
	<cfset showMonth = "Quarter #Month#">
<cfelseif URL.Type eq "In Process">
	<cfset showMonth = "#MonthAsString(Month)#">
</cfif>

<!--- build audit identifier --->
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

	<cfset ReviewLoc = #right(ProjectHandlerDept, 3)#>

    <cfset AuditID = "#ReviewLoc#-#ProjectNumber#-#CCN#-#AuditorLoc#-#AuditTypeID##RequestTypeID#">
</cfif>

<td>
    <cfif len(AuditID)>
        <a href="TechnicalAudits_getRole.cfm?ID=#ID#&Year=#Year_#&page=TechnicalAudits_AuditDetails">#AuditID#</a>
    <cfelse>
        <a href="TechnicalAudits_getRole.cfm?ID=#ID#&Year=#Year_#&page=TechnicalAudits_AuditDetails">#year_#-#ID#</a>
    </cfif> 
</td>

<!--- current step / status --->
<td>
<cfif Flag_CurrentStep CONTAINS "Audit Completed and Closed">
	<b>#Flag_CurrentStep#</b>
<cfelse>
	#Flag_CurrentStep#<br /><br />
    <cfif AuditClosed eq "Yes" AND AuditClosedConfirm eq "No">
	    <font class="warning"><b>Audit Ready to be Closed</b></font>
    </cfif>
</cfif>
</td>

<!--- Audit Planning --->
<td>
<cfif Approved EQ "Yes">
	Completed
    <cfset nextStep = "Yes">
<cfelse>
	<font class="warning">Incomplete</font>
    <cfset nextStep = "No">
</cfif>
</td>

<!--- Assign Auditors --->
<td>
<cfif nextStep eq "Yes">
	<cfif AuditorAssigned EQ "Yes">
        <cfif len(AuditorAssignmentLetterDate)>
            Auditor Assignment Letter Sent<br />
            #dateformat(AuditorAssignmentLetterDate, "mm/dd/yyyy")#<br />
            <cfset nextStep = "Yes">
        <cfelse>
            Auditor Assigned - <font class="warning">Assignment Letter Not Sent</font>
            <cfset nextStep = "No">
        </cfif>
    <cfelse>
        <font class="warning">Auditor Not Assigned</font>
        <cfset nextStep = "No">
    </cfif>
<cfelse>
	--
    <cfset nextStep = "No">
</cfif>
</td>

<!--- Audit Completion --->
<td>
<cfif nextStep eq "Yes">
	<cfif ReportPosted EQ "Yes">
    	Completed<br />
        #dateformat(ReportPostedDate, "mm/dd/yyyy")#
		<cfset nextStep = "Yes">
    
		<Cfif NCExist eq "No">
    		<br /><br />No Non-Conformances Found
	        
			<cfset nextStep = "No">
        </Cfif>
	<cfelse>
    	<cfif len(AuditDueDate)>
			<cfif AuditDueDate LT CurDate>
            	<font class="warning">Overdue</font> (#dateformat(AuditDueDate, "mm/dd/yyyy")#)
            <cfelseif AuditDueDate EQ CurDate>
            	<font class="warning">Due Today</font>
            <cfelseif AuditDueDate GT CurDate>
            	Scheduled (#dateformat(AuditDueDate, "mm/dd/yyyy")#)
            </cfif>
            
            <cfset nextStep = "No">
		<cfelse>
        	 <font class="warning">Audit Due Date Not Set</font>
             <cfset nextStep = "No">
        </cfif>
    </cfif>
<cfelse>
    --
    <cfset nextStep = "No">
</cfif>
</td>

<!--- Audit Review --->
<td>
<cfif nextStep eq "Yes">
	<cfif NCReview EQ "Yes">
    	NC Review Completed<br />
        #dateformat(NCReviewDate, "mm/dd/yyyy")#
        <cfset nextStep = "Yes">
    <cfelse>
		<cfif NCReviewDueDate LT CurDate>
            <font class="warning">Overdue</font> (#dateformat(NCReviewDueDate, "mm/dd/yyyy")#)
        <cfelseif NCReviewDueDate EQ CurDate>
            <font class="warning">Due Today</font>
        <cfelseif NCReviewDueDate GT CurDate>
            Scheduled (#dateformat(NCReviewDueDate, "mm/dd/yyyy")#)
        </cfif>
        
        <cfset nextStep = "No">
    </cfif>
<cfelse>
    --
    <cfset nextStep = "No">
</cfif>
</td>

<!--- NCs? --->
<td>
<cfif nextStep eq "Yes">
	<Cfif NCExist eq "Yes">
        Yes
        <cfset nextStep = "Yes">
    <cfelse>
        No
        <cfset nextStep = "No">
    </Cfif>
<cfelse>
	--
    <cfset nextStep = "No">
</cfif>
</td>

<!--- Eng Manager Review --->
<td>
<cfif nextStep eq "Yes">
	<cfif EngManagerReview EQ "Yes">
    	Complete<br />
        #dateformat(EngManagerReviewDate, "mm/dd/yyyy")#
        <cfset nextStep = "Yes">
    <cfelse>
    	<cfif EngManagerAssign EQ "Yes">
        	Review Assigned - 
			<cfif EngManagerDueDate LT CurDate>
                <font class="warning">Overdue</font> (#dateformat(EngManagerDueDate, "mm/dd/yyyy")#)
            <cfelseif EngManagerDueDate EQ CurDate>
                <font class="warning">Due Today</font>
            <cfelseif EngManagerDueDate GT CurDate>
                Scheduled (#dateformat(EngManagerDueDate, "mm/dd/yyyy")#)
            </cfif>
        
	        <cfset nextStep = "No">
        <cfelse>
        	<font class="warning">Not Assigned</font>
            <cfset nextStep = "No">
        </cfif>
    </cfif>
<cfelse>
    --
    <cfset nextStep = "No">
</cfif>
</td>

<!--- Appeals Exist? --->
<td>
<cfif nextStep eq "Yes">
	<cfif AppealExist EQ "Yes">
        Yes
        <cfset nextStep = "Yes">
    <cfelse>
        No
        <cfset nextStep = "No">
    </cfif>
<cfelse>
	--
    <cfset nextStep = "No">
</cfif>
</td>

<!--- Appeal Response --->
<td>
<cfif nextStep eq "Yes">
	<cfif AppealResponse EQ "Yes">
    	Complete<br />
        #dateformat(AppealResponseDate, "mm/dd/yyyy")#
        <cfset nextStep = "Yes">
    <cfelse>
    	<cfif AppealResponseAssign EQ "Yes">
        	Appeal Response Assigned to #AppealResponseEmail# - 
			<cfif AppealResponseDueDate LT CurDate>
                <font class="warning">Overdue</font> (#dateformat(AppealResponseDueDate, "mm/dd/yyyy")#)
            <cfelseif AppealResponseDueDate EQ CurDate>
                <font class="warning">Due Today</font>
            <cfelseif AppealResponseDueDate GT CurDate>
                Scheduled (#dateformat(AppealResponseDueDate, "mm/dd/yyyy")#)
            </cfif>
        
	        <cfset nextStep = "No">
        <cfelse>
        	<font class="warning">Not Assigned</font>
            <cfset nextStep = "No">
        </cfif>
    </cfif>
<cfelse>
    --
    <cfset nextStep = "No">
</cfif>
</td>

<!--- Appeal Decision --->
<td>
<cfif nextStep eq "Yes">
	<cfif AppealDecision EQ "Yes">
    	Complete<br />
        #dateformat(AppealDecisionDate, "mm/dd/yyyy")#
        <cfset nextStep = "Yes">
    <cfelse>
    	<cfif AppealDecisionAssign EQ "Yes">
        	Appeal Decision Assigned to #AppealDecisionEmail# - 
			<cfif AppealDecisionDueDate LT CurDate>
                <font class="warning">Overdue</font> (#dateformat(AppealDecisionDueDate, "mm/dd/yyyy")#)
            <cfelseif AppealDecisionDueDate EQ CurDate>
                <font class="warning">Due Today</font>
            <cfelseif AppealDecisionDueDate GT CurDate>
                Scheduled (#dateformat(AppealDecisionDueDate, "mm/dd/yyyy")#)
            </cfif>
        
	        <cfset nextStep = "No">
        <cfelse>
        	<font class="warning">Not Assigned</font>
            <cfset nextStep = "No">
        </cfif>
    </cfif>
<cfelse>
    --
    <cfset nextStep = "No">
</cfif>
</td>

<!--- Appeals Remain? --->
<td>
<cfif nextStep eq "Yes">
	<cfif NCExistPostAppeal eq "Yes">
        Yes
        <cfset nextStep = "Yes">
    <cfelse>
        No
        <cfset nextStep = "No">
    </cfif>
<cfelse>
	--
    <cfset nextStep = "No">
</cfif>
</td>

<!--- NC, SR/CAR Input --->
<td>
<cfif nextStep eq "Yes">
	<cfif NCEntered EQ "Yes">
    	NC and SR/CAR Input Complete<br />
        #dateformat(NCEnteredDate, "mm/dd/yyyy")#
        <cfset nextStep = "Yes">
    <cfelse>
    	<cfif NCEnteredAssign EQ "Yes">
        	Non-Conformance Input Assigned to #NCEnteredAssignEmail# - 
			<cfif NCEnteredAssignDueDate LT CurDate>
                <font class="warning">Overdue</font> (#dateformat(NCEnteredAssignDueDate, "mm/dd/yyyy")#)
            <cfelseif NCEnteredAssignDueDate EQ CurDate>
                <font class="warning">Due Today</font>
            <cfelseif NCEnteredAssignDueDate GT CurDate>
                Scheduled (#dateformat(NCEnteredAssignDueDate, "mm/dd/yyyy")#)
            </cfif>
        
	        <cfset nextStep = "No">
        <cfelse>
        	<font class="warning">Not Assigned</font>
            <cfset nextStep = "No">
        </cfif>
    </cfif>
<cfelse>
    --
    <cfset nextStep = "No">
</cfif>

<cfif AuditType2 eq "In-Process">
	<cfset nextStep = "No">
</cfif>
</td>

<!--- Corrective Action Status --->
<td>
<cfif nextStep eq "Yes">
	<!--- Query SRCAR Table --->
    <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * FROM TechnicalAudits_SRCAR
    WHERE AuditID = #ID#
    AND AuditYear = #Year#
    </CFQUERY>
    
	<cfif SRCAR.SRCARClosed EQ "Yes">
        Confirmed Closed<br />
        #dateformat(SRCAR.SRCARClosedDate, "mm/dd/yyyy")#
    <cfelse>
		<cfif SRCAR.SRCARClosedDueDate LT CurDate>
            <font class="warning">Overdue</font> (#dateformat(SRCAR.SRCARClosedDueDate, "mm/dd/yyyy")#)
        <cfelseif SRCAR.SRCARClosedDueDate EQ CurDate>
            <font class="warning">Due Today</font>
        <cfelseif SRCAR.SRCARClosedDueDate GT CurDate>
            Scheduled (#dateformat(SRCAR.SRCARClosedDueDate, "mm/dd/yyyy")#)
        </cfif>
    
        <cfset nextStep = "No">
    </cfif>
<cfelse>
    --
    <cfset nextStep = "No">
</cfif>
</td>

<!--- Verification --->
<td>
<cfif nextStep eq "Yes">
	<!--- Query SRCAR Table --->
    <CFQUERY NAME="SRCAR" Datasource="UL06046" username="#OracleDB_Username#" password="#OracleDB_Password#">
    SELECT * FROM TechnicalAudits_SRCAR
    WHERE AuditID = #ID#
    AND AuditYear = #Year#
    </CFQUERY>

	<cfif SRCAR.SRCARVerified EQ "Yes">
        Verified<br />
        #dateformat(SRCAR.SRCARVerifiedDate, "mm/dd/yyyy")#
    <cfelse>
		<cfif SRCAR.SRCARVerifiedDueDate LT CurDate>
            <font class="warning">Overdue</font> (#dateformat(SRCAR.SRCARVerifiedDueDate, "mm/dd/yyyy")#)
        <cfelseif SRCAR.SRCARVerifiedDueDate EQ CurDate>
            <font class="warning">Due Today</font>
        <cfelseif SRCAR.SRCARVerifiedDueDate GT CurDate>
            Scheduled (#dateformat(SRCAR.SRCARVerifiedDueDate, "mm/dd/yyyy")#)
        </cfif>
    
        <cfset nextStep = "No">
    </cfif>
<cfelse>
    --
    <cfset nextStep = "No">
</cfif>
</td>

<!---
<td>On-Track<br>Escalated</td>
<td align="center">X</td>
<td>TBD<br>Done<br>Missing Target Date</td>
<td>TBD<br>Done<br>Missing Target Date<br>In Compliance</td>
<td>TBD<br>Done<br>Missing Target Date<br>N/A</td>
<td>TBD<br>Done<br>Missing Target Date<br>N/A</td>
<td>TBD<br>Done<br>Pending</td>
--->

<td>
<Cfif ROM eq qEmpLookup.employee_email>
	:: ROM<br>
</Cfif>
<cfif TAM eq qEmpLookup.employee_email>
	:: TAM<br>
</cfif>
<cfif NCEnteredAssignEmail eq qEmpLookup.employee_email>
	:: Non-Conformance Input<br>
</cfif>
<cfif AppealDecisionEmail eq qEmpLookup.employee_email>
	:: Appeal Decision<br>
</cfif>
<cfif AppealResponseEmail eq qEmpLookup.employee_email>
	:: Appeal Response<br>
</cfif>
<cfif EngManagerDirectorEmail eq qEmpLookup.employee_email>
	:: Eng Manager's Director<br>
</cfif>
<cfif EngManagerEmail eq qEmpLookup.employee_email>
	:: Eng Manager<br>
</cfif>
<cfif AuditorManagerEmail eq qEmpLookup.employee_email>
	:: Auditor's Manager<br>
</cfif>
<cfif AuditorEmail eq qEmpLookup.employee_email>
	:: Auditor<br>
</cfif>
</td>

<cfset YearHolder = Year_>
<cfset MonthHolder = Month>
<cfset AuditID = "">
</tr>

</cfoutput>
</table>

<cfelse>
	<cfoutput>
		Page Load Error - <a href="TechnicalAudits_getRole_myAudits.cfm?#CGI.Query_String#">Try Again</a><br><br>
	</cfoutput>
</cfif>

<!--- Footer, End of Page HTML --->
<cfinclude template="#SiteDir#SiteShared/EndOfPage.cfm">
<!--- /// --->