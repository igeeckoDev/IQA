<CFOUTPUT query="Details">

	<CFIF Details.IsFirst()>
<td colspan="4" class="sched-title">
<a name="#i#"></a>
<div align="center" class="blog-title">
#MonthAsString(Month)# #Year_#
<!---
- <a href="Print_month.cfm?Month=#i#&Year=#URL.Year#&AuditedBy=#URL.AuditedBy#">Print</a>
--->
</div>
</td>
</tr>
<tr>
	</cfif>

    <CFIF (Int(Details.CurrentRow)-1) mod 4 is 0 and NOT Details.IsFirst()>
	</td>
    </tr><tr>
    </CFIF>
    <td class="sched-content" width="25%" valign="top" align="left">

<b>#Year_#-#ID#-#AuditedBy#</b><br>
<cfif Trim(ExternalLocation) is "- None -" or  Trim(ExternalLocation) is "">
#OfficeName#
	<cfif len(Trim(AuditArea))>
		<cfif AuditType2 is "Field Services">
			<cfif url.Year lte 2008>
				 - Field Services
			<cfelse>
				 - #trim(AuditArea)#
			</cfif>
		<cfelse>
			<cfif Year_ GTE 2014>
			 - #Area#
			<cfelse>
			 - #AuditArea#
			</cfif>
		</cfif>
	</cfif>
<cfelse>
#ExternalLocation#
</cfif><br><br>

<cfif auditedby is NOT "Field Services">
	<cfif audittype2 is "Technical Assessment">
	    #AuditType2#<br>
	<cfelse>
    	<cfif AuditedBy NEQ "IQA">
        #AuditType#<br>
        </cfif>
	</cfif>
</cfif>

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

<cfif reschedulenextyear is NOT "Yes">
	<cfif AuditedBy eq "WiSE" AND AuditType NEQ "Accred">
		<cfinclude template="status_colors_LTA2.cfm">
	<cfelseif AuditedBy eq "WiSE" AND AuditType EQ "Accred">
		<cfinclude template="OutputQuery_AS.cfm">
	<cfelse>
		<cfinclude template="status_colors2.cfm">
	</cfif>
</cfif>

<cfif Trim(RescheduleStatus) is "rescheduled">
<br><img src="#IQADir#images/red.jpg" border="0"> (Rescheduled)
</CFIF>

<br><br>

<cfif len(Trim(LeadAuditor))>
<u>Lead</u> - #LeadAuditor#<Br>
</cfif>

<cfif len(Trim(Auditor)) AND Trim(Auditor) NEQ "- None -">
<u>Audit Team</u> - #replace(Auditor, ",", ", ", "All")#<br />
</cfif>

<cfif len(Trim(AuditorInTraining)) AND Trim(AuditorInTraining) NEQ "- None -">
<u>Auditor(s) In Training</u> - #replace(AuditorInTraining, ",", ", ", "All")#<br />
</cfif>

<br>

<a href="AuditDetails.cfm?ID=#ID#&Year=#Year_#">Audit Details</a><br><br>

</td>

<cfif Details.IsLast()>
	<cfif Int(Details.CurrentRow) gt 4>
		<cfif (Int(Details.CurrentRow)-1) mod 4 eq 2>
			<td>&nbsp;</td>
		<cfelseif (Int(Details.CurrentRow)-1) Mod 4 eq 1>
        	<td>&nbsp;</td>
        	<td>&nbsp;</td>
        <cfelseif (Int(Details.CurrentRow)-1) Mod 4 eq 0>
        	<td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
		</cfif>
	</cfif>
</cfif>
</CFOUTPUT>