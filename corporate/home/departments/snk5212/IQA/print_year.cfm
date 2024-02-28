<!--- DV_CORP_002 02-APR-09 --->
<cfloop index="i" From="1" To="12">

<table border="1" width="650">
<tr>


<CFQUERY BLOCKFACTOR="100" NAME="Blah" DataSource="Corporate"> 
<!--- DV_CORP_002 02-APR-09  Change Start--->
<!---TODO_DV_CORP_002_Start: 0339ac60-e17b-4a64-8d31-eff82514812c Variable Datasource name --->
SELECT AuditSchedule.*, AuditSchedule.Year_ as Year from AuditSchedule
WHERE Month = #i#
AND Year_ = '#URL.Year#'
AND AuditedBy = '#URL.AuditedBy#'
AND Approved = 'Yes'
ORDER BY StartDate, ID
<!---TODO_DV_CORP_002_End: 0339ac60-e17b-4a64-8d31-eff82514812c Variable Datasource name --->
<!--- DV_CORP_002 02-APR-09 Change End --->
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
						
<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">No dates scheduled<br>
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is ""><cfset Start = #StartDate#>#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0><cfset Start = #StartDate#>#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif Trim(StartDate) is "" AND Trim(EndDate) is NOT ""><cfset End = #EndDate#>#DateFormat(End, 'mmmm dd, yyyy')#
<br>
<cfelse>
<cfset Start = #StartDate#>#DateFormat(Start, 'mmmm dd')# - <cfset End = #EndDate#>#DateFormat(End, 'dd, yyyy')#<br>
</cfif>	

</td>
</CFOUTPUT>
</CFPROCESSINGDIRECTIVE>
</tr></table>

</cfloop>