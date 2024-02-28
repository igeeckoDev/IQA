<cfif Trim(RescheduleNextYear) is "Yes">
<!--- added 8/29/2007 --->

<cfelseif Trim(Status) is "Removed">
<b>Status</b><br>
<font color="red">Removed from Audit Schedule (Deleted)</font>
<!--- /// --->

<cfelse>
<b>Status</b><br>
<cfif Trim(FollowUp) is "Notes">
	<img src="../images/orange.jpg" border="0">
<cfelse>
<!--- audit is in future year --->
<cfif trim(year) gt CurYear>
<!--- if not deleted, yellow --->
	<cfif Trim(Status) is NOT "deleted">
		<img src="../images/yellow.jpg" border="0">
	<cfelseif Trim(Status) is "deleted">
		<img src="../images/black.jpg" border="0">
	</cfif>
<!--- audit is in current year --->
<cfelseif trim(year) is CurYear>
<!--- NOT deleted and report field not blank --->
<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "deleted">
	<!--- report in process --->
	<cfif auditedby is "Field Services">
		<img src="../images/green.jpg" border="0">
	<cfelse>
		<cfif Trim(Report) is "Entered" or Trim(Report) is "1" or Trim(Report) is "2" or Trim(Report) is "3" or Trim(Report) is "4" or Trim(Report) is "5">
            <img src="../images/blue.jpg" border="0">
        <!--- report completed --->
        <cfelseif Trim(Report) is "Completed" or Trim(Report) is "#year#-#id#.pdf" or Trim(Report) CONTAINS "#year#-#id#.">
            <img src="../images/green.jpg" border="0">
        </cfif>
	</cfif>
<!--- NOT deleted and report field blank --->	
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted">
	<!--- current month --->
	<cfif Trim(Month) is CurMonth>
		<!--- only start date listed ---->
		<cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
			<!--- startdate less than current date - audit already began --->
			<cfif Trim(StartDate) lt CurDate>
				<!--- currently there are no reports for TA, so its considered done after the audit is finished--->
					<img src="../images/blue.jpg" border="0">
			<!--- no report and the start date is gte current date --->
			<cfelse>
				<img src="../images/yellow.jpg" border="0">
			</cfif>
		<!--- dates are blank --->	
		<cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">
			<img src="../images/yellow.jpg" border="0">
		<!--- both dates entered --->
		<cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
			<!--- audit is in process or over --->
			<cfif Trim(EndDate) lt CurDate or Trim(StartDate) lt CurDate>
					<img src="../images/blue.jpg" border="0">
			<!--- audit has not happened yet --->
			<cfelseif Trim(EndDate) gte CurDate or Trim(StartDate) gte CurDate>
				<img src="../images/yellow.jpg" border="0">
			</cfif>
		</cfif>	
	<!---  audit in a past month --->
	<cfelseif CurMonth gt Trim(Month)>
		<!--- TA is over when audit date passes --->
		<img src="../images/blue.jpg" border="0">
	<!--- audit is in the future --->	
	<cfelse>
		<img src="../images/yellow.jpg" border="0">
	</cfif>
<!--- is status is deleted --->
<cfelse>
	<img src="../images/black.jpg" border="0">
</cfif>

<!--- audit from past years. 2004 and 2005 had PDF reports ONLY --->
<cfelseif year is "2004" or year is "2005">
	<cfif Trim(Status) is "Deleted">
	    <img src="../images/black.jpg" border="0">
    <cfelseif Trim(Report) is NOT "">
    	<img src="../images/green.jpg" border="0">
    <cfelseif Trim(Report) is "">
        <cfif Trim(AuditType) is "Technical Assessment">
        	<img src="../images/green.jpg" border="0">
        <cfelse>
        	<img src="../images/blue.jpg" border="0">
        </cfif>
    </cfif>
<!--- years in the past that are gt 2005 --->
<cfelse>
	<cfif Trim(Status) is "Deleted">
	    <img src="../images/black.jpg" border="0">
    <cfelseif Trim(Report) is "Completed">
    	<img src="../images/green.jpg" border="0">
    <cfelseif AuditedBy is "Field Services" AND Report is NOT "">
    	<img src="../images/green.jpg" border="0">
    <cfelseif Trim(Report) is NOT "Completed">
        <cfif Trim(AuditType2) is "Technical Assessment" AND Trim(Report) is NOT "">
        	<img src="../images/green.jpg" border="0">
        <cfelseif Trim(Report) CONTAINS "#year#-#id#.">
        	<img src="../images/green.jpg" border="0">
        <cfelse>
        	<img src="../images/blue.jpg" border="0">
        </cfif>
    </cfif>
</cfif>
</cfif>
</cfif>