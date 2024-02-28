<cfoutput>	
<link href="#Request.CSS#" rel="stylesheet" media="screen">
</cfoutput>

<table border="1" width="650">
<tr>

<CFQUERY BLOCKFACTOR="100" NAME="Blah" DataSource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ AS Year
FROM AuditSchedule
WHERE Month = #URL.Month#
AND Year_ = '#URL.Year#'
AND AuditedBy = '#URL.AuditedBy#'
AND Approved = 'Yes'
ORDER BY ID
</cfquery>

<CFPROCESSINGDIRECTIVE SUPPRESSWHITESPACE="Yes">
<CFOUTPUT query="Blah">

	<CFIF Blah.CurrentRow is 1>
<td colspan="4" class="sched-title">
<div align="center" class="blog-title">#monthasstring(month)# - #URL.YEAR#</div>
</td>
</tr>
<tr>
	</cfif>

    <CFIF (Int(Blah.CurrentRow)-1) mod 4 is 0 and Int(Blah.CurrentRow) is not 1> 
    </tr><tr> 
    </CFIF>
    <td class="sched-content" width="25%" valign="top" align="left">
	
<CFIF AuditedBy is "AS">
<a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#AuditedBy#-#Year#-#ID#</a>
<cfelse>
<a href="AuditDetails.cfm?ID=#ID#&Year=#Year#">#Year#-#ID#-#AuditedBy#</a>
</cfif>	 
<br>

<cfif Trim(AuditedBy) is "AS">
#AuditType# - #OfficeName#<br>
<cfelse>
	<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
	#OfficeName#<br><cfif Trim(AuditArea) is ""><cfelse>#AuditArea#<br></cfif>
	<cfelse>
	#ExternalLocation#<br>
	</cfif>
</cfif>

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

<cfif Status is "Deleted">
<b>Cancelled</b>
<cfelseif RescheduleNextYear is "Yes">
<b><cfset NextYear = #URL.Year# +1>
Rescheduled for #NextYear#</b>
</cfif>

</td>
</CFOUTPUT>
</CFPROCESSINGDIRECTIVE>
</tr></table>