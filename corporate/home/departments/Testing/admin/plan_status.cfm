<cfif Trim(RescheduleNextYear) is "Yes">
	<img src="../images/red2.jpg" border="0">
<cfelseif Trim(FollowUp) is "Notes">
	<img src="../images/orange2.jpg" border="0">
<cfelse>
<!--- audit is in future year --->
<cfif trim(year) gt CurYear>
<!--- if not deleted, yellow --->
	<cfif Trim(Status) is NOT "deleted">
	<img src="../images/yellow2.jpg" border="0">
	<cfelseif Trim(Status) is "deleted" OR Trim(Status) is "removed">
	<img src="../images/black2.jpg" border="0">
	</cfif>
<!--- audit is in current year --->
<cfelseif trim(year) is CurYear>
<!--- NOT deleted and report field not blank --->
<cfif Trim(Report) is NOT "" AND Trim(Status) is NOT "deleted" AND Trim(Status) is NOT "removed">
	<!--- report in process --->
	<cfif Trim(Report) is "Entered" or Trim(Report) is "1" or Trim(Report) is "2" or Trim(Report) is "3" or Trim(Report) is "4" or Trim(Report) is "5">
	<img src="../images/blue2.jpg" border="0">
	<!--- report completed --->
	<cfelseif Trim(Report) is "Completed">
	<img src="../images/green2.jpg" border="0">
	</cfif>
<!--- NOT deleted and report field blank --->	
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted" AND Trim(Status) is NOT "removed">
	<!--- current month --->
	<cfif Trim(Month) is CurMonth>
		<!--- only start date listed ---->
		<cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
			<!--- startdate less than current date - audit already began --->
			<cfif Trim(StartDate) lt CurDate>
				<!--- currently there are no reports for TA, so its considered done after the audit is finished--->
				<cfif Trim(AuditType) is "Technical Assessment">
					<img src="../images/green2.jpg" border="0">
				<!--- other audits require a report, so they are blue until then --->
				<cfelse>
					<img src="../images/blue2.jpg" border="0">
				</cfif>
			<!--- no report and the start date is gte current date --->
			<cfelse>
				<img src="../images/yellow2.jpg" border="0">
			</cfif>
		<!--- dates are blank --->	
		<cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">
			<img src="../images/yellow2.jpg" border="0">
		<!--- both dates entered --->
		<cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
			<!--- audit is in process or over --->
			<cfif Trim(EndDate) lt CurDate or Trim(StartDate) lt CurDate>
				<cfif Trim(AuditType) is "Technical Assessment">
					<!--- no reports for TA right now --->
					<img src="../images/green2.jpg" border="0">
					<!--- report required --->
				<cfelse>
					<img src="../images/blue2.jpg" border="0">
				</cfif>
			<!--- audit has not happened yet --->
			<cfelseif Trim(EndDate) gte CurDate or Trim(StartDate) gte CurDate>
				<img src="../images/yellow2.jpg" border="0">
			<cfelse>
			</cfif>
		<cfelse>
		</cfif>	
	<!--- 	audit in a past month --->
	<cfelseif CurMonth gt Trim(Month)>
		<!--- TA is over when audit date passes --->
		<cfif Trim(AuditType) is "Technical Assessment">
			<img src="../images/green2.jpg" border="0">
		<!--- no report still --->
		<cfelse>
			<img src="../images/blue2.jpg" border="0">
		</cfif>
	<!--- audit is in the future --->	
	<cfelse>
		<img src="../images/yellow2.jpg" border="0">
	</cfif>
<!--- is status is deleted --->
<cfelse>
<img src="../images/black2.jpg" border="0">
</cfif>

<!--- audit from past years. 2004 and 2005 had PDF reports ONLY --->
<cfelseif year is "2004" or year is "2005">

<cfif Trim(Status) is "Deleted" OR Trim(Status) is "removed">
	<img src="../images/black2.jpg" border="0">
<cfelseif Trim(AuditType) is "Technical Assessment">
	<img src="../images/green2.jpg" border="0">
<cfelseif Trim(Report) is NOT "">
	<img src="../images/green2.jpg" border="0">
<cfelseif Trim(Report) is "">
	<img src="../images/blue2.jpg" border="0">
</cfif>

<!--- years in the past that are gt 2005 --->
<cfelse>

<cfif Trim(Status) is "Deleted" OR Trim(Status) is "removed">
	<img src="../images/black2.jpg" border="0">
<cfelseif Trim(AuditType) is "Technical Assessment">
	<img src="../images/green2.jpg" border="0">
<cfelseif Trim(Report) is "Completed">
	<img src="../images/green2.jpg" border="0">
<cfelseif Trim(Report) is NOT "Completed">
	<img src="../images/blue2.jpg" border="0">
</cfif>

</cfif>
</cfif>