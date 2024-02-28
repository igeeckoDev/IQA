<div id="#id#" class="transparent">
<div style="background-color: A6A6A6">
<b>Audit Details - #Year#-#ID#</b></div>
<div>
<cfif audittype is "TPTDP">
#externallocation#
<cfelse>
#OfficeName#
</cfif><br>

<cfset CompareDate = Compare(StartDate, EndDate)>
<cfset Start = #StartDate#>
<cfset End = #EndDate#>
<cfset Start1 = DateFormat(Start, 'mm')>
<cfset End1 = DateFormat(End, 'mm')>

<cfif Trim(StartDate) is "" AND Trim(EndDate) is "">
#MonthAsString(Month)#, #Year#<br>
<cfelseif Trim(StartDate) is NOT "" AND Trim(EndDate) is "">
#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelseif CompareDate eq 0>
#DateFormat(Start, 'mmmm dd, yyyy')#<br>
<cfelse>
<cfif End1 eq Start1>
#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'dd, yyyy')#<br>
<cfelse>
#DateFormat(Start, 'mmmm dd')# - #DateFormat(End, 'mmmm dd, yyyy')#<br>
</cfif>
</cfif>

#auditType#
<cfif auditedby is "AS"><br>AS Contact - #ASContact#
<cfelseif audittype is NOT "TPTDP" and auditedby is NOT "AS">, #AuditType2#<br>
#Auditarea#
</cfif><br>								
Lead - #LeadAuditor#<br>
</div>
</div>	