<!--- DV_CORP_002 28-APR-09 Reconcilation 2 --->
<cfset CurYear = #Dateformat(now(), 'yyyy')#>
<cfset CurMonth = #Dateformat(now(), 'mm')#>

<cfif CurMonth is 12>
	<cfset NextMonth = 1>
	<cfset Year = #CurYear# + 1>
<cfelse>
	<cfset NextMonth = #CurMonth# + 1>
	<cfset Year = #CurYear#>
</cfif>

<cfset DayofMonth = #Dateformat(now(), 'dd')#>

<cfif DayofMonth is 01>

<CFQUERY BLOCKFACTOR="100" NAME="SelectAudits" Datasource="Corporate"> 
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change start--->


SELECT AuditSchedule.ID, AuditSchedule.AuditedBy, AuditSchedule.Email, AuditSchedule.AuditArea,"AUDITSCHEDULE".YEAR_ as "Year", AuditSchedule.OfficeName, AuditSchedule.AuditType, AuditSchedule.Month, AuditSchedule.AuditArea, AuditSchedule.Status, AuditSchedule.Approved, IQAtblOffices.RQM, IQAtblOffices.QM, IQAtblOffices.GM, IQAtblOffices.LES, IQAtblOffices.Other, IQAtblOffices.Other2
 FROM AuditSchedule, IQAtblOffices
 WHERE AuditSchedule.Year = <cfqueryparam value="#URL.Year#" cfsqltype="cf_sql_integer">
 AND  AuditSchedule.ID = #URL.ID#
 AND  AuditSchedule.OfficeName = IQAtbloffices.OfficeName
<!--- DV_CORP_002 28-APR-09 Reconcilation 2 Change End--->
</CFQUERY>

<cfmail 
	query="SelectAudits"
	from="Internal.Quality_Audits@ul.com" 
	to="Christopher.j.Nicastro@ul.com"
	subject="Audit Notification - #OfficeName#" 
	Mailerid="Reminder">
This is an email reminder to inform you that #OfficeName# <cfif AuditArea is ""><cfelse>(#AuditArea#)</cfif> is scheduled for a <cfif AuditType is "Quality System">Quality System audit<cfelseif AuditType is "Technical Assessment">Technical Assessment audit<cfelseif AuditType is "Quality System,Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditType is "Quality System, Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditedBy is "AS">audit by #AuditType#</cfif> in <cfif Trim(Month) is 1>January<cfelseif Trim(Month) is 2>February<cfelseif Trim(Month) is 3>March<cfelseif Trim(Month) is 4>April<cfelseif Trim(Month) is 5>May<cfelseif Trim(Month) is 6>June<cfelseif Trim(Month) is 7>July<cfelseif Trim(Month) is 8>August<cfelseif Trim(Month) is 9>September<cfelseif Trim(Month) is 10>October<cfelseif Trim(Month) is 11>November<cfelseif Trim(Month) is 12>December<cfelse></cfif>.

Should you have any questions, please see the Audit details on the IQA website:
http://devweb1.ul.com:8080/departments/snk5212/iqanew/auditdetails.cfm?ID=#ID#&Year=#Year#

Please inform all personnel who are associated with this audit.

to: #Email#, William.R.Carney@ul.com, #RQM#, #QM#, #GM#, #LES#, #Other#, #Other2#, Jola.Wroblewska@ul.com, Ronald.C.Vaickauski@ul.com
</cfmail>

<cfoutput query="selectaudits">
<pre>
This is an email reminder to inform you that #OfficeName# <cfif AuditArea is ""><cfelse>(#AuditArea#)</cfif> is scheduled for a <cfif AuditType is "Quality System">Quality System audit<cfelseif AuditType is "Technical Assessment">Technical Assessment audit<cfelseif AuditType is "Quality System,Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditType is "Quality System, Technical Assessment">Quality System and Technical Assessment audit<cfelseif AuditedBy is "AS">audit by #AuditType#</cfif> in <cfif Trim(Month) is 1>January<cfelseif Trim(Month) is 2>February<cfelseif Trim(Month) is 3>March<cfelseif Trim(Month) is 4>April<cfelseif Trim(Month) is 5>May<cfelseif Trim(Month) is 6>June<cfelseif Trim(Month) is 7>July<cfelseif Trim(Month) is 8>August<cfelseif Trim(Month) is 9>September<cfelseif Trim(Month) is 10>October<cfelseif Trim(Month) is 11>November<cfelseif Trim(Month) is 12>December<cfelse></cfif>.

Should you have any questions, please see the Audit details on the IQA website:
http://devweb1.ul.com:8080/departments/snk5212/iqanew/auditdetails.cfm?ID=#ID#&Year=#Year#

Please inform all personnel who are associated with this audit.
</pre>
<br><hr><br>
</cfoutput>

<cfelse>

</cfif>