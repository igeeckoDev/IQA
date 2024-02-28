<CFOUTPUT query="Approve"> 
     <CFIF (Int(Approve.CurrentRow)-1) mod 4 is 0 and Int(Approve.CurrentRow) is not 1> 
     </tr><tr> 
     </CFIF>
     <td class="sched-content" width="25%">
	 
<b>#Year#-#ID#</b><br> 
<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
#OfficeName#<br>
<cfelse>
#ExternalLocation#<br></cfif>
						
<cfif Trim(LeadAuditor) is "" or Trim(LeadAuditor) is "- None -">
#Auditor#<br>
<cfelseif Trim(Auditor) is "" or Trim(Auditor) is "- None -">
#LeadAuditor#, Lead<br>
<CFELSE>
#LeadAuditor#, Lead<br>
#Auditor#<br>
</cfif>

#AuditType#<br>

<cfset CompareDate = Compare(StartDate, EndDate)>
						
<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">No dates scheduled<br>
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#<br>
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#<br>
	</cfif>
</cfif>

<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>

Status - 
<cfif trim(year) gt CurYear>

<cfif Trim(Status) is NOT "deleted">
<img src="../images/yellow.jpg" border="0">
<cfelse>
<img src="../images/black.jpg" border="0">
</cfif>

<cfelseif trim(year) is CurYear>

<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "deleted">
<img src="../images/green.jpg" border="0">
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted">
	<cfif Trim(Month) is CurMonth>
		<cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
			<cfif Trim(StartDate) lt CurDate>
				<cfif Trim(AuditType) is "Technical Assessment">
					<img src="../images/green.jpg" border="0">
				<cfelse>
					<img src="../images/blue.jpg" border="0">
				</cfif>
			<cfelse>
				<img src="../images/yellow.jpg" border="0">
			</cfif>
		<cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">
			<img src="../images/yellow.jpg" border="0">
		<cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
			<cfif Trim(EndDate) lt CurDate or Trim(StartDate) lt CurDate>
				<cfif Trim(AuditType) is "Technical Assessment">
					<img src="../images/green.jpg" border="0">
				<cfelse>
					<img src="../images/blue.jpg" border="0">
				</cfif>
			<cfelseif Trim(EndDate) gte CurDate or Trim(StartDate) gte CurDate>
				<img src="../images/yellow.jpg" border="0">
			<cfelse>
			</cfif>
		<cfelse>
		</cfif>	
	<cfelseif CurMonth gt Trim(Month)>
		<cfif Trim(AuditType) is "Technical Assessment">
			<img src="../images/green.jpg" border="0">
		<cfelse>
			<img src="../images/blue.jpg" border="0">
		</cfif>
	<cfelse>
		<img src="../images/yellow.jpg" border="0">
	</cfif>
<cfelse>
<img src="../images/black.jpg" border="0">
</cfif>

<cfelse>

<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "deleted" and Trim(AuditType) is NOT "Technical Assessment">
<img src="../images/green.jpg" border="0">
<cfelseif Trim(AuditType) is "Technical Assessment">
<img src="../images/green.jpg" border="0">
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "deleted" and Trim(AuditType) is NOT "Technical Assessment">
<img src="../images/blue.jpg" border="0">
<cfelse>
<img src="../images/black.jpg" border="0">
</cfif>

</cfif>

<br>
Reference Documents - #RD#<br>
KeyProcesses - #KP#<br>
Notes - #Notes#<br>
<b>Month Scheduled</b>
<cfif Trim(Month) is 1>
<br>January
<cfelseif Trim(Month) is 2>
<br>February
<cfelseif Trim(Month) is 3>
<br>March
<cfelseif Trim(Month) is 4>
<br>April
<cfelseif Trim(Month) is 5>
<br>May
<cfelseif Trim(Month) is 6>
<br>June
<cfelseif Trim(Month) is 7>
<br>July
<cfelseif Trim(Month) is 8>
<br>August
<cfelseif Trim(Month) is 9>
<br>September
<cfelseif Trim(Month) is 10>
<br>October
<cfelseif Trim(Month) is 11>
<br>November
<cfelseif Trim(Month) is 12>
<br>December
<cfelse>
<br>No month scheduled.
</cfif>
<br>
			
<br>			
<br>

<A href="approve.cfm?ID=#ID#&Year=#Year#">Approve</A> these changes.

</td>
</CFOUTPUT>