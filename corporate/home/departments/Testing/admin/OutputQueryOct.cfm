<CFOUTPUT query="Blah">

	<CFIF Blah.IsFirst()>
<td colspan="4" class="sched-title">
<a name="#i#"></a>
<div align="center" class="blog-title">#MonthAsString(Month)# #Year# 
<!---
 - <a href="Print_month.cfm?Month=#i#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">Print</a>
--->
</div>
</td>
</tr>
<tr>
	</cfif>

    <CFIF (Int(Blah.CurrentRow)-1) mod 4 is 0 and NOT Blah.IsFirst()> 
    </tr><tr> 
    </CFIF>
    <td class="sched-content" width="25%" valign="top" align="left">
	 
<b>#Year#-#ID#-#AuditedBy#</b><br> 
<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
#OfficeName#<cfif Trim(AuditArea) is ""><cfelse> - #AuditArea#</cfif><br>
<cfelse>
#ExternalLocation#<br></cfif>
						
<cfif Trim(LeadAuditor) is "" or Trim(LeadAuditor) is "- None -">
	<cfif Trim(Auditor) is "" or Trim(Auditor) is "- None -">
	No Auditors Listed<br>
	<cfelse>
	#Auditor#<br>
	</cfif>
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
						
<cfif Trim(Status) is "Deleted">
Cancelled<br>
<cfelseif Trim(RescheduleNextYear) is "Yes">
<cfset NextYear = #URL.Year# +1>
Rescheduled for #NextYear#

<cfelse>						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "" >No dates scheduled<br>

<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0>#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelse>
	<cfif End1 eq Start1>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#<br>
	<cfelse>
	#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#<br>
	</cfif>
</cfif>

</cfif>

<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>

<cfif Trim(RescheduleNextYear) is "Yes">
<cfelse>
Status - 
<cfif trim(year) gt CurYear>

<cfif Trim(Status) is NOT "Deleted">
<img src="../images/yellow.jpg" border="0">
<cfelse>
<img src="../images/black.jpg" border="0">
</cfif>

<cfelseif trim(year) is CurYear>

<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "Deleted">
<img src="../images/green.jpg" border="0">
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "Deleted">
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
			<cfif Trim(Status) is "Deleted">
			<img src="../images/black.jpg" border="0">			
			<cfelse>
			<img src="../images/green.jpg" border="0">			
			</cfif>
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

<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "Deleted" and Trim(AuditType) is NOT "Technical Assessment">
<img src="../images/green.jpg" border="0">
<cfelseif Trim(AuditType) is "Technical Assessment">
	<cfif Trim(Status) is "Deleted">
	<img src="../images/black.jpg" border="0">			
	<cfelse>
	<img src="../images/green.jpg" border="0">			
	</cfif>
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "Deleted" and Trim(AuditType) is NOT "Technical Assessment">

<cfelse>
<img src="../images/black.jpg" border="0">
</cfif>

</cfif>
</cfif>

<br>
<cfif Trim(RescheduleStatus) is "rescheduled">
Rescheduled - <img src="../images/red.jpg" border="0">
<CFELSE>
</CFIF>

<br><br>
						
<a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">Audit Details</a><br><br>

<cflock scope="SESSION" timeout="60">
<CFIF SESSION.Auth.accesslevel is "SU" or SESSION.Auth.accesslevel is "Admin" or SESSION.Auth.SubRegion is "#URL.AuditedBy#" or SESSION.Auth.AccessLevel is "#URL.AuditedBy#">

<A href="addreport.cfm?ID=#ID#&Year=#Year#">Add Files</a><br>

<CFIF Trim(Status) is "deleted">
<A href="edit.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">[edit]</a><br>
Audit Cancelled<br>
<cfelseif Trim(Report) is NOT "">
<A href="edit.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">[edit]</a><br>
<cfelse>
<A href="edit.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">[edit]</a><br>
<a href="cancel.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">[cancel]</a><br>
<a href="reschedule.cfm?ID=#ID#&Year=#Year#&AuditedBy=#AuditedBy#">[reschedule]</a><br>
</CFIF>

<CFELSE>

</CFIF>

</cflock>
</td>

<cfif Blah.IsLast()>
	<cfif Int(Blah.CurrentRow) gt 4>
		<cfif (Int(Blah.CurrentRow)-1) mod 4 eq 2>
			<td>&nbsp;</td>
		<cfelseif (Int(Blah.CurrentRow)-1) Mod 4 eq 1>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        <cfelseif (Int(Blah.CurrentRow)-1) Mod 4 eq 0>
        	<td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
		</cfif>
	</cfif>
</cfif>
</CFOUTPUT>