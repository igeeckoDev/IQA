<CFOUTPUT query="Blah">

	<CFIF Blah.IsFirst()>
<td colspan="4" class="sched-title">
<a name="#i#"></a>
<div align="center" class="blog-title">
#MonthAsString(Month)# #Year#
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
	#replace(Auditor, ",", "<br />", "All")#<br>
	</cfif>
<cfelseif Trim(Auditor) is "" or Trim(Auditor) is "- None -">
#LeadAuditor#, Lead<br>
<CFELSE>
#LeadAuditor#, Lead<br>
#replace(Auditor, ",", "<br />", "All")#<br>
</cfif>

#AuditType#<br>

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
#DateOutput#
<br />

<cfset CurMonth = #Dateformat(now(), 'mm')#>
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurDate = #Dateformat(now(), 'mm/dd/yyyy')#>

<cfif Trim(RescheduleNextYear) is "Yes">
<cfelse>
Status - 
<cfif trim(year) gt CurYear>

<cfif Trim(Status) is NOT "Deleted">
<img src="images/yellow.jpg" border="0">
<cfelse>
<img src="images/black.jpg" border="0">
</cfif>

<cfelseif trim(year) is CurYear>

<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "Deleted">
<img src="images/green.jpg" border="0">
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "Deleted">
	<cfif Trim(Month) is CurMonth>
		<cfif Trim(EndDate) is "" and Trim(StartDate) is NOT "">
			<cfif Trim(StartDate) lt CurDate>
				<cfif Trim(AuditType) is "Technical Assessment">
					<img src="images/green.jpg" border="0">
				<cfelse>
					<img src="images/blue.jpg" border="0">
				</cfif>
			<cfelse>
				<img src="images/yellow.jpg" border="0">
			</cfif>
		<cfelseif Trim(EndDate) is "" and Trim(StartDate) is "">
			<img src="images/yellow.jpg" border="0">
		<cfelseif Trim(EndDate) is NOT "" and Trim(StartDate) is NOT "">
			<cfif Trim(EndDate) lt CurDate or Trim(StartDate) lt CurDate>
				<cfif Trim(AuditType) is "Technical Assessment">
					<img src="images/green.jpg" border="0">
				<cfelse>
					<img src="images/blue.jpg" border="0">
				</cfif>
			<cfelseif Trim(EndDate) gte CurDate or Trim(StartDate) gte CurDate>
				<img src="images/yellow.jpg" border="0">
			<cfelse>
			</cfif>
		<cfelse>
		</cfif>	
	<cfelseif CurMonth gt Trim(Month)>
		<cfif Trim(AuditType) is "Technical Assessment">
			<cfif Trim(Status) is "Deleted">
			<img src="images/black.jpg" border="0">			
			<cfelse>
			<img src="images/green.jpg" border="0">			
			</cfif>
		<cfelse>
			<img src="images/blue.jpg" border="0">
		</cfif>
	<cfelse>
		<img src="images/yellow.jpg" border="0">
	</cfif>
<cfelse>
<img src="images/black.jpg" border="0">
</cfif>

<cfelse>

<cfif Trim(Report) is NOT "" and Trim(Status) is NOT "Deleted" and Trim(AuditType) is NOT "Technical Assessment">
<img src="images/green.jpg" border="0">
<cfelseif Trim(AuditType) is "Technical Assessment">
	<cfif Trim(Status) is "Deleted">
	<img src="images/black.jpg" border="0">			
	<cfelse>
	<img src="images/green.jpg" border="0">			
	</cfif>
<cfelseif Trim(Report) is "" and Trim(Status) is NOT "Deleted" and Trim(AuditType) is NOT "Technical Assessment">

<cfelse>
<img src="images/black.jpg" border="0">
</cfif>

</cfif>
</cfif>

<br>
<cfif Trim(RescheduleStatus) is "rescheduled">
Reschedule Status - <img src="images/red.jpg" border="0">
<CFELSE>
</CFIF>		

<br><br>
<a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">Audit Details</a>

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