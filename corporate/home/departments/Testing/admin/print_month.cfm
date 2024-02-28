<table border="1" width="650">
<tr>


<CFQUERY BLOCKFACTOR="100" NAME="Blah" DataSource="Corporate"> 
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year from AuditSchedule
WHERE Month = #URL.Month#
AND Year_ = '#URL.Year#'
AND AuditedBy = '#URL.AuditedBy#'
AND Approved = 'Yes'
ORDER BY StartDate, ID
</cfquery>

<CFPROCESSINGDIRECTIVE SUPPRESSWHITESPACE="Yes">
<CFOUTPUT query="Blah">

	<CFIF Blah.CurrentRow is 1>
<td colspan="4" class="sched-title">
<div align="center" class="blog-title"><cfif Month is 1>January<cfelseif Month is 2>February<cfelseif Month is 3>March<cfelseif Month is 4>April<cfelseif Month is 5>May<cfelseif Month is 6>June<cfelseif Month is 7>July<cfelseif Month is 8>August<cfelseif Month is 9>September<cfelseif Month is 10>October<cfelseif Month is 11>November<cfelseif Month is 12>December</cfif> - #URL.YEAR#</div>
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
	<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
	#OfficeName#<br><cfif Trim(AuditArea) is ""><cfelse>#AuditArea#<br></cfif>
	<cfelse>
	#ExternalLocation#<br>
	</cfif>

<cfset CompareDate = Compare(StartDate, EndDate)>
						
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